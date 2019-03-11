#include <OneWire.h>
#include <DallasTemperature.h>

#define ONE_WIRE_BUS 2

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

int MPH = 0; // set to mph variable
int BB1 = 0;
int BB2 = 0;
int MTR = 0;
int MCT = 0;
int BatLevel = 0;
int inByte = 0;         // incoming serial byte

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  //world();  // send a byte to establish contact until receiver responds
    while (Serial.available() <= 0) {
    Serial.println("0,0,0,0,0,0");   // send an initial string
    delay(300);
  }
}

void loop() {
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    // read first analog input, divide by 4 to make the range 0-255:
    MPH++; //counters are just for testing 
    BB1++; 
    BB2++;
    MTR++; 
    MCT++;
    BatLevel++;
    }
    Serial.print(MPH);
    Serial.print(",");
    Serial.print(BB1);
    Serial.print(",");
    Serial.print(BB2);
    Serial.print(",");
    Serial.print(MTR);
    Serial.print(",");
    Serial.print(MCT);
    Serial.print(",");
    Serial.println(BatLevel);
    delay(500);
  }

/*
void world() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0,0,0,0");   // send an initial string
    delay(300);
  }
}
*/
