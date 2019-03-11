import processing.serial.*;

PImage bg;
int y;
boolean VoltMis = false;
int MPH; // set to mph variable
int BB1;
int BB2;
int MTR;
int MCT;
int Error =0;
int BatLevel=640; //battery leverl must set be between 650 and 775
Serial myPort;                       // The serial port
int[] serialInArray = new int[6];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

//order to be recieved: mph, bb1 temp, bb2 temp, motor temp, motor control temp, battery level

void setup() {
  size(800, 480);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("GUI_Display.jpg");
   // List all the available serial ports
    // if using Processing 2.1 or later, use Serial.printArray()
    println(Serial.list());

    // I know that the first port in the serial list on my Mac is always my
    // Arduino board, so I open Serial.list()[0].
    // Change the 0 to the appropriate number of the serial port that your
    // microcontroller is attached to.
    myPort = new Serial(this, Serial.list()[0], 9600);

    // read bytes into a buffer until you get a linefeed (ASCII 10):
    myPort.bufferUntil('\n');

    // draw with smooth edges:
    //smooth();
  
}

void draw() {
  background(bg);
  
  //first value is Battery Level must be between 640 and 755
  //BatLevel = ;
  if(BatLevel < 740){
    fill(0,255,0);// sets fill color to green
    rect(775, 80, BatLevel,21); // last number needs to be set to BatLevel variable
    rectMode(CORNERS);  
  }
  if(BatLevel >= 740){
    fill(255,0,0);// sets fill color to red
    rectMode(CORNERS);
    rect(775, 80, BatLevel,21); // last number needs to be set to BatLevel variable  
  }
  textAlign(CENTER);
  fill(255);// mph display component
  textSize(210);
  textAlign(CENTER);
  text(MPH, 437, 350); 
  
  textAlign(LEFT);
  if(BB1 > 40){
    fill(255,0,0);// Battery Bay 1 Error 1
    textSize(50);
    text(BB1, 95, 140);
  }
  if(BB1 <= 40){
    fill(0,255,0);// Battery Bay 1
    textSize(50);
    text(BB1, 95, 140); 
  }
  if(BB2 > 40){
    fill(255,0,0);// Battery Bay 2 Error 10
    textSize(50);
    text(BB2, 95, 233); 
    Error += 10;
  }
  if(BB2 <= 40){
    fill(0,255,0);// Battery Bay 2 
    textSize(50);
    text(BB2, 95, 233);
   }
  if(MTR > 90){
    fill(255,0,0);// Motor Error 100
    textSize(50);
    text(MTR, 95, 420); 
  Error+=100;
  }
  if(MTR <= 90){
    fill(0,255,0);// Motor 
    textSize(50);
    text(MTR, 95, 420); 
   }
  if(MCT > 90){
    fill(255,0,0);// Motor Controller Error 1000
    textSize(50);
    text(MCT, 95, 328);
  Error+=1000;
  }
  if(MCT <= 90){
    fill(0,255,0);// Motor Controller
    textSize(50);
    text(MCT, 95, 328); 
   }
  if(Error == 1){
    fill(255,0,0); //Warning message 1
    textSize(27);
    text("Bay 1 Over Heat",274,64);
  }
  if(Error == 10){
    fill(255,0,0); //Warning message 10
    textSize(27);
    text("Bay 2 Over Heat",274,64);
  }
  if(Error == 100){
    fill(255,0,0); //Warning message 100
    textSize(27);
    text("Motor Over Heat",274,64);
  }
  if(Error == 1000){
    fill(255,0,0); //Warning message 1000
    textSize(27);
    text("Motor Controller Over Heat",274,64);
  }
  if(Error == 11){
    fill(255,0,0); //Warning message 0011
    textSize(27);
    text("Bay 1 and Bay 2 Over Heat",274,64); 
  }
  if(Error == 110){
    fill(255,0,0); //Warning message 0110
    textSize(27);
    text("Bay 2 and Motor \nOver Heat",274,64);
  }
  if(Error == 111){
    fill(255,0,0); //Warning message 1000
    textSize(27);
    text("Bay 1, Bay 2, and \nMotor Over Heat",274,80);
  }
  if(Error == 1001){
    fill(255,0,0); //Warning message 1001
    textSize(27);
    text("Bay 1 and Motor Controller \nOver Heat",274,80);
  }
  if(Error == 1010){
    fill(255,0,0); //Warning message 1010
    textSize(27);
    text("Bay 2 and Motor Controller \nOver Heat",274,64);
  }
  if(Error == 1011){
    fill(255,0,0); //Warning message 1011
    textSize(27);
    text("Bay 1, Bay 2 and \nMotor Controller Over Heat",274,64);
  }
  if(Error == 1100){
    fill(255,0,0); //Warning message 1100
    textSize(27);
    text("Motor and Motor Controller \nOver Heat",274,64);
  }
  if(Error == 1101){
    fill(255,0,0); //Warning message 1101
    textSize(27);
    text("Bay 1, Motor, and \nMotor Controller Over Heat",274,64);
  }
  if(Error == 1110){
    fill(255,0,0); //Warning message 1110
    textSize(27);
    text("Bay 2, Motor, and \nMotor Controller Over Heat",274,64);
  }
  if(Error == 1111){
    fill(255,0,0); //Warning message 1111
    textSize(27);
    text("All Sensors Over Heating",274,64);
  
  
  }
  Error = 0;
  }


  // serialEvent method is run automatically by the Processing applet whenever
  // the buffer reaches the  byte value set in the bufferUntil()
  // method in the setup():

  void serialEvent(Serial myPort) {
    // read the serial buffer:
    String myString = myPort.readStringUntil('\n');
    // if you got any bytes other than the linefeed:
    myString = trim(myString);

    // split the string at the commas and convert the sections into integers:
    int sensors[] = int(split(myString, ','));

    /* print out the values you got:
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    }*/
    //add a linefeed after all the sensor values are printed:
    println();
    if (sensors.length > 1) {
      MPH = sensors[0];
      BB1 = sensors[1];
      BB2 = sensors[2];
      MTR = sensors[0];
      MCT = sensors[1];
      BatLevel = sensors[2]+640;
    }
    // send a byte to ask for more data:
    myPort.write("A");
  }
