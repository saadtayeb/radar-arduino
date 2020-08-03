float angle =0;
float target_distance=400;
float rad_angle=0;
int radar_range=400;
int width=1000;
int height=1000;
int rayon = height/2;
int cercleX=500;
int cercleY=500;
void setup() {
  size(1900,1000);
}

void draw() {
  background(0);
  
  drawline(rad_angle,255);
  draw_shadows(rad_angle);
  pushMatrix();
  translate(cercleX,cercleY);
  noFill();
  stroke(0, 136, 0);
  circle(0,0,2*rayon);
  popMatrix();
  angle--;
  angle=angle%360;
  rad_angle=radians(angle);
  draw_target(target_distance,rad_angle);
  delay(15);


}
void drawline(float angle_arg ,int  alpha_color)
{
float x=rayon*cos(angle_arg);
float y=rayon*sin(angle_arg);
pushMatrix();
 translate(width/2,height/2);
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
    square(dist*(cos(angle)), dist*(sin(angle)), 10);
    popMatrix();
  }
}
