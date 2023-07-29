"""
Lambda@Edge for authentication
"""

import base64


def authenticate(user, password):
    return user == "admin" and password == "passW0rd"


def handler(event, context):
    request = event["Records"][0]["cf"]["request"]
    headers = request["headers"]

    error_response = {
        "status": "401",
        "statusDescription": "Unauthorized",
        "body": "Authentication Failed",
        "headers": {
            "www-authenticate": [
                {
                    "key": "WWW-Authenticate",
                    "value": 'Basic realm="Basic Authentication"',
                }
            ]
        },
    }

    if "authorization" not in headers:
        return error_response

    try:
        auth_values = headers["authorization"][0]["value"].split(" ")
        auth = base64.b64decode(auth_values[1]).decode().split(":")
        (user, password) = (auth[0], auth[1])
        return request if authenticate(user, password) else error_response
    except Exception:
        return error_response
