
int genomeLength = 2000;
int gridScale = 10;
float dollyDrawSize = 5;
float goalDrawSize = 8;
float startDrawSize = 10;
float colorTolerance = 29;
float mutationRate = 0.05;
float distanceFactor = 1000;
float timeFactor = 5;
int naturalSelectionInterval = 100;

PFont font;
PImage floorPlan;
ArrayList dollys;
ArrayList goals;
IntVect start;
int time;

void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  smooth();
  frameRate(10);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  goals = new ArrayList();

  start = new IntVect(width*0.85,height*0.75);
  time = 0;

  int n = 10;
  for (int i=0;i<n;i++) dollys.add(new Dolly());

  goals.add(new IntVect(width*0.1, height*0.8));
}

void draw() {
  time++;
  if(time%naturalSelectionInterval==0) naturalSelection();
  background(floorPlan);
  boolean allDeadCheck = true;
  for (int i=0;i<dollys.size();i++) ((Dolly) dollys.get(i)).update();
  
  drawInfo();

  stroke(0);
  strokeWeight(3);
  noFill();
  ellipse(start.x, start.y, startDrawSize, startDrawSize);
  fill(255,0,0);
  textFont(font, 15);
  for (int i=0;i<goals.size();i++) ((IntVect) goals.get(i)).draw(i, goalDrawSize);
}

void naturalSelection(){
  int s = dollys.size();
  float[] values = new float[s];
  for(int i=0;i<s;i++) values[i]=((Dolly) dollys.get(i)).value;
  int[] order = orderDescend(values);
  if(s>0) ((Dolly) dollys.get(order[s-1])).becomeChildOf(order[0]);
  if(s>1) ((Dolly) dollys.get(order[s-2])).becomeChildOf(order[0]);
  if(s>2) ((Dolly) dollys.get(order[s-3])).becomeChildOf(order[1]);
  if(s>3) ((Dolly) dollys.get(order[s-4])).becomeChildOf(order[2]);
  for(int i=0;i<s;i++) ((Dolly) dollys.get(i)).value=0;
}

void drawInfo() {
  drawFrameRate(10, 20);
}

void drawFrameRate(float x, float y) {
  fill(0, 120, 0);
  textFont(font, 12);
  text("Keycommands: 'n'=add goal, 'r'=remove goal, 'g'=move goal, 's'=move start", x, y);
  text("FrameRate: " + int(frameRate), x, y+15);
  text("Time: " + time, x, y+30);
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
    ((IntVect) goals.get(a)).set(mouseX, mouseY);
  }
  if (key == 'n') {
    goals.add(new IntVect(mouseX, mouseY));
  }
  if(key=='r'){
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
    goals.remove(a);
  }
}

