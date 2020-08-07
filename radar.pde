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
PImage compass_img;
PImage target_img;
PImage range_circle_img;
int compass_width=500;
int compass_height=500;
int target_info_imgX=1050;
int target_info_imgY=200;
boolean target_img_info_interrupteur = false;
int text_size=25;
int circle_infoX=1100;
int circle_infoY=200;
//inputs
float heading;
int target_distance=200;
float angle =0;
float cap;
float target_angle=-PI;
float target_coordinates[]=new float[2];
int target_box_Size=10;

void setup() {
  size(1900,1000);
  compass_img=loadImage("compass.png");
  target_img=loadImage("target_infos.png");
  range_circle_img=loadImage("range_circles.png");
}


void draw() {
  background(0);
  draw_compass();
  draw_heading();
  draw_shadows(rad_angle);
  draw_scope();
  target_coordinates=draw_target(target_distance,target_angle);
  draw_info_target(target_img_info_interrupteur);
  draw_range_circles();

  delay(5);

}
void draw_scope()
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



void drawline(float angle_arg ,int  alpha_color)
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
 void draw_shadows(float angle_arg)
 {
   int k=0;
for (int i=0; i<255 ;i+=6 )
{

      drawline( angle_arg-k*0.00872665,255-i);
      k++;
}
}

float[]  draw_target(float distance, float angle )
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
    square(dist*(cos(angle)),-dist*(sin(angle)), target_box_Size);
    popMatrix();
    coordinates[0]=dist*(cos(angle));
    coordinates[1]=-dist*(sin(angle));
  }
  return coordinates;
}

void draw_compass(){

  pushMatrix();
  translate(compassX,compassY);
  imageMode(CENTER);
  fill(255);
  circle(0,0,compass_width);
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
  line(0,0,0,-compass_width/2);
  popMatrix();
}
void mouseClicked(){
  mouseX=mouseX-circleX;
  mouseY=mouseY-circleY;
  if  (mouseX > target_coordinates[0]-target_box_Size && mouseX < target_coordinates[0]+target_box_Size && 
      mouseY > target_coordinates[1]-target_box_Size && mouseY < target_coordinates[1]+target_box_Size)
      {
          target_img_info_interrupteur=true;
      }
}


void  draw_info_target(boolean state)
{
  if(state)
  {
  pushMatrix();
  translate(target_info_imgX,target_info_imgY);
  imageMode(CENTER);
  image(target_img,0 , 0, 300, 100);
  display_bearing_and_distance(bearing_calcul(  target_angle ));
  popMatrix();
  }
}

String  bearing_calcul( float target_angle )
{
  String direction="";
  int bear=90-int(degrees(target_angle));
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
void display_bearing_and_distance(String infos)
{
  textSize(text_size);
  fill(7, 48, 250);
  text(infos,-15,5);
  text(target_distance,-15,40);
}

int draw_range_circles()
{
  int mouse_relative_X=mouseX-circleX;
  int mouse_relative_Y=mouseY-circleY;
  println(mouse_relative_X);
  println(mouse_relative_Y);
  int range_circle_rayon=0;
  if(dist(mouse_relative_X,mouse_relative_Y,0,0)<rayon)
  {
  range_circle_rayon=int(dist(mouse_relative_X,mouse_relative_Y,0,0));
  noFill();
  strokeWeight(2);
  stroke(255);
  circle(circleX,circleY,2*range_circle_rayon);
  draw_range_circle_infos(range_circle_rayon);
  }
 
 return range_circle_rayon;
}

void  draw_range_circle_infos( int rayon)
{
 imageMode(CENTER);
 pushMatrix();
 translate(circle_infoX,circle_infoY);
 image(range_circle_img,0,0,500 ,54);
 textSize(text_size);
 fill(7, 48, 250);
 text(rayon,100,7);
 popMatrix();
 
}