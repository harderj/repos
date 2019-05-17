float s = 10;
float d = 5;

void setup(){
  size(500,200);
  smooth();
  
  stroke(0,0,0,150);
  strokeWeight(2);
}

void draw(){
  background(255);
  
  for(int i=0; i<500; i++){
    float a = float(i)/(TWO_PI*s);
    point(i, 100 + sin(a)*20);
  }
  
  for(int i=0; i<500; i++){
    float b = float(i)/(TWO_PI*d);
    point(i, 100 + sin(b)*20);
  }
  
  if(keyPressed && key == 'a') s*=1.1;
  if(keyPressed && key == 's') s/=1.1;
}
