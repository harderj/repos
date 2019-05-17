float x =0;

void setup(){
  size(200, 200, P3D); 
}

void draw(){
  background(0);
  if(mousePressed){
    if(mouseButton == LEFT){
      x ++;
    }
    if(mouseButton == RIGHT){
      x --;
    }
  }
  lights();
  stroke(255,255,0);
  line(mouseX,mouseY,x,width/2,height/2,200);
}
