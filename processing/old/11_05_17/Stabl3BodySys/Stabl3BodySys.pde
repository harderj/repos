void setup(){
  size(500,500);
  smooth();
  background(255);
  ellipseMode(CENTER);
}

void draw(){
  fill(255,10);
  rect(-20,-20,width+40,height+40);

  translate(width*0.5,height*0.5);
  
  int n=3;
  float siz = width*0.05;
  float speed = 0.0001;
  float r=width*0.3;
  float dis = millis()*speed*TWO_PI;
  noStroke();
  fill(0);
  for(int i=0; i<n; i++){
    float ang = (TWO_PI/n)*i;
    float x = cos(ang+dis)*r;
    float y = sin(ang+dis)*r;
    ellipse(x,y,siz,siz);
  }
  
}

void keyPressed(){
  if(key=='p') saveFrame();
}
