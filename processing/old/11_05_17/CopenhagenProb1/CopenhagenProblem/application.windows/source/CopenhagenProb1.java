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

public class CopenhagenProb1 extends PApplet {

public void setup() {
  size(400,400);
  smooth();
  background(255);
}

float dt = 0.1f;
float t = 1;
State s1 = new State(new Vect(50,20), new Vect(-9,0));
State s2 = new State(new Vect(50,20), new Vect(-9,0));

public void draw() {
  fill(255,4);
  rect(-10,-10,width*2,height*2);
  //background(255);
  translate(width*0.5f,height*.5f);
  scale(1.7f);
  
  // RK4
  
  RK4(s1,t,dt);
  noStroke();
  fill(0,255,0);
  ellipse(s1.z.x,s1.z.y,10,10);
  fill(0);
  ellipse(s1.z.x,s1.z.y,5,5);
  
  // EULER
  
  EULER(s2,t,dt);
  noStroke();
  fill(255,0,0);
  ellipse(s2.z.x,s2.z.y,10,10);
  fill(0);
  ellipse(s2.z.x,s2.z.y,5,5);
  
  int left = 3;
  int right = 10;
  //println(nfp((s1.x-s2.x),left,right) + "    " + nfp((s1.v-s2.v),left,right));
  
  fill(0);
  ellipse(p1.x,p1.y,10,10);
  ellipse(p2.x,p2.y,10,10);
  
  t+=dt;
}

Vect p1 = new Vect(-50,0);
Vect p2 = new Vect(50,0);

public Vect acceleration(State state, float t) {
  Vect d1 = new Vect(p1.x-state.z.x, p1.y-state.z.y);
  Vect d2 = new Vect(p2.x-state.z.x, p2.y-state.z.y);
  
  float dist21 = sq(d1.x) + sq(d1.y);
  float dist22 = sq(d2.x) + sq(d2.y);
  
  float f1 = 1000/dist21;
  float f2 = 1000/dist22;
  
  float ang1 = atan2(d1.y, d1.x);
  float ang2 = atan2(d2.y, d2.x);
  
  Vect fin = new Vect(f1*cos(ang1) + f2*cos(ang2),f1*sin(ang1) + f2*sin(ang2));
  
  return new Vect(fin.x, fin.y);
}


public void keyPressed(){
  if(key=='p') saveFrame();
}

class Vect {
  float x,y;
  Vect() {
    x=0;
    y=0;
  }
  Vect(float _x, float _y) {
    x = _x;
    y = _y;
  }
  Vect(Vect v) {
    x = v.x;
    y = v.y;
  }
}

class State {
  Vect z, v;
  State() {
    z = new Vect();
    v = new Vect();
  }
  State(Vect _z) {
    z = _z;
    v = new Vect();
  }
  State(Vect _z, Vect _v) {
    z = _z;
    v = _v;
  }
}

class Derivative {
  Vect dz, dv;
  Derivative() {
    dz = new Vect();
    dv = new Vect();
  }
  Derivative(Vect _dz) {
    dz = _dz;
    dv = new Vect();
  }
  Derivative(Vect _dz, Vect _dv) {
    dz = _dz;
    dv = _dv;
  }
}
public void EULER(State state, float t, float dt){
  Derivative a = evaluate(state, t, 0.0f, new Derivative());
  
  Vect dzdt,dvdt;
  dzdt = a.dz;
  dvdt = a.dv;
  
  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}


public Derivative evaluate(State initial, float t, float dt, Derivative d) {
  State state = new State();
  state.z.x = initial.z.x + d.dz.x*dt;
  state.z.y = initial.z.y + d.dz.y*dt;
  state.v.x = initial.v.x + d.dv.x*dt;
  state.v.y = initial.v.y + d.dv.y*dt;

  Derivative output = new Derivative();
  output.dz.x = state.v.x;
  output.dz.y = state.v.y;
  output.dv = acceleration(state, t+dt);
  return output;
}


public void RK4(State state, float t, float dt){
  Derivative a = evaluate(state, t, 0.0f, new Derivative());
  Derivative b = evaluate(state, t+dt*0.5f, dt*0.5f, a);
  Derivative c = evaluate(state, t+dt*0.5f, dt*0.5f, b);
  Derivative d = evaluate(state, t+dt, dt, c);
  
  Vect dzdt = new Vect();
  Vect dvdt = new Vect();
  dzdt.x = 1.0f/6.0f * (a.dz.x + 2.0f*(b.dz.x + c.dz.x) + d.dz.x);
  dzdt.y = 1.0f/6.0f * (a.dz.y + 2.0f*(b.dz.y + c.dz.y) + d.dz.y);
  dvdt.x = 1.0f/6.0f * (a.dv.x + 2.0f*(b.dv.x + c.dv.x) + d.dv.x);
  dvdt.y = 1.0f/6.0f * (a.dv.y + 2.0f*(b.dv.y + c.dv.y) + d.dv.y);

  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ffffff", "CopenhagenProb1" });
  }
}
