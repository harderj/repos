
int genomeLength = 2000;
float dollyDrawSize = 5;
float goalDrawSize = 8;
float colorTolerance = 29;
float mutationRate = 0.05;
float distanceFactor = 1000;
float timeFactor = 5;

PFont font;
PImage floorPlan;
ArrayList dollys;
ArrayList goals;
IntVect start;

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
  for (int i=0;i<n;i++) dollys.add(new Dolly(startX, startY));

  goals.add(new IntVect(width*0.1, height*0.8));
}

void draw() {
  background(floorPlan);
  boolean allDeadCheck = true;
  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).update();
    allDeadCheck = (allDeadCheck && !((Dolly) dollys.get(i)).alive);
  }
  if (allDeadCheck) restartDollys();
  drawInfo();

  stroke(0);
  strokeWeight(3);
  noFill();
  ellipse(startX, startY, 10, 10);
  for (int i=0;i<goals.size();i++) ((IntVect) goals.get(i)).render(i, goalDrawSize);
}

void restartDollys() {
  int bestID = 0;
  float best = 0;
  for (int i=0;i<dollys.size();i++) {
    float v = ((Dolly) dollys.get(i)).value();
    if ( v > best) {
      bestID = i;
      best = v;
    }
  }
  println(bestID);
  println(best);
  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).reincarnate(((Dolly) dollys.get(bestID)).genome);
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

int randomGene() {
  return round(random(8))%8;
}

void keyPressed() {
  if (key=='s') {
    start.set(mouseX, mouseY);
  }
  if (key=='g') {
    int a=0;
    int d=-1;
    for (int i=0;i<goals.size();i++) {
      IntVect v = new IntVect((IntVect) goals.get(i));
      int ds = v.dist2(mouseX, mouseY); // ds for distance squared
      if (d>ds || d==-1) {
        d=ds;
        a=i;
      }
    }
    ((IntVect) goals.get(i)).set(mouseX, mouseY);
  }
  if (key == 'n') {
    goals.add(new IntVect(mouseX, mouseY));
  }
}

