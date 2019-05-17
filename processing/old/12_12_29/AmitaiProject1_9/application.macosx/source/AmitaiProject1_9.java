import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class AmitaiProject1_9 extends PApplet {


int dollyCount = 50;
int genomeLength = 2000;
int gridScale = 10;
float dollyDrawSize = 5;
float goalDrawSize = 8;
float startDrawSize = 10;
float colorTolerance = 29;
float mutationRate = 0.05f;
float distanceFactor = 1000;
float timeFactor = 5;
int naturalSelectionInterval = 100;
int startDirection = 4;
int goalValue = 1000;
float ageFactor = 3;
float goalDistanceRequired = 10;

PFont font;
PImage floorPlan;
Dolly[] dollys;
ArrayList goals;
IntVect start;
int time;
float bestValue;
int[] bestGenes;
int bestAge;
IntVect[] bestPath;
int outPutNum;

public void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  smooth();
  frameRate(60);
  font = loadFont("Serif-48.vlw");
  dollys = new Dolly[dollyCount];
  goals = new ArrayList();

  start = new IntVect(width*0.90f, height*0.15f);
  time = 0;
  outPutNum = 0;

  bestValue=0;
  bestGenes = new int[genomeLength];
  bestAge=0;
  bestPath= new IntVect[genomeLength];

  for (int i=0;i<dollyCount;i++) dollys[i] = new Dolly(i);
}

public void draw() {
  background(floorPlan);
  for (int i=0;i<dollyCount;i++) dollys[i].update();

  drawInfo();
  time++;
}

public void drawInfo() {
  stroke(0);
  strokeWeight(3);
  noFill();
  ellipse(start.x, start.y, startDrawSize, startDrawSize);
  fill(255, 0, 0);
  textFont(font, 15);
  for (int i=0;i<goals.size();i++) ((IntVect) goals.get(i)).draw(i, goalDrawSize);
  topText(10, 20);
  renderBestPath();
}

public void renderBestPath() {
  noFill();
  stroke(80);
  strokeWeight(2);
  beginShape();
  for (int i=0; i<bestAge;i++) {
    vertex(bestPath[i].x, bestPath[i].y);
  }
  endShape();
}

public void topText(float x, float y) {
  fill(0, 120, 0);
  textFont(font, 12);
  text("Keycommands: 'n'=add goal, 'r'=remove goal, 'g'=move goal, 's'=move start, 'p'=print instructions for current best path, 'c'=start over", x, y);
  text("FrameRate: " + PApplet.parseInt(frameRate), x, y+15);
  text("Time: " + time, x, y+30);
}

public void keyPressed() {
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
    if (goals.size() > 0) {
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
  if ( key=='p') {
    printBestPath();
  }

  if ( key=='c') {
    bestValue=0;
    bestAge=0;
    for (int i=0;i<dollys.length;i++) {
      dollys[i] = new Dolly(i);
    }
    for (int i=0;i<genomeLength;i++) {
      bestGenes[i] = 0;
      bestPath[i] = new IntVect(0, 0);
    }
  }
}

public void printBestPath() {
  String[] strings = new String[bestAge];
  int a=0;
  int n=0;
  for (int i=0; i<bestAge; i++) {
    int b = bestGenes[i];
    if (b==0) a++;
    else {
      String s;
      s="";
      if (a!=0) s = ("take " + a + " steps and ");
      if (b==1) s += "turn left 45 degrees";
      if (b==2) s += "turn right 45 degrees";
      a=1;
      strings[n] = s;
      println(s);
      n++;
    }
  }
  saveStrings("path_" + outPutNum + ".txt", strings);
}

class Dolly {
  int ID;
  int[] genome;
  IntVect[] path;
  IntVect p; // position
  int c;
  int d;
  int age; // current age
  int reincarnations;
  int goalsReached;
  float value;

  Dolly(int i) {
    ID = i;
    genome = new int[genomeLength];
    path = new IntVect[genomeLength];
    p = new IntVect(start);
    c = color(random(255), random(255), random(255));
    reincarnations = 0;
    newGenome();
    restart();
  }

  public void update() {
    act();
    die();
    render();
  }

  public void act() {
    move(genome[age]);
    path[age].set(p);
    float dis = 9999999;
    if (goalsReached < goals.size()) {
      dis = p.dist(((IntVect) goals.get(goalsReached)));
      if (dis<goalDistanceRequired && goalsReached < goals.size()-1) {
        goalsReached ++;
      }
      dis = p.dist(((IntVect) goals.get(goalsReached)));
      float v = calculateValue(dis);
      if (v>bestValue) {
        for (int i=0; i<age; i++) {
          bestGenes[i] = genome[i];
          bestPath[i] = path[i];
        }
        bestValue = v;
        bestAge = age;
      }
    }
    age++;
  }

  public void restart() {
    age=0;
    d=startDirection;
    goalsReached = 0;
    p.set(start);
    for (int i=0; i<genomeLength; i++) {
      path[i] = new IntVect(start);
    }
  }

  public void mixWith(int[] g) {
    for (int i=0; i<genome.length; i++) {
      if (i<bestAge) genome[i] = g[i];
    }
  }

  public int[] mutate(int[] f, int t) {
    for (int i=0; i<f.length; i++) {
      float a = random(1);
      if (a<mutationRate*((PApplet.parseFloat(i)/PApplet.parseFloat(t*2)))) f[i] = randomGene();
    }
    return f;
  }

  public void newGenome() {
    for (int i=0; i<genomeLength; i++) {
      genome[i] = randomGene();
    }
  }

  public void die() {
    boolean alive = true;
    int g = floorPlan.get(p.x, p.y);
    if (red(g)+blue(g)+green(g) < 255*3-colorTolerance) alive = false;
    else if (age>genomeLength-2) alive = false;
    if (!alive) {
      mixWith(bestGenes);
      mutate(genome, age);
      restart();
    }
  }

  public float calculateValue(float dis) {
    IntVect currentGoal = ((IntVect) goals.get(goalsReached));
    return goalValue-dis+goalsReached*goalValue-age*ageFactor;
  }

  public void turnLeft() {
    d=(d+1)%8;
  }

  public void turnRight() {
    d=(d+7)%8;
  }

  public void move(int a) {
    if (a==1) turnLeft();
    if (a==2) turnRight();
    switch(d) {
    case 0:
      p.x+=gridScale;
      break;
    case 1:
      p.x+=gridScale;
      p.y-=gridScale;
      break;
    case 2:
      p.y-=gridScale;
      break;
    case 3:
      p.y-=gridScale;
      p.x-=gridScale;
      break;
    case 4:
      p.x-=gridScale;
      break;
    case 5:
      p.x-=gridScale;
      p.y+=gridScale;
      break;
    case 6:
      p.y+=gridScale;
      break;
    case 7:
      p.y+=gridScale;
      p.x+=gridScale;
      break;
    default:
      break;
    }
  }

  public void render() {
    noStroke();
    fill(c);
    ellipse(p.x, p.y, dollyDrawSize, dollyDrawSize);

    noFill();
    stroke(c);
    strokeWeight(1);
    beginShape();
    for (int i=1; i<age;i++) {
      vertex(path[i].x, path[i].y);
    }
    endShape();
  }
}

class IntVect {

  int x, y;

  IntVect(IntVect v) {
    x=v.x;
    y=v.y;
  }

  IntVect(int x, int y) {
    this.x=x;
    this.y=y;
  }

  IntVect(float x, float y) {
    this.x=PApplet.parseInt(x);
    this.y=PApplet.parseInt(y);
  }
  
  public IntVect copy(){
    return new IntVect(x,y);
  }

  public void set(IntVect v) {
    x=v.x;
    y=v.y;
  }

  public void set(int x, int y) {
    this.x=x;
    this.y=y;
  }

  public void set(float x, float y) {
    this.x=PApplet.parseInt(x);
    this.y=PApplet.parseInt(y);
  }

  public int dist2(int a, int b) {
    return (x-a)*(x-a)+(y-b)*(y-b);
  }

  public int dist2(float a, float b) {
    IntVect v = new IntVect(a, b);
    return dist2(v);
  }

  public int dist2(IntVect v) {
    return dist2(v.x, v.y);
  }

  public int dist(int a, int b) {
    return PApplet.parseInt(sqrt(PApplet.parseFloat(dist2(a, b))));
  }
  
  public int dist(IntVect v) {
    return dist(v.x, v.y);
  }
  
  public boolean equals(IntVect v){
    return (x==v.x && y==v.y);
  }

  public void draw(int i, float s) {
    ellipse(x, y, s, s);
    text(i, x-3, y-5);
  }
}

public int randomGene() {
  return round(random(3))%3;
}

public int[] orderDescend(float[] l){
  int lth = l.length; // lth = length of list
  int[] tmp = new int[lth];
  for(int i=0; i<lth; i++) tmp[i] = 0;

  for(int i=0; i<lth; i++){
    int n = 0;
    while(n<i){
      //println("i: " + i + " | n: " + n + " | l[i]: " + l[i] + " | tmp[n]: " + tmp[n] + " | l[tmp[n]]: " + l[tmp[n]]);
      //println(tmp);
      if(l[i]<l[tmp[n]]) n++;
      else break;
    }
    tmp = pushIntoArray(i, tmp, n);
  }

  return tmp;
}

public int[] pushIntoArray(int a, int[] l, int s){ // a = number l = list | s = startpoint of push
  int lth = l.length; // lth = length of list
  if(lth<s) return null;
  int[] tmp = new int[lth];
  for(int i=lth-1; i>=0; i--){ // important that the 'if(i==s)' statement is last, as 'a' would be copied
    if(i>s) tmp[i] = l[i-1];
    if(i==s) tmp[i] = a;
    if(i<s) tmp[i] = l[i];
  }
  return tmp;
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "AmitaiProject1_9" });
  }
}
