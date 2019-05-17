import point2line.*;

ArrayList phys, forces;

Force2 f1;

void setup(){
  size(500,500);
  smooth();
  
  phys = new ArrayList();
  forces = new ArrayList();
  
  phys.add(new Phys2(randomPoint2Screen(), "cat"));
  phys.add(new Phys2(randomPoint2Screen(), "cat"));
  phys.add(new Phys2(randomPoint2Screen(), "cat"));
  phys.add(new Phys2(randomPoint2Screen(), "cat"));
  
  float[] tmpPara = {0.1};
  
  f1 = new Force2("attraction", tmpPara, "cat");
}

void draw(){
  background(255);
  
  f1.update();
  f1.render();
  
  update();
}

void update(){
  
  for(int i=0; i<phys.size(); i++){
    ((Phys2) phys.get(i)).update();
  }
  
  for(int i=0; i<forces.size(); i++){
    ((Force2) forces.get(i)).update();
  }
  
}



