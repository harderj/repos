class Part{
  
  Phys2 b;
  
  Part(Point2 pos){
    b = new Phys2(pos);
  }
  
  void update(){
    partResponce();
    b.v.scale(DRAG);
    b.update();
    b.p.renderAuto();
  }
  
  void partResponce(){
    for(int i=0; i<parts.size(); i++){
      Part temp = ((Part) parts.get(i));
      if(!b.p.equals(temp.b.p)){
        float distance2 = dist2(b.p, temp.b.p);
        float factor = smartDetraction(distance2, 1, 1)*DETRACTION;
        b.a.x -= cos(b.p.angleBetween(temp.b.p))*factor;
        b.a.y -= sin(b.p.angleBetween(temp.b.p))*factor;
        factor = ATTRACTION;
        b.a.x += cos(b.p.angleBetween(temp.b.p))*factor;
        b.a.y += sin(b.p.angleBetween(temp.b.p))*factor;
      }
    }
  }
  
}

float dist2(Point2 a, Point2 b){
  return (a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y);
}

float smartDetraction(float distance, float volume, float exponent){
  return sin( (0.5*PI) / (pow(distance*volume, exponent) +1) );
}
