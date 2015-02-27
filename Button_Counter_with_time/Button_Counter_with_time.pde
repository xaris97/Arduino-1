/*
  Button
 
 Turns on and off a light emitting diode(LED) connected to digital  
 pin 13, when pressing a pushbutton attached to pin 7. 
 
 Sends a press count and time between presses to serial
 
 The circuit:
 * LED attached from pin 13 to ground 
 * pushbutton attached to pin 2 from +5V
 * 10K resistor attached to pin 2 from ground
 
 * Note: on most Arduinos there is already an LED on the board
 attached to pin 13.
 
 
 created 2005
 by DojoDave <http://www.0j0.org>
 modified 17 Jun 2009
 by Tom Igoe
 Modified 18 September 2010
by Troy Nachtigall 
 
 
  http://www.arduino.cc/en/Tutorial/Button
 */

// constants won't change. They're used here to 
// set pin numbers:
const int buttonPin = 2;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin
int xcounter = 0;
unsigned long time = 0;
unsigned long prevtime = 0;
// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status

void setup() {
  Serial.begin(9600);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);     
}

void loop(){
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonState == HIGH) {     
    // turn LED on and Serial print count:    
    time = millis();
    digitalWrite(ledPin, HIGH);
    xcounter ++;
    Serial.print (xcounter);
    Serial.print (" ");
    Serial.print (time);
    Serial.print (" ");
    Serial.println ((time - prevtime));
    prevtime = time;
    while (buttonState == HIGH){
      buttonState = digitalRead(buttonPin);
      delay (100);
      }
} 
  else {
    // turn LED off:
    digitalWrite(ledPin, LOW); 
  }
}
