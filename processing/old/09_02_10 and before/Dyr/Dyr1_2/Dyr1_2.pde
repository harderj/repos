V2 gGravity;
float gDrag = 0.9;
float gSpeed = 2;
float gLoss = 0.001;
float gMove = 1;
float gRotateSpeed = PI*0.1;
float gRotateDrag = 0.9;
float gSpeedActivity;

ArrayList dyrs;

void setup(){
  size(700,700);
  dyrs = new ArrayList();
  gGravity = new V2(0.0,0.0);
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
  dyrs.add(new Dyr(tmp, 10, 4, 30, 4, color(random(255), random(255), random(255))));

}
