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

public class AmitaiProject1_2 extends PApplet {


int genomeLength = 2000;
int startX;
int startY;
float dollyDrawSize = 10;
float colorTolerance = 29;
float probabilityGeneMutation = 0.005f;
float distanceFactor = 1000;
float timeFactor = 5;

PFont font;
PImage floorPlan;
ArrayList dollys;
ArrayList goals;

public void setup() {
  floorPlan = loadImage("floorPlanWithoutMeasurements.jpeg");
  size(floorPlan.width, floorPlan.height);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  goals = new ArrayList();
  
  startX = PApplet.parseInt(width*0.8f);
  startY = PApplet.parseInt(height*0.2f);
  
  // first test dolly
  // Dolly d1 = new Dolly(int(width*0.5), int(height*0.5));
  
  int n = 100;
  for (int i=0;i<n;i++) dollys.add(new Dolly(startX,startY));
  
  goals.add(new Goal(width*0.1f, height*0.8f));
}

public void draw() {
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

public void restartDollys(){
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

public void drawInfo() {
  drawFrameRate(10, 20);
}

public void drawFrameRate(float x, float y) {
  textFont(font, 20);
  fill(0, 120, 0);
  text("FrameRate: " + PApplet.parseInt(frameRate), x, y);
}

public float dist2(float a, float b, float c, float d) {
  float x=a-c;
  float y=b-d;
  return x*x+y*y;
}


class Dolly {

  int[] genome;
  int x, y;
  int c;
  int d;
  int l;
  int goalsReached;
  boolean alive;

  Dolly(int x, int y) {
    genome = new int[genomeLength];
    newGenome();
    this.x = x;
    this.y = y;
    c = color(random(255), random(255), random(255));
    restartBasics();
  }

  public void update() {
    if (alive) act();
    die();
    draw();
  }
  
  public void restartBasics(){
    l=0;
    goalsReached = 0;
    alive = true;
    d=0;
    x=startX;
    y=startY;
  }

  public void restart(int[] fatherGenome) {
    restartBasics();
    genome = mutated(fatherGenome);
  }

  public int[] mutated(int[] f) {
    int[] r = new int[f.length];
    for (int i=0; i<f.length; i++) {
      r[i] = f[i];
      float a = random(1);
      if (a<probabilityGeneMutation){
        if (f[i]==0) r[i]=1+PApplet.parseInt(random(2)%2);
        else r[i]=0;
      }
    }
    return r;
  }

  public void newGenome() {
    for (int i=0; i<genomeLength; i++) {
      genome[i]=0;
      float probabilityLeft = 0.01f;
      float probabilityRight = 0.01f;
      float a = random(1);
      if (a<probabilityLeft) genome[i]=1;
      else if (a<probabilityLeft + probabilityRight) genome[i]=2;
    }
  }

  public void die() {
    if (l>genomeLength-1) alive = false;
    int g = floorPlan.get(x, y);
    if (red(g)+blue(g)+green(g) < 255*3-colorTolerance) {
      alive = false;
    }
  }
  
  public float value(){
    Goal currentGoal = ((Goal) goals.get(goalsReached));
    return 1000000/sqrt(dist2(x,y,currentGoal.x,currentGoal.y));
  }

  public void randomizeDirection() {
    d = round(random(8))%8;
  }

  public void act() {
    if (genome[l]==0) moveForward();
    if (genome[l]==1) turnLeft();
    if (genome[l]==2) turnRight();
    if (alive) l++;
  }

  public void turnLeft() {
    d=(d+7)%8;
  }

  public void turnRight() {
    d=(d+1)%8;
  }

  public void moveForward() {
    switch(d) {
    case 0:
      x++;
      break;
    case 1:
      x++;
      y--;
      break;
    case 2:
      y--;
      break;
    case 3:
      y--;
      x--;
      break;
    case 4:
      x--;
      break;
    case 5:
      x--;
      y++;
      break;
    case 6:
      y++;
      break;
    case 7:
      y++;
      x++;
      break;
    default:
      break;
    }
  }

  public void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, dollyDrawSize, dollyDrawSize);
  }
}

class Goal{
  int x,y;
  
  Goal(int x, int y){
    this.x=x;
    this.y=y;
  }
  
  Goal(float x, float y){
    
    this.x=PApplet.parseInt(x);
    this.y=PApplet.parseInt(y);
  }
  
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "AmitaiProject1_2" });
  }
}
