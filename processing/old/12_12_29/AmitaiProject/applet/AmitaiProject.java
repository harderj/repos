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

public class AmitaiProject extends PApplet {

float dollyDrawSize = 10;

PFont font;
PImage floorPlan;
ArrayList dollys;

public void setup() {
  floorPlan = loadImage("floorPlan.jpeg");
  size(floorPlan.width, floorPlan.height);
  font = loadFont("Serif-48.vlw");
  dollys = new ArrayList();
  
  
  
  // first test dolly

  //Dolly d1 = new Dolly(int(width*0.5), int(height*0.5));
  int n = 200;
  for (int i=0;i<n;i++) dollys.add(new Dolly(PApplet.parseInt(width*0.5f), PApplet.parseInt(height*0.5f)));
}

public void draw() {
  background(floorPlan);

  for (int i=0;i<dollys.size();i++) {
    ((Dolly) dollys.get(i)).update();
  }

  drawInfo();
}

public void drawInfo() {
  drawFrameRate(10, 20);
}

public void drawFrameRate(float x, float y) {
  textFont(font, 20);
  fill(0, 120, 0);
  text("FrameRate: " + PApplet.parseInt(frameRate), x, y);
}

class Dolly {

  int x, y;
  int c;
  int d;

  Dolly(int x, int y) {
    this.x = x;
    this.y = y;
    c = color(random(255), random(255), random(255));
    d = PApplet.parseInt(random(3));
  }

  Dolly(int x, int y, int startDirection, int paint) {
    this.x = x;
    this.y = y;
    d = startDirection;
    c = paint;
  }

  public void update() {
    act();
    draw();
  }

  public void act() {
    float probabilityLeft = 0.01f;
    float probabilityRight = 0.01f;
    float a = random(1);
    if (a<probabilityLeft) turnLeft();
    else if (a<probabilityLeft + probabilityRight) turnRight();
    else moveForward();
  }

  public void turnLeft() {
    d=(d+3)%4;
  }

  public void turnRight() {
    d=(d+1)%4;
  }

  public void moveForward() {
    switch(d) {
    case 0:
      x++;
      break;
    case 1:
      y--;
      break;
    case 2:
      x--;
      break;
    case 3:
      y++;
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

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "AmitaiProject" });
  }
}
