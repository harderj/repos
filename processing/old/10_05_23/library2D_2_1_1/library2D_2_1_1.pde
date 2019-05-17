import point2line.*;

ArrayList phys, forces;
int physID = 0;

void setup(){
  size(500,500);
  smooth();
  
  phys = new ArrayList();
  forces = new ArrayList();
  
  phys.add(new Phys2());
  phys.add(new Phys2());
  
  float[] tmpPara ={0.1};
  
  //forces.add(new Force2("attraction", tmpPara, ));
  
  println(((Phys2) phys.get(0)).t);
  println(((Phys2) phys.get(1)).t);
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



