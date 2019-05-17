V2 gGravity;
float gDrag = 0.95;
float gSpeed = 0.1;
float gLoss = 0.1;
float gRotateSpeed = PI*0.2;
float gRotateDrag = 0.9;
float gAlgeGrowth = 0.002;
float gAlgeSize = 1;
float gAlgeBirth = 20;
float gMouthMax = 1.2;
float gMouthMin = 0.5;
float gFoodUseability = 0.1;
float gMutation = 0.1;

ArrayList dyrs, alges;

void setup(){
  size(700,700);
  dyrs = new ArrayList();
  alges = new ArrayList();
  gGravity = new V2(0.0,0.0);
  ellipseMode(CENTER);
}

void draw(){
  background(0);
  V2 tmp = new V2(random(0,width),random(0,height));
  if(random(1000)<gAlgeBirth) alges.add(new Alge(tmp));
  updArr();
}

void updArr(){
  for(int i=0; i<dyrs.size(); i++) if(((Dyr) dyrs.get(i)).is) ((Dyr) dyrs.get(i)).upd();
  for(int i=0; i<alges.size(); i++) if(((Alge) alges.get(i)).is) ((Alge) alges.get(i)).upd();
}

void mousePressed(){
  if(mouseButton==LEFT){
    V2 tmp = new V2(mouseX,mouseY);
    dyrs.add(new Dyr(tmp, 10, 5, 2, 2, color(random(255), random(50), random(255))));
  } 
  else {
    V2 tmp = new V2(mouseX,mouseY);
    alges.add(new Alge(tmp));
  }
}
