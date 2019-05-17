import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class tankDuel2_22 extends PApplet {



int playerNum = 2;

ArrayList players;
ArrayList missiles;
ArrayList buttons;

PFont font;

public void setup(){
  size(800,800, OPENGL);
  frameRate(25);
  smooth();
  font = loadFont("Courier-48.vlw");
  
  players = new ArrayList();
  missiles = new ArrayList();
  buttons = new ArrayList();
  
  buttons.add(new Button('a'));
  buttons.add(new Button('d'));
  buttons.add(new Button('w'));
  buttons.add(new Button('s'));
}

public void draw(){
  background(0);
  updateArrays();
  
  // button class test
  if(getButtonState('a') == "press") fill(0,255,0);
  if(getButtonState('a') == "on") fill(100);
  if(getButtonState('a') == "release") fill(255,0,0);
  if(getButtonBinary('a')) stroke(255); else noStroke();
  ellipse(50,50,50,50);
}

public void updateArrays(){
  /*
  for(int i=0; i<players.size(); i++) if(((Player) players.get(i)).is) ((Player) players.get(i)).draw();
  else players.remove(i);
  
  for(int i=0; i<missiles.size(); i++) if(((Missile) missiles.get(i)).is) ((Missile) missiles.get(i)).draw();
  else missiles.remove(i);
  */
  for(int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).is) ((Button) buttons.get(i)).draw();
  else buttons.remove(i);
}


// button

// call

public String getButtonState(char button){
  char tmpFind = button;
  String tmpButtonState = "";

  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      tmpButtonState = ((Button) buttons.get(i)).state;
    }
  }
  
  return tmpButtonState;
}

public boolean getButtonBinary(char button){
  char tmpFind = button;
  boolean tmpButtonBinary = false;

  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      tmpButtonBinary = ((Button) buttons.get(i)).pressed;
    }
  }
  
  return tmpButtonBinary;
}

// input

public void keyPressed(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order && ((Button) buttons.get(i)).state != "on") ((Button) buttons.get(i)).state = "press";
}

public void keyReleased(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order) ((Button) buttons.get(i)).state = "release";
}

// class

class Button{
  boolean is;

  char order;

  boolean flag;
  boolean pressed;
  String state;

  Button(char order){
    active = true;

    this.order = order;

    flag = false;
    pressed = false;
    state = "off";
  }

  public void draw(){
    //Press
    if(state == "press"){
      if(flag){
        state = "on";
      }
      else{
        flag = true;
        pressed = true;
      }
    }

    //Release
    if(state == "release"){
      if(flag){
        flag = false;
        pressed = false;
      }
      else{
        state = "off";
      }
    }
  }
}
// randomize
public float Variate(float a){
  a = random(a-a/5,a+a/5);
  return a;
}

// critmize
float tmpCritmizeA;
float tmpCritmizeB;

public float Critmize(float a){
  tmpCritmizeA = a;
  tmpCritmizeB = a;
  if(random(100) < 7.5f) Crit();
  return tmpCritmizeA;
}

public void Crit(){
  tmpCritmizeA += tmpCritmizeB;
  if(random(100) < 75) Crit();
}
class Missile{
  boolean is = true;

  String name;
  Vect2 pos, vel, acc;


  Missile(String name, Vect2 pos, Vect2 vel){
    this.pos = new Vect2(pos);
  }

  public void draw(){
    specialAbilities();
    updateBaseValues();
    render();
  }
  
  public void specialAbilities(){
    
  }
  
  public void updateBaseValues(){
    vel.add(acc);
    pos.add(vel);
    acc.set();
  }

  public void checkHitWall(){
    if(x<0 || y<0 || x>width || y>height){
      act = false;
    }
  }

  public void render(){
    //body
    float tmp = 2;
    if(name == "frozen orb") tmp = 6;
    if(name == "chance bomb") tmp = 4;
    if(name == "tree bomb") tmp = 5;
    if(name == "tree bomb Piece") tmp = 3;
    if(name == "shot") tmp = 3;
    if(name == "sixcored bomb") tmp = 8;
    if(name == "hotshooting missile") tmp = 4;
    if(name == "mine") tmp = 7;
    if(name == "breath") tmp = 2;
    noStroke();
    if(owner == 0) fill(255,0,0);
    if(owner == 1) fill(0,255,0);
    if(owner == 2) fill(255);
    Triangle(x,y,dir,tmp);
  }
}
/* textPop
textPop is used for up-popping text's
Fx. damage-values or small info signs

Variables:
   popMode:
     popMode is a String that works as 6 different boolean values.
     Each boolean value is modified by typing 0 = false, and 1 = true.
     If you type anything else that 0 & 1, nothing will happen.
     Each value made true, will add an extra effect to the text:
       1 char = shakePosistion
       2 char = shakeSize
       3 char = sizeIn
       4 char = sizeOut
       5 char = fadeIn
       6 char = fadeOut
     More effects can be added. Make sure to write them in this description.
*/

class TextPop{
  boolean active;

  String t;
  float tSizeX;
  float tSizeY;
  int tLength;
  
  String popMode;
  int col;
  float xStart,yStart,volStart;
  float x,y,vol;
  float transparency;
  float lifeStart;
  float life;

  TextPop(String theText, float x, float y, float volume, int lifeTime, int colour, String popMode){
    active = true;

    t = theText;
    this.x = x;
    this.y = y;
    xStart = x;
    yStart = y;
    volStart = volume;
    lifeStart = PApplet.parseFloat(lifeTime);
    col = colour;
    this.popMode = popMode;

    transparency = 255;
    tLength = theText.length();

    vol = volStart;
    life = lifeStart;
  }

  public void draw(){
    life --;
    if(life > 0){
      update();
      render();
    }
    else{
      active = false;
    }
  }

  public void update(){
    float a = 0.1f; // bace change value
    //shakePosition
    if(popMode.charAt(0) == '1'){
      x = xStart - volStart*(random(-a,a)*1);
      y = yStart - volStart*(random(-a,a)*1);
    }
    //shakeSize
    if(popMode.charAt(1) == '1'){
      vol = volStart*(random(-a,a)+1);
    }
    //popIn
    if(popMode.charAt(2) == '1'){
      if(life > lifeStart/5*4){
        vol = ((1.2f-(life/lifeStart)))*volStart*2.5f;
      }
    }
    //popOut
    if(popMode.charAt(3) == '1'){
      if(life < lifeStart/3){
        vol = (life/lifeStart)*volStart*3;
      }
    }
    //fadeIn
    if(popMode.charAt(4) == '1'){
      if(life > lifeStart/5*4){
        transparency = ((1.2f-(life/lifeStart)))*255*2.5f;
      }
    }
    //fadeOut
    if(popMode.charAt(5) == '1'){
      if(life < lifeStart/3){
        transparency = (life/(lifeStart))*255;
      }
    }
  }
  
  public void fitText(){
    tSizeX = tLength*vol*0.25f*-1;
    tSizeY = vol*0.25f;
  }
  
  public void render(){
    fitText();
    fill(col,transparency);
    textFont(fontA, vol); // font must be added
    text(t, x+tSizeX, y+tSizeY);
  }
}
class Vect2{
  float x, y;
  
  //constructors
  Vect2() {
    x = 0;
    y = 0;
  }
  
  Vect2( Vect2 v) {
    this.x = v.x;
    this.y = v.y;
  }

  Vect2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //sets
  public void set() {
    x = 0;
    y = 0;
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
    this.y = y;
  }
  
  public void set(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void set(Vect2 tmp) {
    x = tmp.x;
    y = tmp.y;
  }
  
  public void setRandom(){
    float tmp = random(PI,-PI);
    x = cos(tmp);
    y = sin(tmp);
  }
  
  public void setRandom(float m){
    float tmp = random(PI,-PI);
    x = cos(tmp)*m;
    y = sin(tmp)*m;
  }
  
  //add
  public void addX(float x) {
    this.x += x;
  }
  
  public void addY(float y) {
    this.y += y;
  }
  
  public void add(float x, float y) {
    this.x += x;
    this.y += y;
  }
  
  public void add(Vect2 tmp) {
    x += tmp.x;
    y += tmp.y;
  }
  
  //subtract
  public void subX(float x) {
    this.x -= x;
  }
  
  public void subY(float y) {
    this.y -= y;
  }
  
  public void sub(float x, float y) {
    this.x -= x;
    this.y -= y;
  }
  
  public void sub(Vect2 tmp) {
    x -= tmp.x;
    y -= tmp.y;
  }
  
  //multiply
  public void multX(float x) {
    this.x *= x;
  }
  
  public void multY(float y) {
    this.y *= y;
  }
  
  public void mult(float a) {
    this.x *= a;
    this.y *= a;
  }
  
  public void mult(float x, float y) {
    this.x *= x;
    this.y *= y;
  }
  
  public void mult(Vect2 tmp) {
    x *= tmp.x;
    y *= tmp.y;
  }
  
  //divide
  public void divX(float x) {
    this.x /= x;
  }
  
  public void divY(float y) {
    this.y /= y;
  }
  
  public void div(float a) {
    this.x /= a;
    this.y /= a;
  }
  
  public void div(float x, float y) {
    this.x /= x;
    this.y /= y;
  }
  
  public void div(Vect2 tmp) {
    x /= tmp.x;
    y /= tmp.y;
  }
  
  //other functions
  public void normalize() {
    float m = magnitude();
    if (m > 0) {
      div(m);
    }
  }
  
  public void negativize(){
    x *= -1;
    y *= -1;
  }
  
  public void variate(Vect2 v){
    float m = 0.1f;
    float tmpD = dist(x,y,v.x,v.y);
    float tmpA = atan2(y-v.y,x-v.x)+random(PI*m,-PI*m);
    x = cos(tmpA)*tmpD;
    y = sin(tmpA)*tmpD;
  }
  
  public void variate(Vect2 v, float m){
    float tmpD = dist(x,y,v.x,v.y);
    float tmpA = atan2(y-v.y,x-v.x)+random(PI*m,-PI*m);
    x = cos(tmpA)*tmpD;
    y = sin(tmpA)*tmpD;
  }
  
  //read functions
  public float magnitude() {
     return (float) Math.sqrt(x*x + y*y);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "tankDuel2_22" });
  }
}
