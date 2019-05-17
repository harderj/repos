
int genomeLength = 2000;
int startX;
int startY;
float dollyDrawSize = 10;
float colorTolerance = 29;
float probabilityGeneMutation = 0.005;
float distanceFactor = 1000;
float timeFactor = 5;

PFont font;
PImage floorPlan;
ArrayList dollys;
ArrayList goals;

void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  goals = new ArrayList();
  
  startX = int(width*0.8);
  startY = int(height*0.2);
  
  // first test dolly
  // Dolly d1 = new Dolly(int(width*0.5), int(height*0.5));
  
  int n = 100;
  for (int i=0;i<n;i++) dollys.add(new Dolly(startX,startY));
  
  goals.add(new Goal(width*0.1, height*0.8));
}

void draw() {
  background(floorPlan);
  boolean allDeadCheck = true;
  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).update();
    allDeadCheck = (allDeadCheck && !((Dolly) dollys.get(i)).alive);
  }
  if(allDeadCheck) restartDollys();
  drawInfo();
  
  stroke(0);
  noFill();
  ellipse(startX, startY, 10,10);
  for (int i=0;i<goals.size();i++) ellipse(((Goal) goals.get(i)).x, ((Goal) goals.get(i)).y, 15,15);
}

void restartDollys(){
  int bestID = 0;
  float best = 0;
  for (int i=0;i<dollys.size();i++) {
    float v = ((Dolly) dollys.get(i)).value();
    if( v > best) {
      bestID = i;
      best = v;
    }
  }
  println(bestID);
  println(best);
  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).restart(((Dolly) dollys.get(bestID)).genome);
  }
}

void drawInfo() {
  drawFrameRate(10, 20);
}

void drawFrameRate(float x, float y) {
  textFont(font, 20);
  fill(0, 120, 0);
  text("FrameRate: " + int(frameRate), x, y);
}

float dist2(float a, float b, float c, float d) {
  float x=a-c;
  float y=b-d;
  return x*x+y*y;
}


