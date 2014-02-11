raspbmc-pvr
===========

A sideload for Raspbmc that set's up Sabnzbd, Sickbeard, and Couchpotato. So in theory all you have to do is run the setup and answer a few prompts to have everything ready to run.

#### Already got your version of Raspbmc installed, setup, and configured. Skip to step 8.

1. [Download and install](http://www.raspbmc.com/download/) Raspbmc on your pi sd card.
2. Plug in your pi
	1. Insert SD card.
	2. Plug in a keyboard via usb.
	3. Plug in ethernet for internet access.
    4. Attach video to monitor or tv.
    5. Plug in power supply.
3. Wait for Raspbmc to finish network download and initialization (~10-20min)
4. Using the keyboard finish any setup steps that you are prompted with.
5. System -> Settings -> Services ->
	1. UPnP
    	1. Share video and music libraries ... [ENABLE]
        2. Allow control of XBMC via UPnP  ... [ENABLE]
    2. Remote Control
    	1. Allow programs on other systems ... [ENABLE]
    3. AirPlay
    	1. Allow XBMC to receive AirPlay   ... [ENABLE]
6. Programs -> Raspbmc Settings -> System Configuration
	1. Disable unsafe shut down warning    ... [ENALBE]
7. System -> System Info
	1. **Make note of your IP address. This will be needed further down**
---
  
#### At this point your XBMC is setup and configured to a base starting point.
  
---  
asdsa

