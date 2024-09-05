# Compatability
[Compatability](https://masterdatatool.gitlab.io/documentation/#/compatability) 

# [Compatability](#/compatability?id=compatability)

MasterDataTool is compatible with following devices.  
Depending on the firmware version of the product not all features may be available.

## [Music Systems (MasterLink)](#/compatability?id=music-systems-masterlink)

Most MasterLink-equipped music systems were already prepared for IP streaming by using N.Radio and N.Music source keys. They will ask on the MasterLink bus for them and MasterDataTool will answer/provide them. From a UX perspective, they will feel built-in. You can have web radio favorites, next/previous title user input, and metadata display functions. Independent from the N.Radio / N.Music sources you will always be able to fully control all internal functions through MasterLink and also extract sound from built-in sources like the CD player.

-   BeoSound 9000
    -   _MK1 and MK2 units needs to have SW 4.2 or higher for N.Music / N.Radio_
    -   _MK3 (2001 - 2011) supports those sources from factory_
    -   _if you don't want to update the SW instead you might want to use the TV & SAT sources for internal IP streaming_
-   BeoSound 3000 / 3200
    -   _similar to BS9000 when using N.Radio/N.Music. MK1 needs at least SW 1.34a. MK2 should be okay from factory_
-   BeoSound Overture / BeoSound 4000
    -   _unknown if N.Radio/Music is possible by updating SW_
    -   _might also not respond to MLGW remote commands but should be able to work around by using a virtual ML node requesting sources and functions_
-   BeoSound 5 / BeoMaster 5
    -   _might not be able to handle external N.Radio / N.Music sources - still needs to be confirmed. TV / SAT work around always functions._
-   BeoSound 4
    -   _N.Radio and N.Music support from factory_
    -   _extensive metadata visualistaion_
    -   _only music system that wil also forward received "Light" remote commands to the ML bus (SW 2.15 / 32.15 and above)_
-   BeoCenter 2
    -   _N.Radio and N.Music support from factory_
    -   _extensive metadata visualistaion_

## [Music Systems (DataLink)](#/compatability?id=music-systems-datalink)

DataLink was the protocol used before MasterLink. So the technically older generation without support for N.Music / N.Radio. In any case, you can still inject control commands and audio streams either using the "Audio Aux Link" simulating a TV. Sources will also feel built-in with forwarding of favorite key, next/previous title. As with MasterLink devices audio is bi-directional so you can also digitalise the audio output.

Please note that when using MDT to send an audio stream to your music system using the Aux connector there is one minor limitation. With MDT you can automatically switch on the music system using a DL86 command but it will start up in "muted" state. So far no DL86 command was discovered that could overcome this. So you have to unmute it pressing a random key (on the deivce or via the IR remtote). All other commands including volume control can be sent through MDT without issues. Also you can read all status messages the music system distributes.

-   BeoCenter 2300 / 2500
-   BeoCenter 9000 / 9300 / 9500
-   BeoSystem 5000 / 5500 / 6500 / 7000
-   BeoSystem 4500
-   BeoSystem 3300
-   BeoMaster 5000 / 5500 / 6500 / 7000
-   BeoMaster 6000 / 8000

## [Accessories (MasterLink)](#/compatability?id=accessories-masterlink)

The following devices were sold as LinkRoom products / multiroom nodes. They were installed in secondary rooms and connected to the main room using the MasterLink cable. You can directly connect them to MasterDataTool and convert them to a streaming receiver. They also feature local buttons and IR receivers which are handy for controlling the stream or selecting pre-set favorites. MasterDataTool is also able to synchronise the internal clock of BL3500 / LCS9000 to show the current time.

-   BeoLab 3500 / LCS 9000
    -   _stereo active speaker with IR receiver and display_
-   BeoLab 2000
    -   _stereo active speaker with IR receiver and buttons_
-   BeoLink Passive
    -   _stereo amplifier with external IR receiver for passive speakers_
-   BeoLink Active
    -   _like above, just for active speakers_

## [Accessories (DataLink)](#/compatability?id=accessories-datalink)

-   BeoGram CD 50 / 3300 / 5500 / 6500 / 7000
    -   _external CD players_
-   BeoGram 4004 / 4500 / 5500 / 6500 / 7000
    -   _external turntables_
    -   _some may require an external RIAA phono preamp_
-   BeoGram 6002 / 8002
    -   _external turntables_
    -   _some may require an external RIAA phono preamp_
-   BeoCord 5500 / 6500 / 7000
    -   _external cassette decks_

## [Televisions (MasterLink)](#/compatability?id=televisions-masterlink)

-   BeoSystem 3
    -   _A/V processor still relevant for surround audio processing nowadays_
-   BeoVision Avant
    -   _old generation / tube_
-   BeoVision 6-23 / 6-26
-   BeoVision 7-32 / 7-40 / 7-55
-   BeoVision 10-32 / 10-40 / 10-46
-   all other units with a MasterLink connector

## [Televisions (DataLink)](#/compatability?id=televisions-datalink)

-   BeoVision MX series often used for retro gaming
-   probably many more / check for the "Audio Aux Link" connector

* * *

\_MasterDataTool documentation by [PolyVection](https://polyvection.com/).  
Visit our [Imprint](https://polyvection.com/imprint/) or contact us on [info@polyvection.com](mailto:info@polyvection.com) if you have any questions.  

PolyVection is completely unrelated to Bang & Olufsen a/s. Their brand and product names are only used for showing compatability.  
All rights belong to their respective owners.\_