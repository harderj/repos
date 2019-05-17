import point2line.*;

Phys2 t1, t2, t3;
Force2 f1;

void setup(){
  size(500,500);
  smooth();
  
  t1 = new Phys2(randomPoint2Screen());
  t2 = new Phys2(randomPoint2Screen());
  t3 = new Phys2(randomPoint2Screen());
  
  float[] tmpPara = {0.1};
  
  f1 = new Force2("attraction", tmpPara, t1, t2, t3);
}

void draw(){
  background(255);
  
  t1.update();
  t2.update();
  t3.update();
  f1.update();
  
  t1.p.renderAuto();
  t2.p.renderAuto();
  t3.p.renderAuto();
}



