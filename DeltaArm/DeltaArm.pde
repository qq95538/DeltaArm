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
 int x=0;
 int y=0;
 int z=0;
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
   
   
 }
 void picture()
 {
   strokeWeight(4);
   fill(255);
   rect(5,160,490,320);
   ellipse(170,320,300,300);
   stroke(0);
   line(415,170,415,470);
   float m=map(x,-100,100,40,300);
   float n=map(y,-100,100,450,190);
   fill(0,0,150);
   ellipse(m,n,30,30);
   float l=map(z,-100,100,470,170);
   l=constrain(l,170,470);
   ellipse(415,l,30,30);
 }
 void keyPressed()
 {
    switch(key) {
    case 'A': 
        x-=a;
    break;
    case 'D': 
        x+=a;
    break;
    case 'W': 
        y+=a;
    break;
    case 'S': 
        y-=a;
    break;
    case 'I': 
        z+=a;
    break;
    case 'K': 
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
   String s;
   s = "G1 S2 X" + x + " Y" + y + " Z" + z + " F1000";
   println(s);
   port.write(s);
   port.write(13);
   port.write(10);
   bToSend=false;
 }
 
 void serialEvent(Serial p) { 
  inString = p.readString(); 
  print(inString);
} 