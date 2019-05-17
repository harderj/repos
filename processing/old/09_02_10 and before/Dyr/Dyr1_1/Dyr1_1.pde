V2 gGravity;
float gDrag = 0.95;
float gSpeed = 1.0;
float gLoss = 0.2;
float gRotate = gSpeed*0.8;
float gRotateSpeed = PI*0.2;
float gRotateDrag = 0.7;

ArrayList dyrs;

void setup(){
  size(700,700);
  dyrs = new ArrayList();

  gDrag = 0.95;
  gSpeed = 1.0;
  gLoss = 0.2;
  gRotate = gSpeed*0.8;
  gRotateSpeed = PI*0.2;
  gRotateDrag = 0.7;
  
  gGravity = new V2(0.1,0.1);
}

void draw(){
  background(0);

  updArr();
}

void updArr(){
  for(int i=0; i<dyrs.size(); i++) if(((Dyr) dyrs.get(i)).is) ((Dyr) dyrs.get(i)).upd();
}

void mousePressed(){
  V2 tmp = new V2(mouseX,mouseY);
  dyrs.add(new Dyr(tmp, 3, 1, 5, 4, color(random(255), random(255), random(255))));

}
