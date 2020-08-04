float rad_angle=0;
int radar_range=400;
int width=1000;
int height=1000;
int rayon = 450;
int cercleX=460;
int cercleY=490;
int compassX=1450;
int compassY=500;
PImage compass_img;
int compass_width=700 ; 
int compass_height=700;
//inputs
float heading=-30;
float target_distance=200;
float angle =0;
float cap;
float target_angle=PI/3;



void setup() {
  size(1900,1000);
  compass_img=loadImage("compass.png");
}



void draw() {
  background(0);
  draw_compass();
  draw_heading();
  drawline(rad_angle,255);
  draw_shadows(rad_angle);
  pushMatrix();
  translate(cercleX,cercleY);
  noFill();
  stroke(0, 136, 0);
  circle(0,0,2*rayon);
  popMatrix();
  angle++;
  angle=angle%360;
  rad_angle=radians(angle);
  draw_target(target_distance,target_angle);
  delay(15);


}
void drawline(float angle_arg ,int  alpha_color)
{
float x=rayon*cos(angle_arg);
float y=-rayon*sin(angle_arg);
pushMatrix();
 translate(cercleX,cercleY);
 strokeWeight(5);
 stroke(0, 136, 0,alpha_color);
 line(0, 0,x,y);
  popMatrix();
}
 void draw_shadows(float angle_arg)
 {
   int k=1;
for (int i=1; i<255 ;i+=6 )
{

      drawline( angle_arg+k*0.00872665,255-i);
      k++;
}
}

void  draw_target(float distance, float angle )
{
  if (distance<=400)

  {
    pushMatrix();
    translate(cercleX,cercleY);
    float dist=map(distance,0,radar_range,0,rayon);
    fill(255, 0, 0);
    strokeWeight(0);
    stroke(255);
    square(dist*(cos(angle)),-dist*(sin(angle)), 10);
    popMatrix();
  }
}

void draw_compass(){

  pushMatrix();
  translate(compassX,compassY);
  imageMode(CENTER);
  fill(255);
  circle(0,0,670);
  rotate(radians(-heading));
  image(compass_img, 0, 0, compass_width, compass_height);
  popMatrix();
}

void draw_heading()
{
  pushMatrix();
  translate(compassX,compassY);
  stroke(255,0,0);
  strokeWeight(5);
  line(0,0,0,-670/2);
  popMatrix();
}
