from sys import stdout
import time
import subprocess
from datetime import datetime

update_freq = 1 #time in seconds

def write(status):
    stdout.write("%s\n" % status)
    stdout.flush()

def clean(output): #converts output from subprocess.check_output into clean string
    return str(output).split("b'")[1].split("\\n'")[0]

def get_now_str():
    now = datetime.now()
    return now.strftime("%Y-%m-%d %H:%M:%S")

def get_battery_stats():
    battery_status, battery_percent, battery_time_remaining = (clean(subprocess.check_output(['acpi'])).split('Battery 0: ')[1].split(', ')+[''])[:3]
    if battery_status == "Discharging":
        battery_icon = '🔋'
    elif battery_status == 'Charging':
        battery_icon = '🔌'
    elif battery_status == 'Full':
        battery_icon = '⚡'
    else:
        battery_icon = '?'
    
    return battery_status, battery_percent, battery_time_remaining, battery_icon

#def get_volume_stats():


username = clean(subprocess.check_output(['whoami']))
i = 0
while True:
    if i == 0 or i % 5 == 0: #update every 5 update_freqs
        battery_status, battery_percent, battery_time_remaining, battery_icon = get_battery_stats()
    if i == 0 or i % 1 == 0: #update every update_freq
        now_str = get_now_str()
    status = f"{battery_icon} [{battery_percent}] {battery_time_remaining} | {username} | {now_str}"
    write(status)
    i += 1
    time.sleep(update_freq)

