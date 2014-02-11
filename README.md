raspbmc-pvr
===========

A bolt on process for Raspbmc that set's up Sabnzbd, Sickbeard, and Couchpotato. Note that this procedure _properly installs all the apps_ from their Github repositories. Once the apps are running, it is up to you to configure them properly from their respective web apps.

### Raspbmc Install
---
Already installed? Skip ahead to [Downloader Installs](#downloader-installs).

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
	1. Disable unsafe shut down warning    ... [ENABLE]

### Downloader Installs
---
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
    
#### Sickbeard installation (via ssh window)
1. `sudo apt-get install python-cheetah git git-core transmission-daemon -y`
2. `git clone git://github.com/midgetspy/Sick-Beard.git .sickbeard`
3. `sudo nano /etc/rc.local`
4. The above command opens the rc.local file in a command line file editor called nano.
5. From there, you should enter the following line ABOVE the last line in the file (`exit 0`):
1. `python /home/pi/.sickbeard/SickBeard.py -d`
6. Hit Ctrl+X
7. Hit y
8. Hit Enter
9. Sickbeard installation complete.
    
#### Sabnzbd installation (via ssh window)
1. `sudo apt-get install sabnzbdplus`
2. `sudo nano /etc/default/sabnzbdplus`
3. The above command opens the sabnzbdplus file in a command line file editor called nano.
4. Update to match the following...
	1. `USER=pi`
	2. `HOST=0.0.0.0`
	3. `PORT=8083`
5. Hit Ctrl+X
6. Hit y
7. Hit Enter
8. Sabnzbd installation complete.
    
#### Couchpotato installation (via ssh window)
1. `git config --global http.sslVerify false`
2. `git clone https://github.com/RuudBurger/CouchPotatoServer.git .couchpotato`
3. `python .couchpotato/CouchPotato.py`
3. `sudo cp .couchpotato/init/ubuntu /etc/init.d/couchpotato`    
4. `mkdir .couchpotato/data && mkdir .couchpotato/run`
5. `sudo nano /etc/init.d/couchpotato`
6. The above command opens the couchpotato file in a command line file editor called nano.
7. Update to match the following...
	1. `RUN_AS=${CP_USER-pi}`
	2. `APP_PATH=${CP_HOME-/home/pi/.couchpotato/}`
	3. `DATA_DIR=${CP_DATA-/home/pi/.couchpotato/data}`
	4. `PID_FILE=${CP_PIDFILE-/home/pi/.couchpotato/run/couchpotato.pid}`
8. Hit Ctrl+X
9. Hit y
10. Hit Enter    
11. `sudo chmod +x /etc/init.d/couchpotato`
12. `sudo update-rc.d couchpotato defaults`
13. `sudo nano /etc/rc.local`
14. The above command opens the rc.local file in a command line file editor called nano.
15. From there, you should enter the following line ABOVE the last line in the file (`exit 0`):
	1. `sudo service sabnzbdplus start &`
16. Hit Ctrl+X
17. Hit y
18. Hit Enter
19. Couchpotato installation complete.

### Verify setup
---
12. Via ssh window...
	1. `sudo reboot` (wait 2 minutes for everything to cycle)
13. Via pc open the following in a browser...
	1. http://[ip]:8081 - Sickbeard
    2. http://[ip]:8083 - Sabnzbd
    3. http://[ip]:5050 - Couchpotato
    