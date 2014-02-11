raspbmc-pvr
===========

A sideload for Raspbmc that set's up Sabnzbd, Sickbeard, and Couchpotato. So in theory all you have to do is run the setup and answer a few prompts to have everything ready to run.

#### Already got your version of Raspbmc installed, setup, and configured. Skip to step 7.

1. [Download and install](http://www.raspbmc.com/download/) Raspbmc on your pi sd card.
2. Plug in your pi
	1. Insert SD card.
	2. Plug in a keyboard via usb.
	3. Plug in ethernet for internet access.
    4. Attach video to monitor or tv.
    5. Plug in power supply.
3. Wait for Raspbmc to finish network download and initialization (~10-20min)
4. Using the keyboard, finish any setup steps that you are prompted with.
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
	1. Make note of your IP address. This will be needed further down
    2. At this point, you will no longer need direct access to your pi. The following will be done from a seperate machine over your LAN. 
8. From your pc, [download and run](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) Putty ssh client.
	1. When prompted, enter your pi IP address and click Open.
	2. The default username is: _pi_
    3. The default password is: _raspberry_
    4. If this is the first time you have ssh'ed into your pi, it will prompt you for some one time setup. Follow the prompts and answer accordingly.
9. 