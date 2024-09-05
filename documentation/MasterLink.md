# MasterLink
[MasterLink](https://masterdatatool.gitlab.io/documentation/#/masterlink) 

# [MasterLink](#/masterlink?id=masterlink)

## [Intro](#/masterlink?id=intro)

The second version of B&O's multiroom interconnection bus. It was introduced in the early 1990s and the last ML-equipped devices must have been sold around 2014. Similar to DataLink it was used for linking music systems to the TV speakers as well as for the home-wide audio distribution. From the technological side, it was quite a leap forward compared to the older system. Audio and data signals now both were exchanged symmetrical and bi-directional. Data transmission takes place on +/- 0.25 V signal levels to prevent cross-talk with the nearby audio cables. Also, the data protocol itself has a lot more features here.

* * *

## [Audio Signals](#/masterlink?id=audio-signals)

As already mentioned audio is symmetrical and bi-directional. Standard +/- 2 Vrms makes it easy to interface it with modern and highly integrated DACs and ADCs. The vintage devices are internally working with single-ended audio which is then converted to symmetrical using some standard OP amps. Analog switches are used for selecting the direction of the audio signals on the ML connector.

The MasterDataTool uses a TI PCM5242 DAC along with a TI PCM1862 ADC. Two well-performing parts that both bring symmetrical functionality right from the start. In standby mode, the PCM5242 switches its outputs to HiZ mode which makes it possible to directly connect it to the ML connector without analogue switches in between.

* * *

## [Data Signals](#/masterlink?id=data-signals)

When ML was developed special care was taken to prevent cross-talk with audio as far as possible. This is the reason we are seeing those low 0.5 Vpp voltage levels. Master devices like music systems and TVs would provide that logic 1 voltage to the data lines. For data transmission the data +/- signals are then shorted together by any master or slave device resulting in a logic 0. Slave devices would detect if an ML cable was plugged by a separate ML power signal that can be between 7 to 15 V (citing the original manual)

MasterDataTool orients on the original hardware for the sending, receiving, and bus power circuits. The ML power signal was kept at 5 V level which is still enough to trigger the ML detect circuit of the slave devices.

* * *

## [Data Protocol](#/masterlink?id=data-protocol)

In general ML data transmission is similar to standard UART at 19200 baud. Just in a half-duplex configuration where Tx and Rx are joined together. Despite the low voltage levels, another thing that makes it a bit hard to interface with modern devices is the special parity bit.

A message (also called telegram in their terms) can have an arbitrary length. Bytes are being transmitted with space parity which is not really in use nowadays. The first as well as the last byte is sent with mark parity instead. Back in the day that was not an uncommon practice. Computing power was limited so with a trick they overcame polling the bus permanently. The receiving parity is always set to space parity waiting for a parity error interrupt the integrated serial peripheral would trigger. The controller would then read the incoming bytes until the next party error occurs.

Today this technique is not really in use anymore and is difficult to implement. Due to a lucky coincident, it was found out that FTDI serial USB chips support sending with space/mark parity while not caring much about errors when receiving.

MasterDataTool uses such an FTDI chip which is the reason we need to run a separate USB signal to the board. On the software side we have plenty of power so can just keep on parsing incoming bytes to find the start/stop of a telegram.

Each telegram consists of the following bytes:

| byte number              | description                                 |
| :----------------------- | :------------------------------------------ |
| **byte 00**              | receiving address "TO"                      |
| **byte 01**              | sending address "FROM"                      |
| **byte 02**              | currently unknown and always the same value |
| **byte 03**              | message type                                |
| **byte 04**              | destination source                          |
| **byte 05**              | origin source                               |
| **byte 06**              | currently unknown and always the same value |
| **byte 07**              | payload type                                |
| **byte 08**              | payload length                              |
| **byte 09**              | end of header / always 0x01                 |
| **byte 10 to byte n -2** | payload data                                |
| **byte n -1**            | checksum                                    |
| **byte n**               | always 0x00 / end of telegram               |

The checksum can easily be calculated. Convert all hex values to integers, add them, and convert them back to hex. If the resulting hex is larger than a byte - just truncate the hex value.

Here is an example telegram. You can find a handly ML telegram decoder in the ml-tools git repo. There is also a file explaining all known byte values.

    c1 06 01 0a 00 00 00 0d 02 01 6f 1f 70 00

| byte number | value | description                                                            |
| :---------- | :---- | :--------------------------------------------------------------------- |
| **byte 00** | c1    | msg to audio master                                                    |
| **byte 01** | 06    | msg from link node                                                     |
| **byte 02** | 01    | currently unknown / always the same value                              |
| **byte 03** | 0a    | command telegram                                                       |
| **byte 04** | 00    | no destination source                                                  |
| **byte 05** | 00    | no origin source                                                       |
| **byte 06** | 00    | currently unknown / always the same value                              |
| **byte 07** | 0d    | remote key input                                                       |
| **byte 08** | 02    | payload length is 2                                                    |
| **byte 09** | 01    | end of header / always 0x01                                            |
| **byte 10** | 6f    | command for RADIO source                                               |
| **byte 11** | 1f    | STEP_DOWN command                                                      |
| **byte 12** | 70    | checksum (193 + 6 + 1 + 10 + 13 + 2 + 1 + 111 + 31 = 368 = 0x170 = 70) |
| **byte 13** | 00    | always 0x00 / end of telegram                                          |

As we can see this telegram was a user pressing the "previous track" button on a link node. The link node then sends an ML message to the audio master (music system) to take action. Usually, the audio master would then respond with the new now-playing info (CD track changed or whatever).

If you want to implement any custom functionality have a look at the example we are providing. As long as you successfully installed the ml-tools suite and the ml-broker application is running in the background you can send and receive ML telegrams by publishing or subscribing to the corresponding Redis items. Just do not include the checksum or the 0x00 end-of-telegram byte. The ml-broker application will take care of that.

* * *

## [Connector](#/masterlink?id=connector)

For MasterLink a special 16-pin Molex connector system was used originally. Connectors and cables are still available but are expensive and likely of finite quantity. So for MasterDataTool a simple ML&lt;->RJ45 adapter was designed. It directly plugs into any ML socket on the one end and on the other, it accepts any standard shielded ethernet cable. Using ethernet cables for ML is not entirely new as B&O also offered adapter cables for that approach in later years. With our adapter, we just simplified that approach and made it less expensive to produce.

One ML&lt;->Rj45 adapter is included with every MasterDataTool. You can buy additional ones in any quantity and we also have a passive RJ45 distributor available where you can chain together multiple ML devices.

* * *

\_MasterDataTool documentation by [PolyVection](https://polyvection.com/).  
Visit our [Imprint](https://polyvection.com/imprint/) or contact us on [info@polyvection.com](mailto:info@polyvection.com) if you have any questions.  

PolyVection is completely unrelated to Bang & Olufsen a/s. Their brand and product names are only used for showing compatability.  
All rights belong to their respective owners.\_