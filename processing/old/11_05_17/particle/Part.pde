class Part{
  
  Phys2 b;
  
  Part(Point2 pos){
    b = new Phys2(pos);
  }
  
  void update(){
    partResponce();
    wallResponce();
    b.v.scale(DRAG);
    b.update();
    b.p.renderAuto();
  }
  
  void wallResponce(){
    if(!b.p.insideScreen()){
      float tmpX = b.p.x;
      float tmpY = b.p.y;
      b.p.x = constrain(b.p.x, 0, width);
      b.p.y = constrain(b.p.y, 0, height);
      if(tmpX != b.p.x) b.v.x *= -1;
      if(tmpY != b.p.x) b.v.y *= -1;
    }
  }
  
  void partResponce(){
    for(int i=0; i<parts.size(); i++){
      Part temp = ((Part) parts.get(i));
      if(!b.p.equals(temp.b.p)){
        float distance2D = dist2(b.p, temp.b.p, 0.1);
        float distance2A = dist2(b.p, temp.b.p, 0.01);
        float factor = (1/(distance2D))*DETRACTION;
        //float factor = smartDetraction(distance2, 1, 1)*DETRACTION;
        b.a.x -= cos(b.p.angleBetween(temp.b.p))*factor;
        b.a.y -= sin(b.p.angleBetween(temp.b.p))*factor;
        factor = (1/distance2A)*ATTRACTION;
        //factor = 0.00005;
        b.a.x += cos(b.p.angleBetween(temp.b.p))*factor;
        b.a.y += sin(b.p.angleBetween(temp.b.p))*factor;
      }
    }
  }
  
}

float dist2(Point2 a, Point2 b){
  return (a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y);
}

float dist2(Point2 a, Point2 b, float k){
  return ((a.x-b.x)*k)*((a.x-b.x)*k) + ((a.y-b.y)*k)*((a.y-b.y)*k);
}

float smartDetraction(float distance, float volume, float exponent){
  return sin( (0.5*PI) / (pow(distance*volume, exponent) +1) );
}
