raspbmc-pvr
===========

A bolt on process for Raspbmc that **installs** Sabnzbd, Sickbeard, and Couchpotato. Again, this procedure only **installs** all the apps from their Github repositories. Once the apps are running, it is up to you to configure them properly from their respective web apps.

- [Raspbmc Install](#raspbmc-install)
- [Downloader Installs](#downloader-installs)
    - [Sabnzbd](#sabnzbd-installation-skip)
    - [Sickbeard](#sickbeard-installation-skip)
    - [Couchpotato](#couchpotato-installation-skip)
- [Install Verification](#verify-setup)
- [Bonus](#bonus)
    - [Mount Two External USB drives](#mount-two-2-external-usb-drives)
    - [Network Share External USB drive](#network-share-external-usb-drive)

### Raspbmc Install
---

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
1. System -> System Info
	1. Make note of your IP address. This will be needed further down
    2. At this point, you will no longer need direct access to your pi. The following will be done from a seperate machine via ssh. 
2. From your pc, [download and run Putty ssh client](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html).
	1. When prompted, enter your pi IP address and click Open.
	2. The default username is: _pi_
    3. The default password is: _raspberry_
    4. If this is the first time you have ssh'ed into your pi, it will prompt you for some one time setup. Follow the prompts and answer accordingly.
3. Via ssh window
	1. `sudo apt-get update -y`
    2. Wait ~5-10min to complete.
    
#### Sabnzbd installation [skip](#sickbeard-installation-skip)
_via ssh window_

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
    
#### Sickbeard installation [skip](#couchpotato-installation-skip)
_via ssh window_

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

#### Couchpotato installation [skip](#verify-setup)
_via ssh window_

1. `git config --global http.sslVerify false`
2. `git clone https://github.com/RuudBurger/CouchPotatoServer.git .couchpotato`
3. `python .couchpotato/CouchPotato.py`
4. `sudo cp .couchpotato/init/ubuntu /etc/init.d/couchpotato`    
5. `mkdir .couchpotato/data && mkdir .couchpotato/run`
6. `sudo nano /etc/init.d/couchpotato`
7. The above command opens the couchpotato file in a command line file editor called nano.
8. Update to match the following...
	1. `RUN_AS=${CP_USER-pi}`
	2. `APP_PATH=${CP_HOME-/home/pi/.couchpotato/}`
	3. `DATA_DIR=${CP_DATA-/home/pi/.couchpotato/data}`
	4. `PID_FILE=${CP_PIDFILE-/home/pi/.couchpotato/run/couchpotato.pid}`
9. Hit Ctrl+X
10. Hit y
11. Hit Enter    
12. `sudo chmod +x /etc/init.d/couchpotato`
13. `sudo update-rc.d couchpotato defaults`
14. `sudo nano /etc/rc.local`
15. The above command opens the rc.local file in a command line file editor called nano.
16. From there, you should enter the following line ABOVE the last line in the file (`exit 0`):
	1. `sudo service sabnzbdplus start &`
17. Hit Ctrl+X
18. Hit y
19. Hit Enter
20. Couchpotato installation complete.

### Verify setup
---
1. Via ssh window...
	1. `sudo reboot` (wait 2 minutes for everything to cycle)
2. Via pc open the following in a browser...
	1. http://[ip]:8081 - Sickbeard
    2. http://[ip]:8083 - Sabnzbd
    3. http://[ip]:5050 - Couchpotato

### Bonus
---
#### Mount Two (2) External USB drives 

You might ask, 'Why two drives?'. The answer is simple. If you are like me and have multiple media extenders setup around the house, you are going to want to share out your media. With two drives, this makes it easy for one drive to be dedicated to preprocessing, downloading, and post processing (writing) your media while the second is dedicated to streaming (reading) your media. It helps prevent juttering during playback while your pi processes downloaded media.

_via ssh window_

1. Plug in both USB drives
2. `sudo fdisk -l`
	1. The above command will list out your drives
    2. You should see `sda1` and `sdb1`.
    3. For the purposes of this tutorial, we are assuming you want to mount 'sda1' as the primary read drive.
3. Unmount automounted drives
	1. `sudo umount /dev/sda1`
    2. `sudo umount /dev/sdb1`
4. Format the drives
	1. `sudo mkfs.ext3 /dev/sda1`
    	1. This may take a while. (~5min for 1TB)
    2. `sudo mkfs.ext3 /dev/sdb1`
		1. This may take a while. (~5min for 1TB)    
5. Create mount directories for each drive
	1. `mkdir ~/usb_drives/share`
	2. `mkdir ~/usb_drives/temp && mkdir ~/usb_drives/temp/movies`
    3. `sudo chmod 777 -R ~/usb_drives`
6. Get the unique id for each drive
	1. `sudo blkid /dev/sda1 -t TYPE=ext3 -sUUID -ovalue`
    2. Copy down the returned value. For reference, we will refer to this valus as `XXXX`.
    3. `sudo blkid /dev/sdb1 -t TYPE=ext3 -sUUID -ovalue`
    4. Copy down the returned value. For reference, we will refer to this value as `ZZZZ`.
7. `sudo nano /etc/fstab`
8. The above command opens the fstab file in a command line file editor called nano.
9. Add the following lines replacing `XXXX` and `ZZZZ` with the values you noted above.
	1. `UUID=XXXX /home/pi/usb_drives/share ext3 rw,defaults 0 0`
    2. `UUID=ZZZZ /home/pi/usb_drives/temp ext3 rw,defaults 0 0`    
    3. Hit Ctrl+X
    4. Hit y
    5. Hit Enter 

#### Network Share External USB drive
_via ssh window_

1. `sudo apt-get install samba -y`
2. `sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak`
3. `sudo nano /etc/samba/smb.conf`
4. The above command opens the smb.conf file in a command line file editor called nano.
5. At the end of the file enter the following lines...
    1. `[share]`
    2. `comment = Shared Folder`
    3. `path = /home/pi/usb_drives/share`
    4. `public = yes`
    5. `writable = yes`
    6. `available = yes`
    7. `create mask = 777`
    8. `directory mask = 777`
6. Hit Ctrl+X
7. Hit y
8. Hit Enter 
9. `sudo /etc/init.d/samba restart`
10. `sudo update-rc.d -f samba remove`
11. `sudo update-rc.d samba defaults`

*[top](#raspbmc-pvr)*