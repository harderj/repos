float dollyDrawSize = 10;
float colorTolerance = 50;
int startX, startY;

PFont font;
PImage floorPlan;
ArrayList dollys;

void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  
  startX = int(width*0.5);
  startY = int(height*0.5);
  
  // first test dolly
  // Dolly d1 = new Dolly(int(width*0.5), int(height*0.5));
  
  int n = 200;
  for (int i=0;i<n;i++) dollys.add(new Dolly(startX,startY));
}

void draw() {
  background(floorPlan);

  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).update();
  }

  drawInfo();
}

void drawInfo() {
  drawFrameRate(10, 20);
}

void drawFrameRate(float x, float y) {
  textFont(font, 20);
  fill(0, 120, 0);
  text("FrameRate: " + int(frameRate), x, y);
}

