import point2line.*;

ArrayList phys, forces;

Phys2 a,b,c,d;

Force2 f1;

Phys2[] partList;

void setup(){
  size(500,500);
  smooth();

  a = new Phys2(randomPoint2Screen());
  b = new Phys2(randomPoint2Screen());
  c = new Phys2(randomPoint2Screen());
  d = new Phys2(randomPoint2Screen());

  partList = new Phys2[4];
  partList[0] = a;
  partList[1] = b;
  partList[2] = c;
  partList[3] = d;

  phys = new ArrayList();
  forces = new ArrayList();

  float[] tmpPara = {
    0.1  };

  f1 = new Force2("attraction", tmpPara, new Phys2[] = {
    a, b, c, d  }
  );
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




