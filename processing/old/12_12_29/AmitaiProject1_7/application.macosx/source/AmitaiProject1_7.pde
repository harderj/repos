
int dollyCount = 30;
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
int startDirection = 4;
int goalValue = 1000;
float ageFactor = 2;
float goalDistanceRequired = 10;

PFont font;
PImage floorPlan;
Dolly[] dollys;
ArrayList goals;
IntVect start;
int time;
int bestDolly, worstDolly;
float bestValue;
int[] bestGenes;
int bestAge;
IntVect[] bestPath;
int outPutNum;

void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  smooth();
  //frameRate(3);
  font = loadFont("Serif-48.vlw");
  dollys = new Dolly[dollyCount];
  goals = new ArrayList();

  start = new IntVect(width*0.85, height*0.75);
  time = 0;
  outPutNum=0;

  bestValue=0;
  bestGenes = new int[genomeLength];
  bestAge=0;
  bestPath= new IntVect[genomeLength];

  for (int i=0;i<dollyCount;i++) dollys[i] = new Dolly(i);

  goals.add(new IntVect(width*0.62, height*0.72));
  goals.add(new IntVect(width*0.4, height*0.7));
  goals.add(new IntVect(width*0.7, height*0.3));
  goals.add(new IntVect(width*0.85, height*0.6));
}

void draw() {
  time++;
  naturalSelection();
  background(floorPlan);
  boolean allDeadCheck = true;
  for (int i=0;i<dollyCount;i++) dollys[i].update();

  drawInfo();

  stroke(0);
  strokeWeight(3);
  noFill();
  ellipse(start.x, start.y, startDrawSize, startDrawSize);
  fill(255, 0, 0);
  textFont(font, 15);
  for (int i=0;i<goals.size();i++) ((IntVect) goals.get(i)).draw(i, goalDrawSize);
}

void naturalSelection() {
  int s = dollys.length;
  float[] values = new float[s];
  for (int i=0;i<s;i++) values[i]=dollys[i].value;
  int[] order = orderDescend(values);
  bestDolly = order[0];
  worstDolly = order[s-1];
}

void drawInfo() {
  topText(10, 20);
  renderBestPath();
}

void renderBestPath() {
  noFill();
  stroke(80);
  strokeWeight(2);
  beginShape();
  for (int i=0; i<bestAge;i++) {
    vertex(bestPath[i].x, bestPath[i].y);
  }
  endShape();
}

void topText(float x, float y) {
  fill(0, 120, 0);
  textFont(font, 12);
  text("Keycommands: 'n'=add goal, 'r'=remove goal, 'g'=move goal, 's'=move start, 'p'=print instructions for current best path", x, y);
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
  if (key=='r') {
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
  if( key=='p'){
    printBestPath();
  }
}

void printBestPath(){
  String[] strings = new String[bestAge];
  int a=0;
  int n=0;
  for(int i=0; i<bestAge; i++){
    int b = bestGenes[i];
    if(b==0) a++;
    else{
      String s;
      s="";
      if(a!=0) s = ("take " + a + " steps and ");
      if(b==1) s += "turn left 45 degrees";
      if(b==2) s += "turn right 45 degrees";
      a=1;
      strings[n] = s;
      println(s);
      n++;
    }
  }
  saveStrings("path_" + outPutNum + ".txt", strings);
}

