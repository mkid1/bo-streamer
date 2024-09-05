# Getting Started
[Getting Started](https://masterdatatool.gitlab.io/documentation/#/setup) 

# [Getting Started](#/setup?id=getting-started)

* * *

## [Package content](#/setup?id=package-content)

MasterDataTool comes with the following items:

-   MasterDataTool PCB assembly
-   DIY housing consisting of three 3D-printed plastic parts and 8 screws
-   USB-A to USB-C cable (15 cm)
-   RJ45 CAT6 network cable (1.5 m)
-   ML &lt;-> RJ45 plug-in adapter
-   Short manual/quick start guide

Following items are not included. Please obtain them separately:

-   Raspberry Pi single board computer (version 2 / 3 / 4 / 5)
-   microSD card for the operating system
-   power supply (recommended to use the official RPi ones)

* * *

## [Assembling](#/setup?id=assembling)

Follow those steps to mechanically assemble your MasterDataTool

-   put the Raspberry Pi into the larger plastic shell
-   while holding the small plastic frame against the upper side of the RPi insert four screws on the bottom
-   plug-in the MasterDataTool PCB on top of the 40-way pin connector of the RPi
-   use the remaining 4 screws for mounting the 3rd plastic part on top

![](https://masterdatatool.gitlab.io/documentation/_media/mdt-assy.gif)

* * *

## [Preparing the RPi](#/setup?id=preparing-the-rpi)

Flash the RPi operating system to the microSD card

-   we recommend using the official Raspberry Pi Imager
-   choose your Raspberry Pi board version
-   select the operating system (the light version available from "Raspberry Pi OS (other)" is recommended)
-   click NEXT, then on EDIT SETTINGS
-   set a custom hostname
-   enter a username and a password
-   check "configure wireless lan" and enter your credentials if you are not using ethernet
-   select the correct timezone and region
-   go to the SERVICES tab and enable SSH with password authentication
-   click SAVE, then YES
-   the application will let you know once the SD card is ready

First power up

-   insert the microSD card into the RPi + MDT assembly
-   connect the short USB-A to USB-C cable between a free USB port on your RPi and the MasterDataTool
-   attach the MasterLink or DataLink cable
-   plug in the power supply and wait a moment until the RPi booted and connected to your network

From here on we are considering that the Raspberry Pi is working correctly and automatically connects to your network. If something doesn't work straight away have a look at the RPi documentation.

* * *

## [Installing dependencies](#/setup?id=installing-dependencies)

To use the software tools we are providing some configurations need to be made:

-   Connect to your Raspberry using ssh
    -   `ssh your_username@your_hostname.local -p 22`
-   Install a few dependencies with
    -   `sudo apt-get update`
    -   `sudo apt-get install git redis python3-redis python3-serial lirc`

* * *

## [Installing ML and DL tools](#/setup?id=installing-ml-and-dl-tools)

Install the demo software we are providing:

-   following installs the toolset needed for master link communication

    -   `git clone https://gitlab.com/masterdatatool/software/ml-tools`
    -   `cd ml-tools`
    -   `chmod +x install.sh`
    -   `sudo ./install.sh`
    -   `sudo cp rpi/config.txt /boot/config.txt`
-   following installs the toolset needed for datalink communication

    -   `git clone https://gitlab.com/masterdatatool/software/dl-tools`
    -   `cd dl-tools`
    -   `chmod +x install.sh`
    -   `sudo ./install.sh`
    -   `sudo cp rpi/config.txt /boot/config.txt`

If you visit the ml-tools and the dl-tools Gitlab repository websites there are in-depth explanations of everything.

Nevertheless, if you successfully installed everything from above and run either of the next commands you are more or less set.

-   if you want to use MDT with a stand-alone link speaker like BL3500 or BL2000:
    -   `sudo systemctl enable ml-linkspeaker-standalone`
-   if you want to use MDT with a music system like BS9000 or BC2 use instead:
    -   `sudo systemctl enable ml-netprovide`

Don't forget to reboot with the following command afterwards `sudo reboot`

* * *

## [Music streaming services](#/setup?id=music-streaming-services)

The commands from above will automatically enable and disable any connected link speaker or music system once there is an audio stream detected.

So for example you can install shairport-sync which is an excellent AirPlay-compatible streaming receiver.

`sudo apt-get install shairport-sync`

Once you start streaming the MasterDataTool software will automatically switch on any ML-connected device and switch it off again once the stream stops.

In case you are using it with a music system it will also forward metadata from shairport-sync to the MasterLink device.

* * *

## [Where to go from here](#/setup?id=where-to-go-from-here)

The software tools we are currently providing should be considered in the early alpha stage. They are working fine for the few scenarios we tested so far.

If something doesn't work straight away have a look in the source code and make changes the way you like. There are many possible scenarios and the software only covers a few of them so far. Of course, you can also contact us when you are running into issues but we might not be able exactly reproduce every possible setup here.

The ml-tools software repository also contains a tool called ml-debug. Use it to have a real-time look into the messages currently being received or sent.

* * *

\_MasterDataTool documentation by [PolyVection](https://polyvection.com/).  
Visit our [Imprint](https://polyvection.com/imprint/) or contact us on [info@polyvection.com](mailto:info@polyvection.com) if you have any questions.  

PolyVection is completely unrelated to Bang & Olufsen a/s. Their brand and product names are only used for showing compatability.  
All rights belong to their respective owners.\_