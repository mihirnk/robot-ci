#!/usr/bin/python3
from gpiozero import LED
import signal
import sys

pin6 = LED(6)

def signal_handler(sig, frame):
    print("Turning off pin 6...")
    pin6.off()
    sys.exit(0)

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    
    pin6.on()
    print("Pin 6 turned on")
    
    try:
        signal.pause()
    except KeyboardInterrupt:
        signal_handler(signal.SIGINT, None)