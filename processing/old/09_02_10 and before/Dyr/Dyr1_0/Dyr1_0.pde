V2 gravity = new V2(0.0,0.0);
float gDrag = 0.95;
float gSpeed = 1.0;
float gLoss = 0.2;
float gRotate = gSpeed*0.25;
float gRotateSpeed = PI*0.2;

void setup(){
  size(700,700);
}

void draw(){
  background(0);
  
  updArr();
}

void updArr(){
  for(int i=0; i<dyrs.size(); i++) if(((Dyr) dyrs.get(i)).is) ((Dyr) dyrs.get(i)).upd();
}
