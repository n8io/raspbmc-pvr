raspbmc-pvr
===========

A tutorial for Raspbmc that **installs** Sabnzbd, Sickbeard, and Couchpotato. Again, this procedure only **installs** all the apps from their Github repositories. Once the apps are running, it is up to you to configure them properly from their respective [web apps](#verify-setup).

- [Raspbmc Install](#raspbmc-install)
- [Downloader Installs](#downloader-installs)
    - [Sabnzbd](#sabnzbd-installation-skip)
    - [Sickbeard](#sickbeard-installation-skip)
    - [Couchpotato](#couchpotato-installation-skip)
- [Install Verification](#verify-setup)
- [Bonus](#bonus)
    - [Mount Two External USB drives](#mount-two-2-external-usb-drives)
    - [Network Share External USB drive](#network-share-external-usb-drive)
    - [Shared XBMC Library](#shared-xbmc-library)

### Raspbmc Install
---
_Total Time: ~15min_

**via pc**

1. [Download and install](http://www.raspbmc.com/download/) Raspbmc on your pi sd card.

**via pi**

1. Ready your pi for first boot...
	1. Insert SD card.
	2. Plug in a keyboard via usb.
	3. Plug in ethernet for internet access.
    4. Attach video to monitor or tv.
    5. Plug in power supply.
2. Wait for Raspbmc to finish network download and initialization (~10-20min)
3. Using the keyboard, finish any setup steps that you are prompted with.
4. System -> Settings -> Services -> 
	1. UPnP
    	1. Share video and music libraries ... :large_blue_circle:
        2. Allow control of XBMC via UPnP  ... :large_blue_circle:
    2. Remote Control
    	1. Allow programs on other systems ... :large_blue_circle:
    3. AirPlay
    	1. Allow XBMC to receive AirPlay   ... :large_blue_circle:
5. Programs -> Raspbmc Settings -> System Configuration
	1. Disable unsafe shut down warning    ... :large_blue_circle:

:large_blue_circle: Enable :white_circle: Disable

### Downloader Installs
---
_Total Time: ~15min_

1. From your pi, System -> System Info
	1. Make note of your IP address. This will be needed further down
    2. At this point, you will no longer need direct access to your pi. The following will be done from a seperate machine via ssh. 
2. From your pc, [download and run Putty ssh client](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html).
	1. When prompted, enter your pi IP address and click Open.
	2. The default username is: `pi`
    3. The default password is: `raspberry`
    4. If this is the first time you have ssh'ed into your pi, it will prompt you for some one time setup. Follow the prompts and answer accordingly.
3. Via ssh window
	1. `sudo apt-get update -y`    
    2. `sudo apt-get install unrar par2 -y`  
    
#### Sabnzbd installation [skip](#sickbeard-installation-skip)
_Total Time: ~5min_

**via ssh window**

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

[More details on Sabnzbd](http://www.sabnzbd.org)

#### Sickbeard installation [skip](#couchpotato-installation-skip)
_Total Time: ~5min_

**via ssh window**

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

[More details on Sickbeard](http://sickbeard.com/)

#### Couchpotato installation [skip](#verify-setup)
_Total Time: ~5min_

**via ssh window**

1. `git config --global http.sslVerify false`
2. `git clone https://github.com/RuudBurger/CouchPotatoServer.git .couchpotato`
3. `python .couchpotato/CouchPotato.py`
4. `sudo cp .couchpotato/init/ubuntu /etc/init.d/couchpotato`    
5. `mkdir .couchpotato/data && mkdir .couchpotato/run`
6. `sudo nano /etc/init.d/couchpotato`
7. The above command opens the couchpotato file in a command line file editor called nano.
8. Update to match the following...
	
    ```
	RUN_AS=${CP_USER-pi}
	APP_PATH=${CP_HOME-/home/pi/.couchpotato/}
	DATA_DIR=${CP_DATA-/home/pi/.couchpotato/data}
	PID_FILE=${CP_PIDFILE-/home/pi/.couchpotato/run/couchpotato.pid}
    ```
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

[More details on Couchpotato](https://couchpota.to/)

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
_Total Time: ~30min_

You might ask, 'Why two drives?'. The answer is simple. If you are like me and have multiple media extenders setup around the house, you are going to want to share out your media. With two drives, this makes it easy for one drive to be dedicated to preprocessing, downloading, and post processing (writing) your media while the second is dedicated to streaming (reading) your media. It helps prevent juttering during playback while your pi processes downloaded media.

**via ssh window**

1. Plug in both USB drives
2. `sudo fdisk -l`
	1. The above command will list out your drives
    2. You should see `sda1` and `sdb1`.
    3. For the purposes of this tutorial, we are assuming you want to mount `sda1` as the primary read drive.
3. Unmount automounted drives
	1. `sudo umount /dev/sda1`
    2. `sudo umount /dev/sdb1`
4. Format the drives
	1. `sudo mkfs.ext3 /dev/sda1`
    	1. This may take a while. (~10min for 1TB)
    2. `sudo mkfs.ext3 /dev/sdb1`
		1. This may take a while. (~10min for 1TB)    
5. Create mount directories for each drive
	1. `mkdir ~/usb_drives/share`
	2. `mkdir ~/usb_drives/temp`
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
10. `sudo reboot`
11. Wait 2 minutes for everything to cycle
12. Verify everything mounted correctly...
	1. `df -H`
    2. You should see your drives mounted and in their respective 'Mounted on' directories.
12. Create media directories
	1. `sudo mkdir ~/usb_drives/share/tv`
	2. `sudo mkdir ~/usb_drives/share/music`
	3. `sudo mkdir ~/usb_drives/share/movies`
    4. `sudo mkdir ~/usb_drives/temp/incomplete`
    5. `sudo mkdir ~/usb_drives/temp/complete`
13. Give full read/write access to `~/usb_drives`
	1. `sudo chmod -R a+rwx ~/usb_drives`

#### Network Share External USB drive
_Total Time: 5min_

**via ssh window**

1. `sudo apt-get install samba -y`
2. `sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak`
3. `sudo nano /etc/samba/smb.conf`
4. The above command opens the smb.conf file in a command line file editor called nano.
5. Underneath the `[global]` section, update these 2 lines to match...

	```
    [global]
      security=share
      #security=user
    ```
6. At the end of the file enter the following lines...

	```    
    [share]
        comment = Shared Folder
    	path = /home/pi/usb_drives/share
    	guest ok = yes
    	guest account = pi
    	writable = yes
    	available = yes
    	create mask = 777
    	directory mask = 777
    ```
7. Hit Ctrl+X
8. Hit y
9. Hit Enter 
10. `sudo /etc/init.d/samba restart`
11. `sudo update-rc.d -f samba remove`
12. `sudo update-rc.d samba defaults`

#### Shared XBMC library
_Total Time: ~10min_

**via ssh window**

1. `sudo apt-get install mysql-server -y`
2. You will be prompted to enter a MySQL "root" user pwd...
	1. Type `xbmc` (note you will not see anything change on the prompt, input is hidden)
    2. Hit Enter.
    3. Re-enter `xbmc`
    4. Hit Enter.
    5. Wait ~5min to finish installing MySQL.
3. `sudo nano /etc/mysql/my.cnf`
4. The above command opens the my.conf file in a command line file editor called nano.
5. Update to match the following lines...
	1. `bind-address = 0.0.0.0`
6. Hit Ctrl+X
7. Hit y
8. Hit Enter 
9. `sudo /etc/init.d/mysql start`
10. `mysql -u root -p`
11. You will be prompted Enter password:
	1. Type `xbmc`
    2. Hit Enter.
12. You are now in an interactive MySQL session.
13. `CREATE USER 'xbmc' IDENTIFIED BY 'xbmc';`
14. `GRANT ALL ON *.* TO 'xbmc';`
15. Type `\q`
16. Hit Enter.
17. `sudo nano ~/.xbmc/userdata/advancedsettings.xml`
18. The above command opens the advancedsettings.xml file in a command line file editor called nano.
19. Enter the following lines...

	```xml
    <advancedsettings>
      <videodatabase>
        <type>mysql</type>
        <host>127.0.0.1</host>
        <port>3306</port>
        <user>xbmc</user>
        <pass>xbmc</pass>
      </videodatabase> 
      <musicdatabase>
        <type>mysql</type>
        <host>127.0.0.1</host>
        <port>3306</port>
        <user>xbmc</user>
        <pass>xbmc</pass>
      </musicdatabase>
      <videolibrary>
        <importwatchedstate>true</importwatchedstate>
      </videolibrary>
    </advancedsettings>
    ```
20. Hit Ctrl+X
21. Hit y
22. Hit Enter 

*[back to top](#raspbmc-pvr)*