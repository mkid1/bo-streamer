# Functionality
[Functionality](https://masterdatatool.gitlab.io/documentation/#/functionality) 

# [Functionality](#/functionality?id=functionality)

* * *

This is a summary of possible scenarios you can use MasterDataTool.

## [MasterLink streaming receiver](#/functionality?id=masterlink-streaming-receiver)

Use MasterDataTool for easily adding network streaming (AirPlay, Spotify, etc.) to your vintage music system like BeoSound 9000, BeoSound 3200, BeoCenter 2, BeoSound 4 and many others.  
In this case you can use MDT for simulating a "SourceCenter" device that provides N.Radio and N.Music sources to the music system.  
For example you can start and AirPlay stream from your phone which then automatically switches on your e.g. BeoSound 9000. You can still use the original Beo4 remote to switch between tracks.  
You can also use common Linux webradio applications for providing internet radio stations to the N.Radio source. This comes with a pretty native feeling as you can continue using your original Beo4 remote to switch between stations whose names are also shown on the display.

## [MasterLink streaming source](#/functionality?id=masterlink-streaming-source)

You fell in love with the design of vintage B&O music systems like BeoSound 9000 but want to integrate it with modern AirPlay based speakers? No problem! You can use MasterDataTool for controlling e.g. the CD playback and at the same time record the audio to distribute it in your IP network.

## [BeoLab 3500 & BeoLab 2000](#/functionality?id=beolab-3500-amp-beolab-2000)

Two lovely active speakers that were developed for secondary rooms and only can be fed through the ML connector. With MasterDataTool you can directly connect to them and controll all functions. Install the shairport-sync AirPlay emulator software on your Raspberry Pi and install the ml-tools applications. Once you the start a stream MDT will automatically switch on your BL3500 or BL2000. Of course you can contine using the original Beo4 remote to change tracks or the volume. Even the clock on BL3500 is always synced with the current time.

## [BeoSystem 3 / TV upgrade](#/functionality?id=beosystem-3-tv-upgrade)

Comming from a legacy ML based TV setup with BeoVision 7 or BeoVision 10 and want to upgrade? Wandering what to do with your music system and the speakers when replacing the TV with something modern?  
Buy a new TV of a brand you like and then use a BeoSystem 3 for audio-only processing. Connect the TV to the BeoSystem 3 over S/PDIF (TOSLink) and use MasterDataTool for handling the translation between ML commands and a network based TV. You can keep the Beo4 remote and everything feels like fully integrated. MDT will receive all remote commands over ML and can help to easily translate them to network commands of e.g. a modern LG TV.

## [DataLink Music Systems](#/functionality?id=datalink-music-systems)

Are you a fan of the "brick era" systems like BeoSystem 6500 / 7000 or BeoCenter 9500 and want to add streaming to it? MasterDataTool can connect to the DAtaLink / Audio Aux Link connector and send any audio strem into those music systems. Similar to the ML devices it can automatically switch on your music system on an incoming stream and you cna continue using the original remotes like BeoLink 5000 or 7000 for changing the tracks.  
Also you can use MasterDataTool for recording any audio of the internal CD play for digital re-distribution - including remote control of course.

## [DataLink Turntables](#/functionality?id=datalink-turntables)

Back in the days B&O used to make fully remote controllable tangential turntables like the BeoGram 7000, 6500, 9500, 4500, 4004 and many others. You can directly connect them to MasterDataTool and so add IP streaming and wireless connectivity to a more hten 30 years old turntable. In such a stand-alone setup you can then easily pipe that audio stream to any AirPlay capable speaker on your network - including full remote control of the turntable like start, stop and changing tracks.

## [MDT Internals](#/functionality?id=mdt-internals)

MasterDataTool relies on a high quality PCM5242 DAC and a sophisticated PCM1862 ADC for the audio path. Both chips are fully symmetrical and supplied by low-noise regulators for optimal audio quality. The audio part of the MDT was designed to be software compatible with the HiFiberry DAC+ADC Pro board that comes with the right driver support on many Raspberry Pi OS distributions.  
The ML communication part consists of a FTDI USB Serial converter the the ML transceiver phy circuit. It connects the the host processor (RPi) over an external USB connection.  
The DataLink connector contains a pair of ADC and DAC signals as well as the 5V based data signal. The DL data signal on MDT is split up in a Rx and a Tx part for easy handling through lirc.

* * *