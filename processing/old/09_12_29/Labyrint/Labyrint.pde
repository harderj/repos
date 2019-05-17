import point2line.*;

ArrayList segs = new ArrayList();

void setup(){
  size(500,500);
  background(255);
  smooth();
  strokeWeight(((width+height)*0.5)*0.01);

  int numMax = 1000;
  int i = 0;
  float space = 20;
  float splitChance = 0.2;
  stroke(255);
  Vect2 StartPos = new Vect2(width*0.5, height*0.5);
  segs.add(new Seg(StartPos));

  float rAngle = random(TWO_PI);
  while(i<segs.size() && i<numMax){
    Vect2 pos = new Vect2(((Seg) segs.get(i)).pos);
    Vect2 rPos = new Vect2(pos.x + cos(rAngle)*space, pos.y + sin(rAngle)*space);

    if(isInside(pos)){
      if(i>1){
        int j = i-2;
        Vect2 tPos = new Vect2(((Seg) segs.get(j)).pos);
        while(!isInside(rPos, tPos, space) && j>0){
          j--;
          tPos = ((Seg) segs.get(j)).pos;
        }
        if(!isInside(rPos, tPos, space*2)){
          segs.add(new Seg(rPos));
          //          if(random(0,1)<splitChance){
          //            float[] tmpList = {1, -1};
          //            println(random(tmpList));
          //            float rA2 = random(tmpList)*PI*0.7;
          //            rPos.set(pos.x + cos(rAngle+rA2)*space, pos.y + sin(rAngle+rA2)*space);
          //            segs.add(new Seg(rPos));
          //          }
        }
      }
      else {
        segs.add(new Seg(rPos));
      }
    }

    i++;
    rAngle += (random(PI)-PI*0.5)*0.6;
  }

  println(i + ":" + segs.size());

  //segs.add(new Seg(width*0.5, height*0.5));
  //
  //for(int i=0; i<num; i++){
  //
  //  for(int j=0; j<i; j++){
  //    
  //    segs.add(new Seg(((float)i/(float)num)*width, ((float)j/(float)i)*height));
  //    
  //  }
  //
  //}

  for(int j=0; j<segs.size(); j++) ((Seg) segs.get(j)).render();

}

void draw(){
  
}

