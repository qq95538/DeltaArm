 /**
 processing control a Marlin Delta 3D printer arm
 by b.h. song
 190808149@qq.com
 */
 
 /**
 *processing control a 4-DOF mechanical arm
 *by jorneryChen 
 *
 *my emial address is 1274104408@qq.com
 */

 import processing.serial.*;
 Serial port;
 boolean bToSend;
 String inString;
 int lf = 10;      // ASCII linefeed
 int x=150;
 int z=0;
 int y=90;
 int a=2;
 PFont font;
 void setup()
 {
   size(500,500);
   frameRate(53);
   printArray(Serial.list()); 
   port = new Serial(this, Serial.list()[0], 115200); 
   port.bufferUntil(lf); 

   
   smooth();
 }
 void draw()
 {

   inter_face();
   picture();
   if(bToSend) send_data();
 }

 void inter_face()
 {
    background(255);
   textSize(40);
   fill(245,12,32);
   text("C",5,40);
   fill(38,245,12);
   text("L",35,40);
   fill(12,91,245);
   text("Y",55,40);
   fill(66,204,227);
   textSize(15);
   text("Redesigned by song, which was an originally u-arm",100,20);
   text("similar robot control program authorized by yao.",100,40);
   textSize(30);
   fill(211,191,0);
   text("this interface shows data only",5,80);
   fill(0);
   textSize(20);
   text("X=",5,110);
   text(int(x),35,110);
   text("Y=",85,110);
   text(int(y),115,110);
   text("Z=",165,110);
   text(int(z),195,110);
   text("received: " + inString, 4,140);
   
 }
 void picture()
 {
   strokeWeight(4);
   fill(255);
   rect(5,160,490,320);
   ellipse(170,320,300,300);
   stroke(0);
   line(415,170,415,470);
   float m=map(x,0,180,300,40);
   float n=map(y,0,300,450,190);
   fill(0,0,150);
   ellipse(m,n,30,30);
   float l=map(-z,-150,150,170,470);
   l=constrain(l,170,470);
   ellipse(415,l,30,30);
 }
 void keyPressed()
 {
    switch(key) {
    case 'a': 
        x+=a;
    break;
    case 'd': 
        x-=a;
    break;
    case 'w': 
        y+=a;
    break;
    case 's': 
        y-=a;
    break;
    case 'i': 
        z+=a;
    break;
    case 'k': 
        z-=a;
    break;
    }
 }
 void keyReleased() 
 {
   bToSend=true;
 }

 void send_data()
 {
   print("G1 S2");
   print(" X"); print(x);
   print(" Y"); print(y);
   print(" Z"); print(z);
   print(" F500");
   println();
   port.write("G1 S2");
   port.write(" X"); port.write(x);
   port.write(" Y"); port.write(y);
   port.write(" Z"); port.write(z);
   port.write(" F500");
   port.write(10); //NL
   port.write(13); //CR
   bToSend=false;
 }
 
 void serialEvent(Serial p) { 
  inString = p.readString(); 
  print(inString);
} 