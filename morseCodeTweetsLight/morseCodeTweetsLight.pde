// A Morse Encoder for Arduino and Twitter
// Savannah Niles -- www.savannahniles.com
//
// This sketch requires the most stable release of Processing, 1.5.1/

/**

Morse Code isn’t a critical technology anymore, but critical transmissions 
(think “SOS”) once depended on it. Out of an interest in framing today’s 
“critical” (?) transmissions with older technology, I made this Morse Code 
Tweet encoder with Processing, Arduino, and the Twitter Search API. Download 
the code and setup the circuit to encode Tweets with the hashtag #helpme with
a flashing LED. 

//I've added a ton of comments. **/


//Import Arduino and Processing's serial library
import cc.arduino.*;
import processing.serial.*;

XMLElement xml; //Object that will hold the XML for the Tweets you pull from the Search API
Arduino arduino; //Arduino Object to turn your LED on and off

String currentTweet = "MorseTweet"; //The tweet that the light is currently transmitting; it's initial value here is just a placeholder

void setup() {

  arduino = new Arduino(this, Arduino.list()[4], 57600); // Set up Arduino, connect to serial port 4. README.txt details setting up the right serial port.
  for (int i = 0; i <= 13; i++) // initialize pins 1-13 as outputs
    arduino.pinMode(i, Arduino.OUTPUT); //We could just initialize 13 if we wanted, but we'll go ahead and initialize all of them in case we want to add more hadware bells and whistles later.
}

void draw () {
  morse(); //Here we pull 15 tweets and blink through them all before returning to draw, (this function takes a while to complete)

}

void morse() {
  String[] tweets = loadTweets(); //grabs all 15 tweets and puts their content into an array of 15 strings
  for (int i=0; i<tweets.length; i++) {
    currentTweet = tweets[i]; //sets the current tweet
    println(currentTweet); //prints to console for fun

    tweets[i] = tweets[i].toUpperCase(); //converts to upper case for parsing
    for (int j=0; j<tweets[i].length(); j++) {
      encode(tweets[i].charAt(j)); //goes through each character in the tweet and encodes it in Morse Code
    }
    encode(' '); //adds some spaces between the transmissions of tweets
    encode(' ');
  }
}

String[] loadTweets () {
  //This is how we're grabbing tweets via the Twitter Search API
  //The Search API has a lot of documentation online. It's different than the Streaming API.
  
  //Step 1: initialize our XMLElement object xml by grabbing 15 tweets from our twitter search for #helpme. You can change the search by changing this URL, (detials in README.txt). Note that we're specifying the output of this request to be ATOM rather than JSON. ATOM is XML, so we can use Twitter's XML object for this. 
  xml = new XMLElement(this, "http://search.twitter.com/search.atom?q=%23RPR2013");
  
  //Step 2: XML is a nested data structure, so we need to get down to the next "layer" of objects. So, we create an array of XMLElement objects to hold ur 15 Tweet objects so we can go after their content in a loop.
  XMLElement[] entries = xml.getChildren("entry"); //looking for the XML elements called children inside the whole XML element that our querey returned
  
  //Step 3: Fill an array of 15 strings with our 15 tweets.
  String[] tweets = new String[entries.length]; 

  for (int i = 0; i < entries.length; i++) { //looping through our 15 XML tweet objects, entries
    XMLElement[] tweetXMLObj = entries[i].getChildren("title"); //make XML elements for each entries' title tag
    tweets[i] = tweetXMLObj[0].getContent(); //get the content inside that title tag, which is our tweet, and toss it into our string
  }
  return tweets; //return the string of our 15 tweets-- ready to be parsed
}

//This function encodes a character into its Morse code equivalent character string, then passes that string to the light function, which lights the LED according to the sequence of "on" and "off" symbols
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

//parses the morse code string and lights arduino's LED accordingly. 
void light(String code) {
  for (int i=0; i<code.length(); i++) {
    if (code.charAt(i) == '=') {
      arduino.digitalWrite(13, Arduino.HIGH);
      delay(300); //one third a second
    }
    else {
      arduino.digitalWrite(13, Arduino.LOW);
      delay(300);
    }
  }
}

