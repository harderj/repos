simport point2line.*;

ArrayList segs = new ArrayList();

void setup(){
  size(500,500);
  background(255);
  smooth();
  strokeWeight(((width+height)*0.5)*0.01);
  
  for(int j=0; j<segs.size(); j++) ((Seg) segs.get(j)).render();
}

void draw(){
  
}


