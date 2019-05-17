import point2line.*;

ArrayList segs = new ArrayList();

void setup(){
  size(500,500);
  background(255);
  smooth();
  strokeWeight(((width+height)*0.5)*0.01);

  int numMax = 1000;
  int i = 0;
  stroke(255);
  Vect2 StartPos = new Vect2(width*0.5, height*0.5);
  segs.add(new Seg(StartPos));

  while(i<segs.size() && i<numMax){
    Vect2 pos = new Vect2(((Seg) segs.get(i)).pos);

    if(isInsideScreen(pos)){
      
      
      
    }

    i++;
  }

  println(i + ":" + segs.size());

  for(int j=0; j<segs.size(); j++) ((Seg) segs.get(j)).render();

}

void draw(){

}


