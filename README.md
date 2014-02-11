raspbmc-pvr
===========

A sideload for Raspbmc that set's up Sabnzbd, Sickbeard, and Couchpotato. So in theory all you have to do is run the setup and answer a few prompts to have everything ready to run.

#### Already got your version of Raspbmc installed, setup, and configured? Skip to step 7.

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
9. Via ssh window
	1. `sudo apt-get update -y`
    2. Wait ~5-10min to complete.
10. Sickbeard installation
    1. `sudo apt-get install python-cheetah git git-core transmission-daemon -y`
    2. `git clone git://github.com/midgetspy/Sick-Beard.git .sickbeard`
    3. `sudo nano /etc/rc.local`
    4. The above command opens the rc.local file in a command line file editor called nano.
    5. From there, you should enter the following line above the line starting with `exit 0`:
    	1. `python /home/pi/.sickbeard/SickBeard.py -d`
    6. Hit Ctrl+X
    7. Hit y
    8. Hit Enter
    9. Sickbeard installation complete.
11. Sabnzbd installation (via ssh window)
	1. `sudo apt-get install sabnzbdplus`
    2. `sudo nano /etc/default/sabnzbdplus`
    3. The above command opens the sabnzbdplus file in a command line file editor called nano.
    4. Update with the following:
    	1. `USER=pi`
        2. `HOST=0.0.0.0`
    	3. `PORT=8083`
    5. Hit Ctrl+X
    6. Hit y
    7. Hit Enter
    8. Sabnzbd installation complete.
11. Couchpotato installation (via ssh window)
	1. `git config --global http.sslVerify false`
    2. `git clone https://github.com/RuudBurger/CouchPotatoServer.git .couchpotato`
    3. `python .couchpotato/CouchPotato.py'
    3. `sudo cp .couchpotato/init/ubuntu /etc/init.d/couchpotato`    
    4. `mkdir .couchpotato/data && mkdir .couchpotato/run`
    5. `sudo nano /etc/init.d/couchpotato`
    6. The above command opens the couchpotato file in a command line file editor called nano.
    7. Update with the following:
    	1. `RUN_AS=${CP_USER-pi}`
        2. `APP_PATH=${CP_HOME-/home/pi/.couchpotato/}`
        3. `DATA_DIR=${CP_DATA-/home/pi/.couchpotato/data}`
        4. `PID_FILE=${CP_PIDFILE-/home/pi/.couchpotato/run/couchpotato.pid}`
    8. Hit Ctrl+X
    9. Hit y
    10. Hit Enter    
    11. Couchpotato installation complete.
    