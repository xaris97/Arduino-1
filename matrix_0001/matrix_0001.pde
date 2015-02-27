/*
  8x8 LED matrix with accelerometer
 for Arduino 
 
 This example controls an 8x8 LED matrix using two inputs
 from an accelerometer.
 
 created 27 May 2009
 by Tom Igoe
 
 The matrix used is labeled  HS-788AS.  It was bought surplus.
 It is laid out as follows 
 (warning: yours might have different pin configurations):
 
 rows are the anodes
 cols are the cathodes
 
 label HS-788AS is on the left side of the chip
 _________
 col 4  ----|         |---- row 1
 col 2  ----|         |---- row 2
 row 7  ----|         |---- col 7
 row 6  ----|         |---- row 8
 col 1  ----|         |---- col 5
 row 4  ----|         |---- row 3
 col 3  ----|         |---- row 5
 col 6  ----|         |---- col 8
 ---------
 
 Pin numbers:
 Matrix:
 2 through 13, analog 2 througnh used as digital 16 through 19
 Accelerometer: 
 X and Y axes attached to analog in 0 and 1
 
 */

// max and min values from the accelerometer, 
// found by experiment:
const int sensorMin = 380;
const int sensorMax = 620;

// 2-dimensional array of row pin numbers (for two matrices):
const int row[8] = {
  9,8,4,17,3,10,11,6  };

// 2-dimensional array of column pin numbers (for two matrices):
const int col[8] = {
  16,12,18,13,5,19,7,2  };

// 2-dimensional array of pixels:
int pixels[8][8];           

// cursor position:
int x = 5;
int y = 5;

void setup() {
  Serial.begin(9600);
  // initialize the I/O pins as outputs:

  // iterate over the pins:
  for (int thisPin = 0; thisPin < 8; thisPin++) {
    // initialize the output pins:
    pinMode(col[thisPin], OUTPUT); 
    pinMode(row[thisPin], OUTPUT);  
    // take the col pins (i.e. the cathodes) high to ensure that
    // the LEDS are off: 
    digitalWrite(col[thisPin], HIGH);    
  }

  // initialize the pixel matrix:
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      pixels[x][y] = HIGH;
    }
  }
}

void loop() {
  // read input:
  readSensors();

  // draw the screen:
  refreshScreen();

}
 
void readSensors() {
  // turn off the last position:
  pixels[x][y] = HIGH;
  // read the sensors for X and Y values:
  x = 7 - map(analogRead(0), sensorMin, sensorMax, 0, 7);
  y = map(analogRead(1), sensorMin, sensorMax, 0, 7);
  pixels[x][y] = LOW;

}

void refreshScreen() {
  // iterate over the rows (anodes):
  for (int thisRow = 0; thisRow < 8; thisRow++) {
    // take the row pin (anode) high:
    digitalWrite(row[thisRow], HIGH);
    // iterate over the cols (cathodes):
    for (int thisCol = 0; thisCol < 8; thisCol++) {
      // get the state of the current pixel;
      int thisPixel = pixels[thisRow][thisCol];
      // when the row is HIGH and the col is LOW,
      // the LED where they meet turns on:
      digitalWrite(col[thisCol], thisPixel);
      // turn the pixel off:
      if (thisPixel == LOW) {
        digitalWrite(col[thisCol], HIGH);
      }

    }
    // take the row pin low to turn off the whole row:
    digitalWrite(row[thisRow], LOW);
  }

}

