// A Morse Encoder for Arduino and Twitter
// Savannah Niles -- www.savannahniles.com
//
// This sketch requires the most stable release of Processing, 1.5.1/

import cc.arduino.*;
import processing.serial.*;

XMLElement xml;
Arduino arduino;

PFont mono;
String currentTweet = "MorseTweet";

void setup() {
  background (255);
  
  mono = loadFont("AndaleMono-48.vlw");
  textFont(mono);

  arduino = new Arduino(this, Arduino.list()[4], 57600); // Set up Arduino, connect to serial port 4
  for (int i = 0; i <= 13; i++) // initialize pins 1-13 as outputs
    arduino.pinMode(i, Arduino.OUTPUT);
}

void draw () {
  morse();

}

void morse() {
  String[] tweets = loadTweets();
  for (int i=0; i<tweets.length; i++) {
    currentTweet = tweets[i];
    println(currentTweet);

    tweets[i] = tweets[i].toUpperCase();
    for (int j=0; j<tweets[i].length(); j++) {
      encode(tweets[i].charAt(j));
    }
    encode(' ');
    encode(' ');
  }
}

String[] loadTweets () {
  xml = new XMLElement(this, "http://search.twitter.com/search.atom?q=%23RPR2013");
  XMLElement[] entries = xml.getChildren("entry");
  String[] tweets = new String[entries.length];

  for (int i = 0; i < entries.length; i++) {
    XMLElement[] tweetXMLObj = entries[i].getChildren("title");
    tweets[i] = tweetXMLObj[0].getContent();
  }
  return tweets;
}

void encode(char letter) {
  switch(letter) {
  case 'A':
    //println("=.===");
    light("=.===");
    break;
  case 'B':
    //println("===.-=.=.");
    light("===.-=.=.");    
    break;
  case 'C':
    //println("===.=.===.=");
    light("===.=.===.=");
    break;
  case 'D':
    //println("===.=.=");
    light("===.=.=");
    break;
  case 'E':
    //println(".=.");
    light(".=.");
    break;
  case 'F':
    //println("=.=.===.=");
    light("=.=.===.=");
    break;
  case 'G':
    //println("===.===.=");
    light("===.===.=");
    break;
  case 'H':
    //println("=.=.=.=");
    light("=.=.=.=");
    break;
  case 'I':
    //println("=.=");
    light("=.=");
    break;
  case 'J':
    //println("=.===.===.===");
    light("=.===.===.===");
    break;
  case 'K':
    //println("===.=.===");
    light("===.=.===");
    break;
  case 'L':
    //println("=.===.=.=");
    light("=.===.=.=");
    break;
  case 'M':
    //println("===.===");
    light("===.===");
    break;
  case 'N':
    //println("===.=");
    light("===.=");
    break;
  case 'O':
    //println("===.===.===");
    light("===.===.===");
    break;
  case 'P':
    //println("=.===.===.=");
    light("=.===.===.=");
    break;
  case 'Q':
    //println("===.===.=.===");
    light("===.===.=.===");
    break;
  case 'R':
    //println("=.===.=");
    light("=.===.=");
    break;
  case 'S':
    //println("=.=.=");
    light("=.=.=");
    break;
  case 'T':
    //println("===");
    light("===");
    break;
  case 'U':
    //println("=.=.===");
    light("=.=.===");
    break;
  case 'V':
    //println("=.=.=.===");
    light("=.=.=.===");
    break;
  case 'W':
    //println("=.===.===");
    light("=.===.===");
    break;
  case 'X':
    //println("===.=.=.===");
    light("===.=.=.===");
    break;
  case 'Y':
    //println("===.=.===.===");
    light("===.=.===.===");
    break;
  case 'Z':
    //println("===.===.=.=");
    light("===.===.=.=");
    break;

  case ' ':
    //println (".......");
    light(".......");
    break;

  case '1':
    //println("=.===.===.===.===");
    light("=.===.===.===.===");
    break;
  case '2':
    //println("=.=.===.===.===");
    light("=.=.===.===.===");
    break;
  case '3':
    //println("=.=.=.===.===");
    light("=.=.=.===.===");
    break;
  case '4':
    //println("=.=.=.=.===");
    light("=.=.=.=.===");
    break;
  case '5':
    //println("=.=.=.=.=");
    light("=.=.=.=.=");
    break;
  case '6':
    //println("===.=.=.=.=");
    light("===.=.=.=.=");
    break;
  case '7':
    //println("===.===.=.=.=");
    light("===.===.=.=.=");
    break;
  case '8':
    //println("===.===.===.=.=");
    light("===.===.===.=.=");
    break;
  case '9':
    //println("===.===.===.===.=");
    light("===.===.===.===.=");
    break;
  case '0':
    //println("===.===.===.===.===");
    light("===.===.===.===.===");
    break;
  default:
    //println ("...");
    light("...");
    break;
  }
}

void light(String code) {
  for (int i=0; i<code.length(); i++) {
    if (code.charAt(i) == '=') {
      arduino.digitalWrite(13, Arduino.HIGH);
      delay(300);
    }
    else {
      arduino.digitalWrite(13, Arduino.LOW);
      delay(300);
    }
  }
}

