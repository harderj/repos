import point2line.*;

ArrayList phys, forces;

Phys2 t1, t2;
Force2 f1;

void setup(){
  size(500,500);
  smooth();
  
  phys = new ArrayList();
  forces = new ArrayList();
  
  t1 = new Phys2();
  t2 = new Phys2();
  
  f1 = new Force2();
}

void draw(){
  background(255);
  
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



