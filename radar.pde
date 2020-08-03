float angle =0;
int rayon = 500;
float rad_angle=0;
int width=1000;
int height=1000;
void setup() {
  size(1000,1000);
}

void draw() {

  background(0);
  drawline(rad_angle,255);
  draw_shadows(rad_angle);
  pushMatrix();
  translate(width/2,height/2);
  noFill();
  stroke(0, 136, 0);
  circle(0,0,2*rayon);
  popMatrix();
  angle--;
  angle=angle%360;
  rad_angle=radians(angle);
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
