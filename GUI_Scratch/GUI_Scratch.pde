PImage bg;
int y;
float VoltMis = 1;
int MPH = 88; // set to mph variable
int BB1 = 33;
int BB2 = 34;
int BB3 = 35;
int BB4 = 36;
int BB5 = 37;
int BB6 = 38;
int BB7 = 39;
int BB8 = 40;
int MCT = 41;


void setup() {
  size(800, 480);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("GUI_Practice.jpg");
  
}

void draw() {
  background(bg);
  
  float BatLevel = float(350); // first value is Battery Level
  //BatLevel = ;
  fill(0,255,0);// sets fill color to green
  rect(639, 475, 748, BatLevel); // last number needs to be set to BatLevel variable
  rectMode(CORNERS);
 
  ellipseMode(CENTER);  // Set ellipseMode to CENTER
  fill(255,0,0);  // Set fill to red
  ellipse(737, 61, 61, 61);  // Draw red ellipse using CENTER mode (x,y,height,width)
  
  fill(40, 110, 255);// mph display component
  textSize(210);
  text(MPH, 265, 375); 
  
  fill(100);// Battery Bay 1,1
  textSize(30);
  text(BB1, 56, 164); 
 
  fill(100);// Battery Bay 1,2
  textSize(30);
  text(BB2, 120, 164); 
  
  fill(100);// Battery Bay 2,1
  textSize(30);
  text(BB3, 56, 245); 
  
  fill(100);// Battery Bay 2,2
  textSize(30);
  text(BB4, 120, 245); 
  
  fill(100);// Battery Bay 3,1
  textSize(30);
  text(BB5, 56, 330); 
  
  fill(100);// Battery Bay 3,2
  textSize(30);
  text(BB6, 120, 330); 
  
  fill(100);// Battery Bay 4,1
  textSize(30);
  text(BB7, 56, 410); 
  
  fill(100);// Battery Bay 4,2
  textSize(30);
  text(BB8, 120, 410); 
  
  fill(255); //motor control temp
  textSize(30);
  text(MCT, 528, 74); 
  }
