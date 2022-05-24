from email import message
from sqlite3 import Timestamp
from time import time
import urllib3
import json
import os
http = urllib3.PoolManager()
SLACK_ENDPOINT = os.environ["SLACK_ENDPOINT"]


def lambda_handler(event, context):
    message_json = json.loads(event['Records'][0]['Sns']['Message'])
    url = SLACK_ENDPOINT
    m = "Name: {name} \n Description: {description} \n State : {state} \n Reason: {reason} \n Timestamp: {timestamp}"
    msg = {
        "text": m.format(name=message_json["AlarmName"], description=message_json["AlarmDescription"], state=message_json["NewStateValue"], reason=message_json["NewStateReason"], timestamp=message_json["StateChangeTime"])
    }
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST', url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'],
        "status_code": resp.status,
        "response": resp.data
    })
