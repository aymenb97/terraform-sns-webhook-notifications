import urllib3
import json
import os
http = urllib3.PoolManager()
SLACK_ENDPOINT = os.environ["SLACK_ENDPOINT"]


def lambda_handler(event, context):
    url = SLACK_ENDPOINT
    msg = {
        "Content": event['Records'][0]['Sns']['Message']
    }
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST', url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'],
        "status_code": resp.status,
        "response": resp.data
    })
