timeout 180s python3 -u - <<'PY'
import hashlib
import json
import socket
import sys
import urllib.request
import urllib.error
from email.utils import formatdate
from pathlib import Path

ACCOUNT = "batchstorage007"
CONTAINER = "release-records"
BLOB = "batch-release.csv"
EXPECTED_IP = "10.20.2.4"

HOST = f"{ACCOUNT}.blob.core.windows.net"
BASE_URL = f"https://{HOST}/{CONTAINER}"
LOCAL_FILE = Path("/var/tmp/batch-release.csv")

CSV = """batch_id,min_c,max_c,quality_status
LAB-VAC-001,2.8,6.1,released
LAB-VAC-002,1.2,8.9,quarantined
""".encode("utf-8")

opener = urllib.request.build_opener(
    urllib.request.ProxyHandler({})
)

def request(url, method="GET", headers=None, data=None):
    req = urllib.request.Request(
        url, data=data, headers=headers or {}, method=method
    )
    return opener.open(req, timeout=25)

try:
    print("1. Checking private endpoint DNS...")
    addresses = {
        result[4][0]
        for result in socket.getaddrinfo(
            HOST, 443, socket.AF_INET, socket.SOCK_STREAM
        )
    }
    print("Resolved IPv4 addresses:", ", ".join(sorted(addresses)))

    if addresses != {EXPECTED_IP}:
        raise RuntimeError(
            f"Expected only {EXPECTED_IP}. Stop and check private DNS."
        )

    print("2. Creating the sample CSV on VM-QUALITY...")
    LOCAL_FILE.write_bytes(CSV)
    print("Local file:", LOCAL_FILE)

    print("3. Obtaining the VM managed identity token...")
    token_url = (
        "http://169.254.169.254/metadata/identity/oauth2/token"
        "?api-version=2018-02-01"
        "&resource=https%3A%2F%2Fstorage.azure.com%2F"
    )
    with request(token_url, headers={"Metadata": "true"}) as response:
        token = json.load(response)["access_token"]

    print("Token obtained. Its value will not be displayed.")

    def storage_headers(extra=None):
        headers = {
            "Authorization": f"Bearer {token}",
            "x-ms-version": "2023-11-03",
            "x-ms-date": formatdate(usegmt=True),
        }
        if extra:
            headers.update(extra)
        return headers

    print("4. Creating the container if needed...")
    try:
        with request(
            BASE_URL + "?restype=container",
            method="PUT",
            headers=storage_headers(),
            data=b"",
        ) as response:
            print("Container created: HTTP", response.status)
    except urllib.error.HTTPError as error:
        code = error.headers.get("x-ms-error-code", "")
        if error.code == 409 and code == "ContainerAlreadyExists":
            print("Container already exists; continuing.")
        else:
            raise

    print("5. Uploading batch-release.csv...")
    blob_url = BASE_URL + "/" + BLOB

    try:
        with request(
            blob_url,
            method="PUT",
            headers=storage_headers({
                "x-ms-blob-type": "BlockBlob",
                "Content-Type": "text/csv; charset=utf-8",
                "If-None-Match": "*",
            }),
            data=CSV,
        ) as response:
            print("Upload completed: HTTP", response.status)
    except urllib.error.HTTPError as error:
        code = error.headers.get("x-ms-error-code", "")
        if error.code == 412 and code == "ConditionNotMet":
            print("Blob already exists; preserving and verifying it.")
        else:
            raise

    print("6. Downloading the blob and verifying its contents...")
    with request(blob_url, headers=storage_headers()) as response:
        downloaded = response.read()
        print("Download completed: HTTP", response.status)

    print("Local SHA256:     ", hashlib.sha256(CSV).hexdigest())
    print("Downloaded SHA256:", hashlib.sha256(downloaded).hexdigest())

    if downloaded != CSV:
        raise RuntimeError(
            "Existing blob contents differ from the sample. "
            "Nothing was overwritten; review the existing blob."
        )

    print("PASS: Uploaded data matches the sample CSV.")
    print("Blob:", blob_url)
    print("Verified contents:")
    print(downloaded.decode("utf-8"))

except urllib.error.HTTPError as error:
    print(
        f"FAILED: HTTP {error.code}; "
        f"Azure error: {error.headers.get('x-ms-error-code', 'not supplied')}"
    )
    sys.exit(1)
except Exception as error:
    print(f"FAILED: {error}")
    sys.exit(1)
PY
result=$?
echo "Upload script exit code: $result"
if [ "$result" -eq 124 ]; then
    echo "Stopped after 180 seconds. Check the last numbered step above."
fi
