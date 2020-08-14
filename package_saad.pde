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
