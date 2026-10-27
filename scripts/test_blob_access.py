# Purpose: Verify Blob read access using VM-QUALITY's managed identity.
# Run in Azure Portal > VM-QUALITY > Run command > RunShellScript.
# Requires Python 3, Storage Blob Data Reader, and private connectivity.
# Expected result: HTTP 200, CSV contents, PASS, and exit code 0.
# Storage account name and network settings are specific to this lab.
# No credentials are embedded; the identity token is obtained at runtime.

MODE=read timeout 90s python3 -u - <<'PY'
import json
import socket
import sys
import uuid
import os
import urllib.request
import urllib.error
from email.utils import formatdate

mode = os.environ.get("MODE", "read")
host = "batchstorage007.blob.core.windows.net"
base = "https://" + host + "/release-records/"

opener = urllib.request.build_opener(
    urllib.request.ProxyHandler({})
)

def call(url, headers, method="GET", data=None):
    req = urllib.request.Request(
        url,
        headers=headers,
        method=method,
        data=data
    )
    return opener.open(req, timeout=20)

try:
    addresses = {
        result[4][0]
        for result in socket.getaddrinfo(
            host, 443, socket.AF_INET, socket.SOCK_STREAM
        )
    }
    print("DNS:", sorted(addresses), flush=True)

    if addresses != {"10.20.2.4"}:
        raise RuntimeError(
            "Unexpected DNS answer; stop and investigate"
        )

    token_url = (
        "http://169.254.169.254/metadata/identity/oauth2/token"
        "?api-version=2018-02-01"
        "&resource=https%3A%2F%2Fstorage.azure.com%2F"
    )

    with call(token_url, {"Metadata": "true"}) as response:
        token = json.load(response)["access_token"]

    print(
        "Managed identity token acquired; not displayed",
        flush=True
    )

    headers = {
        "Authorization": "Bearer " + token,
        "x-ms-version": "2023-11-03",
        "x-ms-date": formatdate(usegmt=True)
    }

    with call(base + "batch-release.csv", headers) as response:
        body = response.read()
        print("READ HTTP", response.status)
        print(body.decode("utf-8"))

    if mode == "read":
        print("PASS: authenticated read succeeded")

    elif mode == "write-denial":
        name = "permission-probe-" + uuid.uuid4().hex + ".txt"

        headers.update({
            "x-ms-blob-type": "BlockBlob",
            "If-None-Match": "*"
        })

        try:
            with call(
                base + name,
                headers,
                "PUT",
                b"lab permission test"
            ) as response:
                print(
                    "FAIL: write still permitted; HTTP",
                    response.status
                )

            print("Probe created:", name)
            print(
                "Keep this name for cleanup; "
                "no release data was changed"
            )
            sys.exit(2)

        except urllib.error.HTTPError as error:
            error_code = error.headers.get("x-ms-error-code", "")
            print("WRITE HTTP", error.code, error_code)

            if (
                error.code == 403
                and error_code == "AuthorizationPermissionMismatch"
            ):
                print(
                    "PASS: read succeeded and write permission was denied"
                )
            else:
                raise

    else:
        raise RuntimeError("MODE must be read or write-denial")

except urllib.error.HTTPError as error:
    print(
        "FAIL HTTP",
        error.code,
        error.headers.get("x-ms-error-code", "")
    )
    sys.exit(1)

except Exception as error:
    print("FAIL:", str(error))
    sys.exit(1)
PY
result=$?
echo "Test exit code: $result"
if [ "$result" -eq 124 ]; then
    echo "The test exceeded 90 seconds. Check the last message above."
fi
