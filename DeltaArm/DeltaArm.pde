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
 boolean serial;
 //输出参数
 float x=150;
 float y=0;
 float pos1,pos2;
 int pos=72;
 int pos3=90;
 int a=2;
 float posa;
 float A;
 float B;
 float C;
 float D;
 float pi=acos(-1.0);
 //界面参数
 PFont font;
 void setup()
 {
   size(500,500);
   frameRate(53);
   port=new Serial(this,"COM5",115200);
   //font=loadFont("LilyUPCBold-48.vlw");
   smooth();
 }
 void draw()
 {
   math_funtion();
   inter_face();
   picture();
   control(); 
 }
 void math_funtion()
 {
   A=sqrt(x*x+y*y);//数学方程
   B=atan(y/x);
   C=acos(A/300);
   D=acos(1.0-A*A/45000);
   D=D/pi*180;
   posa=B+C;
   pos1=posa/pi*180;
   pos2=180-pos1-D;
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
   text("POS=",5,140);
   text(int(pos),60,140);
   text("POS1=",105,140);
   text(int(pos1),175,140);
   text("POS2=",225,140);
   text(int(pos2),295,140);
   text("POS3=",345,140);
   text(int(pos3),415,140);
     if((keyPressed==true)&&(key=='i'))
    {
      fill(0,211,58);
     text("opening",250,110);
    }
     else if((keyPressed==true)&&(key=='k'))
     {
       fill(0,211,58);
      text("closing",250,110);
     }
 }
 void picture()
 {
   strokeWeight(4);
   fill(255);
   rect(5,160,490,320);
   ellipse(170,320,300,300);
   stroke(0);
   line(415,170,415,470);
   float n=map(pos3,0,180,300,40);
   float m=map(x,0,300,450,190);
   fill(0,0,150);
   ellipse(n,m,30,30);
   float l=map(y,-150,150,170,470);
   l=constrain(l,170,470);
   ellipse(415,l,30,30);
 }
 void control()
 {
   if((keyPressed==true)&&(key=='a'))
   {
     x-=a;
     serial=true;
   }
   else if((keyPressed==true)&&(key=='d'))
   {
     x+=a;
     serial=true;
   }
   else if((keyPressed==true)&&(key=='w'))
   {
     y-=a;
     serial=true;
   }
   else if((keyPressed==true)&&(key=='s'))
   {
     y+=a;
     serial=true;
   }
    else if((keyPressed==true)&&(key=='i'))
    {
      pos+=a;
      pos=constrain(pos,72,160);
      serial=true;
    }
     else if((keyPressed==true)&&(key=='k'))
     {
       pos-=a;
       pos=constrain(pos,72,160);
       serial=true;
     }
      else if((keyPressed==true)&&(key=='j'))
      {
        pos3+=1;
        serial=true;
      }
       else if((keyPressed==true)&&(key=='l'))
       {
         pos3-=1;
         serial=true;
       }
       if(serial){
           send_data();
       }
 }
 void send_data()
 {
   print("pos=");
   print(int(pos));
   print(',');
   print("pos1=");
   print(int(pos1));
   print(',');
   print("pos2=");
   print(int(pos2));
   print(',');
   print("pos3=");
   println(pos3);
   port.write('%');
   port.write(int(pos));
 // port.write(';');
   port.write(int(pos1));
 // port.write(';');
   port.write(int(pos2));
 //  port.write(';');
   port.write(int(pos3));
   serial=false;
 }