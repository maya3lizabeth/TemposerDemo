#include <Adafruit_CircuitPlayground.h>
#include <Wire.h>
#include <SPI.h>
#include <math.h>

#define EMERGENCY 900.00

float xMotion;
float yMotion;
float zMotion;
float magnitude;

void kalmanfilter(void)
{
  
}

// -------------------------------------------------------------------------------------------------------------------//

void setup() 
{
  //initialize serial communications at a 9600 baud rate
  Serial.begin(9600);
  CircuitPlayground.begin();
}


void loop()
{
  //send 'Hello, world!' over the serial port
  // NEXT -> REPLACE THIS WITH ACCELERATION DATA
  // NEXT NEXT -> ADJUST , AVERAGE , WHATEVER!
  // could literally just be serial write accel 
  // and gets interpreted on other end
  xMotion = CircuitPlayground.motionX();
  yMotion = CircuitPlayground.motionY();
  zMotion = CircuitPlayground.motionZ();

  magnitude = sqrt( pow(xMotion, 2) + pow(yMotion, 2) + pow(zMotion, 2)) - 9;
  if ((sqrt(pow(magnitude, 2))) > 20){
    CircuitPlayground.playTone(440, 500);
    delay(200);
    CircuitPlayground.playTone(440, 500);
    Serial.println(EMERGENCY);
  }
  
  Serial.println( sqrt(pow(magnitude, 2)));
  //wait 100 milliseconds so we don't drive ourselves crazy
  delay(100);
}

