#include <Adafruit_NeoPixel.h>

#define PIN 1

int brightness = 0;    // how bright the LED is
int fadeAmount = 1;    // how many points to fade the LED by
int counter = 0;
int R = 0;
int G = 255;
int B = 0;

// Parameter 1 = number of pixels in strip
// Parameter 2 = Arduino pin number (most are valid)
// Parameter 3 = pixel type flags, add together as needed:
//   NEO_KHZ800  800 KHz bitstream (most NeoPixel products w/WS2812 LEDs)
//   NEO_KHZ400  400 KHz (classic 'v1' (not v2) FLORA pixels, WS2811 drivers)
//   NEO_GRB     Pixels are wired for GRB bitstream (most NeoPixel products)
//   NEO_RGB     Pixels are wired for RGB bitstream (v1 FLORA pixels, not v2)
Adafruit_NeoPixel strip = Adafruit_NeoPixel(16, PIN, NEO_GRB + NEO_KHZ800);

// IMPORTANT: To reduce NeoPixel burnout risk, add 1000 uF capacitor across
// pixel power leads, add 300 - 500 Ohm resistor on first pixel's data input
// and minimize distance between Arduino and first pixel.  Avoid connecting
// on a live circuit...if you must, connect GND first.

void setup() {
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
  Serial.begin(9600);
}

void loop() {
  for (int j = 0; j < 256; j++) {
    R = j;
    B = j;
  }
  counter++;
  for (int i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, strip.Color(R, G, B));
  }
  strip.show();
  Serial.print (R);
  Serial.print (G);
  Serial.println (B);

}

void Color() {
  counter++;
  for (int i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, strip.Color(R, G, B));
  }
  strip.show();
  Serial.print (R);
  Serial.print (G);
  Serial.println (B);
}
