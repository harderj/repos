import point2line.*;

ArrayList phys, forces;

Phys2 a,b,c,d;

Force2 f1;

void setup(){
  size(500,500);
  smooth();
  
  a = new Phys2(randomPoint2Screen());
  b = new Phys2(randomPoint2Screen());
  c = new Phys2(randomPoint2Screen());
  d = new Phys2(randomPoint2Screen());
  
  Phys2[] partList = { a, b, c, d };
  
  phys = new ArrayList();
  forces = new ArrayList();
  
  float[] tmpPara = {0.1};
  
  f1 = new Force2("attraction", tmpPara, partList);
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



