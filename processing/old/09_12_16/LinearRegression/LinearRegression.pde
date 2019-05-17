float s = 10;
float sX, sY;
int n = 20;
PVector[] p = new PVector[n];

void setup(){
  size(500,500);
  background(255);
  smooth();
  translate(width*0.5, height*0.5);
  sX = (width*0.5)/s;
  sY = (height*0.5)/s;
  
  strokeWeight(2);
  stroke(0);
  line(0,height*-s,0,height*s);
  line(width*-s,0,width*s,0);
  strokeWeight(1);
  
  /*
  float d = 5;
  for(int i=0; i<n; i++){
    p[i] = new PVector(random(-d,d) + (i-(n*0.5)), random(-d,d) + (i-(n*0.5)));
    spot(p[i].x, p[i].y);
  }
  
  PVector a = average(p);
  stroke(255,0,0);
  spot(a.x, a.y);
  */
  float a = 2;
  float b = 3;
  PVector sam = new PVector(10,10);
  linearFunc(a, b);
  spot(sam);
  
}




