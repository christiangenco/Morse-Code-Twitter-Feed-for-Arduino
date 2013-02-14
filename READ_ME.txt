A project by Savannah Niles
www.savannahniles.com

To use:

(1) Make the basic LED circuit on your Arduino
(2) Open the Arduino editor, go to examples/Firmata, and upload
Standard Firmata
(3) Make sure it uploads and is good to go. Quit Arduino
(4) Open Processing 1.5.1 (the latest stable release)
(5) You might want to check your available serial ports on Processing.
You can find that code here:
http://www.processing.org/reference/libraries/serial/Serial_available_.h
tml
(6) Pick your serial port and insert it at *** in line 21, here:
arduino = new Arduino(this, Arduino.list()[***], 57600);
(7) Run the sketch!

You can change the search URL to look for different Tweets. Further
information here: https://dev.twitter.com/docs/using-search