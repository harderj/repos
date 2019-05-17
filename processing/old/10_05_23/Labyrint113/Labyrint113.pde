import point2line.*;

ArrayList segs = new ArrayList();

final int START_COUNT = 200;
final float DRAG = 0.95;
boolean repulse_segs = true;

void setup(){
  size(500,500);
  smooth();
  strokeWeight(((width+height)*0.5)*0.01);
  //frameRate(1);
  
  for(int i=0; i<START_COUNT; i++) segs.add(new Seg(randomScreen()));
}

void draw(){
  background(255);
  if(keyPressed && key == 'r') repulse_segs = false;
  else repulse_segs = true;
  //println(segs.size() + ":" + ((Seg) segs.get(0)).pos);
  for(int i=0; i<segs.size(); i++) ((Seg) segs.get(i)).update();
}

void keyPressed(){
  if(key == 'v'){
    float tmp = 0.0;
    for(int i=0; i<segs.size(); i++) tmp += ((Seg) segs.get(i)).vel.magnitude();
    println(tmp);
  }
}
