final float DRAG = 1;
final float GRAVITY = 0.01;

ArrayList rigids;

void setup(){
  
  size(500,500);
  smooth();
  
  rigids = new ArrayList();
  
  rigids.add(new RigidLine(new Line2(randomPoint2Screen(), randomPoint2Screen())));
  
}

void draw(){
  background(0);
  
  updateRigids();
}

void updateRigids(){
  for(int i=0; i<rigids.size(); i++){
    iRigid r = (iRigid) rigids.get(i);
    r.update();
  }
}
