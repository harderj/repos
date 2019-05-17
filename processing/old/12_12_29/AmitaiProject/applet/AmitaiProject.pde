float dollyDrawSize = 10;

PFont font;
PImage floorPlan;
ArrayList dollys;

void setup() {
  floorPlan = loadImage("floorPlan.jpeg");
  size(floorPlan.width, floorPlan.height);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  
  
  
  // first test dolly

  //Dolly d1 = new Dolly(int(width*0.5), int(height*0.5));
  int n = 200;
  for (int i=0;i<n;i++) dollys.add(new Dolly(int(width*0.5), int(height*0.5)));
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

