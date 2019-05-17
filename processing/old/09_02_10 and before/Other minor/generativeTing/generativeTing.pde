import processing.opengl.*;

ArrayList rays, sunlings;

float sunPosX, sunPosY;
float mutativity, gravity, rayEnergy;

void setup(){
  size(1000,600,OPENGL);
  frameRate(25);
  background(0);
  ellipseMode(CENTER);
  smooth();

  rays = new ArrayList();
  sunlings = new ArrayList();
  
  sunPosX = width/2;
  sunPosY = 0;
  
  mutativity = 0.5;
  gravity = 1;
  rayEnergy = 50;
}

void draw(){
  fade();
  sun();
  arrayUpdate();
}

void sun(){
  fill(255,255,100);
  stroke(255);
  strokeWeight(2);
  ellipse(sunPosX,sunPosY,30,30);
  
  for(int i=0; i<5; i++){
    if(random(1000)<500){
      rays.add(new Ray(sunPosX,sunPosY,random(PI*2)));
    }
  }
}

void arrayUpdate(){
  for(int i=0; i<rays.size(); i++){
    if(((Ray) rays.get(i)).act) ((Ray) rays.get(i)).draw(); 
    else rays.remove(i);
  }
  
  for(int i=0; i<sunlings.size(); i++){
    if(((Sunling) sunlings.get(i)).act) ((Sunling) sunlings.get(i)).draw(); 
    else sunlings.remove(i);
  }
}

void fade(){
  noStroke();
  fill(0,0,0,50);
  rect(0,0,width,height);
}

void mousePressed(){
  sunlings.add(new Sunling(mouseX,mouseY,rayEnergy*4));
}
