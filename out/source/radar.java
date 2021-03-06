import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class radar extends PApplet {

//import processing.serial.*;
//Serial myPort;
float rad_angle=0;
int radar_range=400;
int width=1000;
int height=1000;
int rayon = 450;
int circleX=460;
int circleY=490;
int compassX=1630;
int compassY=500;
int nq=1852;
String state="nothing";
PImage compass_img;
PImage target_img;
PImage cursor_f_img;
PImage cursor_plus_img;
int compass_width=500;
int compass_height=500;
int target_info_imgX=1050;
int target_info_imgY=100;
int text_size=25;
int circle_infoX=1100;
int circle_infoY=200;
float cursor_f[]={1200,800,90,90} ;
float cursor_plus[]={1050,800,90,90};
int static_range_cirle=0;
boolean draw_target_infos_status=false;
int[] rayon_coordinate= new int[2];
//inputs
float heading=10;
int target_distance=200;
float angle =0;
float cap;
float target_angle=PI;
float target_coordinates[]=new float[2];
int target_box_Size=10;


public void setup() {
  
//myPort  =  new Serial (this, "COM4",  9600);
  //myPort.bufferUntil ( '\n' );
  
  compass_img=loadImage("compass.png");
  target_img=loadImage("target_infos.png");
  cursor_f_img=loadImage("cursor_f.png");
  cursor_plus_img=loadImage("cursor_plus.png");

}


   /* void serialEvent  (Serial myPort) {
pry=myPort.readStringUntil ('\n');

}*/


public void draw() {
  background(0);
  draw_cursor_buttons(state);
  draw_compass();
  draw_heading();
  draw_shadows(rad_angle);
  draw_scope();
  target_coordinates=draw_target(target_distance,target_angle);
  if (static_range_cirle>0)
  {
    draw_static_range_circle(static_range_cirle,rayon_coordinate[0],rayon_coordinate[1]);
  }
  
  if (draw_target_infos_status){
    draw_info_target(target_angle,target_distance);
  }
  

}

public void mouseClicked(){
  if (mouseButton==LEFT)
  {

  

  if (state=="plot"&&cursor_in_box(target_coordinates[0]+circleX,target_coordinates[1]+circleY,target_box_Size,target_box_Size))

      {
          draw_target_infos_status=!draw_target_infos_status;
      }
else if (cursor_in_box(cursor_f[0],cursor_f[1],cursor_f[2],cursor_f[3]))
{
 
state="plot";
}
else if (cursor_in_box(cursor_plus[0],cursor_plus[1],cursor_plus[2],cursor_plus[3]))
{
state="draw_circle";
 
}
else if ((state=="draw_circle") && (cursor_in_circle(circleX,circleY,rayon)[0]==1))
{

 static_range_cirle= cursor_in_circle(circleX,circleY,rayon)[1];
 rayon_coordinate[0]=mouseX;
 rayon_coordinate[1]=mouseY;
}
 

}

}

public void draw_scope()
{
  pushMatrix();
  translate(circleX,circleY);
  noFill();
  stroke(0, 136, 0);
  circle(0,0,2*rayon);
  popMatrix();
  angle++;
  angle=angle%360;
  rad_angle=radians(angle);

}



public void drawline(float angle_arg ,int  alpha_color)
{
float x=rayon*cos(angle_arg);
float y=-rayon*sin(angle_arg);
pushMatrix();
 translate(circleX,circleY);
 strokeWeight(5);
 stroke(0, 136, 0,alpha_color);
 line(0, 0,x,y);
  popMatrix();
}
 public void draw_shadows(float angle_arg)
 {
   int k=0;
for (int i=0; i<255 ;i+=6 )
{

      drawline( angle_arg-k*0.00872665f,255-i);
      k++;
}
}

public float[]  draw_target(float distance, float angle )
{
  float[] coordinates = {0,0};
  if (distance<=400)

  {
    pushMatrix();
    translate(circleX,circleY);
    float dist=map(distance,0,radar_range,0,rayon);
    fill(255, 0, 0);
    strokeWeight(0);
    stroke(255);
    rectMode(CENTER);
    square(dist*(cos(angle)),-dist*(sin(angle)), target_box_Size);
    popMatrix();
    coordinates[0]=dist*(cos(angle));
    coordinates[1]=-dist*(sin(angle));
  }
  return coordinates;
}

public void draw_compass(){

  pushMatrix();
  translate(compassX,compassY);
  imageMode(CENTER);
  fill(255);
  circle(0,0,compass_width);
  rotate(radians(-heading));
  image(compass_img, 0, 0, compass_width, compass_height);
  popMatrix();
}

public void draw_heading()
{
  pushMatrix();
  translate(compassX,compassY);
  stroke(255,0,0);
  strokeWeight(5);
  line(0,0,0,-compass_width/2);
  popMatrix();
}



public void  draw_info_target(float angle, int distance)
{
  
  pushMatrix();
  translate(target_info_imgX,target_info_imgY);
  imageMode(CENTER);
  image(target_img,0 , 0, 300, 100);
  display_bearing_and_distance(bearing_calcul(angle),distance );
  popMatrix();

}

public String  bearing_calcul( float target_angle )
{
  String direction="";
  int bear=(90-PApplet.parseInt(degrees(target_angle)))%180;
  if(bear<0)
  {
      direction="Babord";
  }
  else if (bear >0)
  {
      direction="Tribord";
  }

  direction= Integer.toString(abs(bear))+"° "+direction;
  return direction;
}
public void display_bearing_and_distance(String infos,int distance)
{
  textSize(text_size);
  fill(7, 48, 250);
  text(infos,-15,5);
  text(distance,-15,40);
}

public int draw_range_circles()
{

  int range_circle_rayon=0;
  int[] check=cursor_in_circle(circleX,circleY,rayon);
    if(check[0]==1)
  {
  range_circle_rayon=check[1];
  noFill();
  strokeWeight(2);
  stroke(255);
  circle(circleX,circleY,2*range_circle_rayon);
  textSize(20);
  fill(255);
  text(real_distance(range_circle_rayon),mouseX,mouseY);
  }
 
 return range_circle_rayon;
}



public boolean  cursor_in_box(float x,float y,float sizeX,float sizeY)
{
  if (mouseX > x-sizeX && mouseX < x+sizeX && mouseY > y-sizeY && mouseY < y+sizeY)
      {
        return true;
      }
  return false;
}



public int []  cursor_in_circle(int centerX,int centerY,int rayon )
{
  int[] distance=new int[2];
if (dist(centerX,centerY,mouseX,mouseY)<rayon) {
  distance[0]=1;
  distance[1]=PApplet.parseInt(dist(mouseX,mouseY,circleX,circleY));
  return distance ;
}
else
{
  distance[0]=0;
  return  distance;
}
}




public void draw_cursor_buttons(String state)
{
  if (state=="plot")
  {
    cursor(HAND);
    strokeWeight(5);
    stroke(0,136,0);
    rectMode(CENTER);
    square(cursor_f[0],cursor_f[1],cursor_f[3]);
    imageMode(CENTER);
    image(cursor_f_img,cursor_f[0],cursor_f[1],cursor_f[2],cursor_f[3]);
    noStroke();
    imageMode(CENTER);
    image(cursor_plus_img,cursor_plus[0],cursor_plus[1],cursor_plus[2],cursor_plus[3]);
  }
  else if (state=="draw_circle") {
    cursor(CROSS);
    strokeWeight(5);
    stroke(0,136,0);
    rectMode(CENTER);
     square(cursor_plus[0],cursor_plus[1],cursor_plus[3]);
    imageMode(CENTER); 
    image(cursor_plus_img,cursor_plus[0],cursor_plus[1],cursor_plus[2],cursor_plus[3]);
    noStroke();
    imageMode(CENTER);
    image(cursor_f_img,cursor_f[0],cursor_f[1],cursor_f[2],cursor_f[3]);
        draw_range_circles();

  }
  else if (state=="nothing")
  {cursor(ARROW);
    imageMode(CENTER);
     image(cursor_plus_img,cursor_plus[0],cursor_plus[1],cursor_plus[2],cursor_plus[3]);
     imageMode(CENTER);
     image(cursor_f_img,cursor_f[0],cursor_f[1],cursor_f[2],cursor_f[3]);
  }
}

public void   draw_static_range_circle(int rayon_of_range_circle,int mouse_X,int mouse_Y )
{
  stroke(255);
  noFill();
  strokeWeight(1);
  circle(circleX,circleY,2*rayon_of_range_circle);
  textSize(20);
  fill(255);
  text(real_distance(rayon_of_range_circle),mouse_X,mouse_Y);
 
}
public int real_distance(int relative_distance)
{
  return PApplet.parseInt(map(relative_distance,0,rayon,0,radar_range));
}
public class scope {
 int circleX;
 int circleY;
 int rayon;

 public  scope() {
    circleX=0;
    circleY=0;
    rayon=0;
 }
public scope(int circlex, int circley,int scope_rayon)
{
circleX=circlex;
circleY=circley;
rayon=scope_rayon;
}

public  draw_scope()
{
  pushMatrix();
  translate(circleX,circleY);
  noFill();
  stroke(0, 136, 0);
  circle(0,0,2*rayon);
  popMatrix();
}
}
public void setup() {
    
}

public void draw() {
    
}

  public void settings() {  size(1900,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "radar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
