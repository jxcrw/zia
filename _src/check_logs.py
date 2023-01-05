#!/usr/bin/env python3
"""Check log files and send email if any bad stuff happened"""

from datetime import datetime
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

import json
import os
import smtplib
import sys


# ┌─────────────────────────────────────────────────────────────────────────────
# │ Setup
# └─────────────────────────────────────────────────────────────────────────────
computer = os.environ['COMPUTERNAME']
log_dir = r'C:\~\.zia\.logs'
os.chdir(log_dir)

with open(r'C:\~\.zia\secrets.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
gmail_user = data['gmail_user']
gmail_password = data['gmail_password']

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Inspect Logs
# └─────────────────────────────────────────────────────────────────────────────
for root, dirs, files in os.walk(log_dir):
    logs = files

output = []
for log in logs:
    with open(log, 'r', encoding='utf-8') as f:
        data = [line.strip() for line in f][:10]
    if data:
        data = [''] + data + ['']
        data = '\n       '.join(data)
        output.append(f'• {log}\n{data}')
    else:
        os.remove(log)
output = '\n\n'.join(output)

# ┌─────────────────────────────────────────────────────────────────────────────
# │ Send Summary Email
# └─────────────────────────────────────────────────────────────────────────────
if output:
    msg = MIMEMultipart('alternative')
    msg["Subject"] = f"{computer} Log Alert"
    msg["From"] = gmail_user
    msg["To"] = gmail_user

    text = f"The following logs may require your attention:\n\n{output}"
    mime_text = MIMEText(text)
    msg.attach(mime_text)

    try:
        smtp_server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        smtp_server.ehlo()
        smtp_server.login(gmail_user, gmail_password)
        smtp_server.sendmail(gmail_user, gmail_user, msg.as_string())
        smtp_server.close()
        print("Email sent!")
    except Exception as e:
        error = f'{datetime.now():%Y-%m-%d %H:%M:%S}: {e}'
        print(error, file=sys.stderr)
