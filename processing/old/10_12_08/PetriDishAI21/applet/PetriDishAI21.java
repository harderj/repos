import processing.core.*; 
import processing.xml.*; 

import point2line.*; 

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

public class PetriDishAI21 extends PApplet {


float BEING_RADIUS = 10;
float BEING_LEGS_ANGLE = PI*1.50f;
float BEING_SENS_ANGLE = PI*0.30f;
float BEING_SENS_FACTOR = 0.01f;
float BEING_SENS_RADIUS_FACTOR = 0.3f;
float BEING_SPEED = 0.2f;
float BEING_ROTATIONAL_SPEED = 0.01f;
float FOOD_RADIUS = 5;
float DRAG = 0.99f;
int GRID_NUM = 100;
int MEMORYVIZ_DEFINITION = 500;

boolean translating = false;
boolean frameRating = true;
boolean lightmapping = false;
boolean gridding = false;
boolean memoryVizing = true;

Point2 MIDTH;
PFont FONT;

float stableFrameRate;

Being ani; // I call my first being "ani"
Point2 f1; // .. and ani's first meal 'fi'

public void setup(){
  size(500,500);
  smooth();
  //rectMode(CENTER);
  ellipseMode(CENTER);

  MIDTH = new Point2(width*0.5f, height*0.5f);
  FONT = loadFont("Serif-48.vlw");
  
  f1 = randomPoint2Screen();
  ani = new Being(MIDTH);
  ani.b.m = BEING_RADIUS;
  
  startingPrints();
}

public void startingPrints(){
  println("COMMANDS");
  println("'i': prints sensor info");
  println("'g': turns gridding on/off");
  println("'l': turns lightmapping on/off");
  println("'f': turns frameRating on/off");
  println("'m': turns on/off the memory visualisation");
  println("'q': use ani's first leg");
  println("'w': use ani's second leg");
  println("'t': turns translate on/off");
}

public void draw(){
  background(0);
  if(frameRating) displayFrameRate();
  if(gridding || lightmapping) grid();
  if(translating) translate(-ani.b.p.x+width*0.5f, -ani.b.p.y+height*0.5f);
  renderFood();
  ani.update();
  if(memoryVizing) memoryViz();
}

public void memoryViz(){
  fadeScreen();
  
  float memoryScale = (float)ani.memory.size()/(float)MEMORYVIZ_DEFINITION;
  
  
  float xOffset = width*0.1f;
  float yOffset = height*0.2f;
  float xScale = (width-xOffset*2)/MEMORYVIZ_DEFINITION;
  float yScale = height*0.1f;
  
  stroke(255,200);
  strokeWeight(xScale*1.26f);
  rect(xOffset, yOffset-yScale, (width-xOffset*2), yScale);
  
  for(int i=0; i<MEMORYVIZ_DEFINITION; i++){
    int memoryPlace = PApplet.parseInt((float)i*memoryScale);
    Memo m = ((Memo) ani.memory.get(memoryPlace));
    
    stroke(255,0,0,255);
    line(xOffset + PApplet.parseFloat(i)*xScale, yOffset, xOffset + PApplet.parseFloat(i)*xScale, yOffset-m.s1*yScale);
    stroke(0,255,0,255*0.5f);
    line(xOffset + PApplet.parseFloat(i)*xScale, yOffset, xOffset + PApplet.parseFloat(i)*xScale, yOffset-m.s2*yScale);
    strokeWeight(xScale*2);
    stroke(255,0,0);
    if(m.m1) line(xOffset + PApplet.parseFloat(i)*xScale, yOffset, xOffset + PApplet.parseFloat(i)*xScale, yScale);
    stroke(0,255,0);
    if(m.m2) line(xOffset + PApplet.parseFloat(i)*xScale, yOffset, xOffset + PApplet.parseFloat(i)*xScale, yScale);
  }
  
}

public void fadeScreen(){
  noStroke();
  fill(0,175);
  //rect(width*0.5,height*0.5,width,height); // if rectMode == CENTER
  rect(0,0,width,height); // if rectMode == CORNER
}

public void displayFrameRate(){
  float stableness = 2;
  if(abs(stableFrameRate-frameRate) > stableness) stableFrameRate = frameRate;
  fill(0,255,0);
  textFont(FONT, 15);
  text("FrameRate: " + stableFrameRate, width*0.70f, height*0.99f);
}

public void grid(){ // only works with square displays
  float scaling = width/PApplet.parseFloat(GRID_NUM);
  for(int i=0; i<GRID_NUM; i++){
    for(int j=0; j<GRID_NUM; j++){
      float tmpX = PApplet.parseFloat(i)*scaling+scaling*0.5f;
      float tmpY = PApplet.parseFloat(j)*scaling+scaling*0.5f;
      
      if(lightmapping){
        Point2 tmpP;
        if(!translating) tmpP = new Point2(tmpX, tmpY);
        else tmpP = new Point2(tmpX - (-ani.b.p.x+width*0.5f), tmpY - (-ani.b.p.y+height*0.5f));
        fill(0,0,255*calcSens(tmpP),200);
      } else {
        noFill();
      }
      
      if(gridding){
        stroke(255,200);
      } else {
        noStroke();
      }
      
      strokeWeight(0.2f);
      rect(tmpX, tmpY, scaling, scaling);
      strokeWeight(1);
    }
  }
}

public void renderFood(){
  noStroke();
  fill(0,255,0,200);
  ellipse(f1.x, f1.y, FOOD_RADIUS*2, FOOD_RADIUS*2);
}

public void keyPressed(){
  if(key == 'i'){ // prints ani's sensors current data
    println( "One: " + ((Memo) ani.memory.get(ani.memory.size()-1)).s1 );
    println( "Two: " + ((Memo) ani.memory.get(ani.memory.size()-1)).s2 );
  }

  if(key == 'l'){ // turns on/off light mapping
    if(lightmapping) lightmapping = false;
    else lightmapping = true;
  }
  
  if(key == 'g'){ // turns on/off grid
    if(gridding) gridding = false;
    else gridding = true;
  }
  
  if(key == 'f'){ // turns on/off frameRating
    if(frameRating) frameRating = false;
    else frameRating = true;
  }
  
  if(key == 'm'){ // prints ani's memory info
    if(memoryVizing){
      memoryVizing = false;
    }
    else {
      memoryVizing = true;
    }
  }
  
  if(key == 'q'){ // uses ani's first leg
    ani.useLeg(true);
  }
  
  if(key == 'w'){ // uses ani's second leg
    ani.useLeg(false);
  }
  
  if(key == 't'){ // turns on/off frameRating
    if(translating) translating = false;
    else translating = true;
  }
}

class Being{
  
  Phys2 b; // rigid-B-ody
  Point2 s1, s2; // sensor 1 & 2
  Point2 l1, l2; // leg 1 & 2
  ArrayList memory;
  
  boolean rendering;
  
  // vars for primitive AI
  
  int primitiveStep = 0;
  
  Being(Point2 pos){
    memory = new ArrayList();
    b = new Phys2(pos);
    s1 = new Point2();
    s2 = new Point2();
    l1 = new Point2();
    l2 = new Point2();
    rendering = true;
  }
  
  public void update(){
    remember();
    AI();
    baseVars();
    if(rendering) render();
  }
  
  public void useLeg(boolean which){
    float ang;
    if(which) ang = 0.5f*BEING_LEGS_ANGLE;
    else ang = -0.5f*BEING_LEGS_ANGLE;
    
    b.a.x += cos(PI-ang + b.r)*BEING_SPEED;
    b.a.y += sin(PI-ang + b.r)*BEING_SPEED;
    
    if(which) b.rv += BEING_ROTATIONAL_SPEED;
    else b.rv -= BEING_ROTATIONAL_SPEED;
    
    if(which) ((Memo) memory.get(memory.size()-1)).m1 = true;
    if(!which) ((Memo) memory.get(memory.size()-1)).m2 = true;
  }
  
  public void baseVars(){
    // physic update (pos, vel, acc)
    b.update();
    
    // sensors
    s1.x = b.p.x+cos(b.r+0.5f*BEING_SENS_ANGLE)*b.m;
    s1.y = b.p.y+sin(b.r+0.5f*BEING_SENS_ANGLE)*b.m;
    s2.x = b.p.x+cos(b.r-0.5f*BEING_SENS_ANGLE)*b.m;
    s2.y = b.p.y+sin(b.r-0.5f*BEING_SENS_ANGLE)*b.m;
    
    //legs
    l1.x = b.p.x+cos(b.r+0.5f*BEING_LEGS_ANGLE)*b.m;
    l1.y = b.p.y+sin(b.r+0.5f*BEING_LEGS_ANGLE)*b.m;
    l2.x = b.p.x+cos(b.r-0.5f*BEING_LEGS_ANGLE)*b.m;
    l2.y = b.p.y+sin(b.r-0.5f*BEING_LEGS_ANGLE)*b.m;
  }
  
  public void remember(){ // doen't work with multiple foods yet
    float sens1 = calcSens(s1);
    float sens2 = calcSens(s2);
    memory.add( new Memo(sens1, sens2) );
  }
  
  public void render(){
    //body
    noStroke();
    fill(255,200);
    ellipse(b.p.x, b.p.y, b.m*2, b.m*2);
    
    //sensors
    fill(0,200);
    strokeWeight(2);
    stroke(0,150,255,200);
    ellipse(s1.x, s1.y, b.m*2*BEING_SENS_RADIUS_FACTOR, b.m*2*BEING_SENS_RADIUS_FACTOR);
    ellipse(s2.x, s2.y, b.m*2*BEING_SENS_RADIUS_FACTOR, b.m*2*BEING_SENS_RADIUS_FACTOR);
    
    //legs
    Point2 tmpL1 = l1.copy();
    Point2 tmpL2 = l2.copy();
    tmpL1.x += cos(b.r+0.5f*BEING_LEGS_ANGLE);
    tmpL1.y += sin(b.r+0.5f*BEING_LEGS_ANGLE);
    tmpL2.x += cos(b.r-0.5f*BEING_LEGS_ANGLE);
    tmpL2.y += sin(b.r-0.5f*BEING_LEGS_ANGLE);
    noFill();
    strokeWeight(4);
    stroke(255,200);
    line(l1.x, l1.y, tmpL1.x, tmpL1.y);
    line(l2.x, l2.y, tmpL2.x, tmpL2.y);
  }
  
  public void AI(){
    primitive(); // first made AI-method, which is not really AI, but rather the thing the AI ultimately should be doing
  }
  
  public void primitive(){
    float sens1 = ((Memo) memory.get(memory.size()-1)).s1;
    float sens2 = ((Memo) memory.get(memory.size()-1)).s2;
    
    if(primitiveStep == 0){
      if( sens1 < sens2) useLeg(false);
      else useLeg(true);
      primitiveStep ++;
    }
    
    if(primitiveStep == 1){
      if(random(1)<0.05f) primitiveStep = 0;
    }
    
  }
}

class Memo{
  float s1, s2;
  boolean m1, m2, f;
  
  Memo(float sens1, float sens2){
    s1 = sens1;
    s2 = sens2;
    m1 = false;
    m2 = false;
    f = false;
  }
}

public float calcSens(Point2 poi){
  Point2 delta = poi.copy();
  delta.subtract(f1);
  delta.scale(BEING_SENS_FACTOR);
  
  return 1/((delta.x*delta.x + delta.y*delta.y)+1);
}



class Poly2{

  // BASE VARIABLES

  Point2[] p;

  // CONSTRUCTORS

  Poly2(int length){
    p = new Point2[length];
  }

  Poly2(Point2[] points){
    p = points;
  }

  // SETTING WITH INPUT

  public void transpose(Point2 v){
    for(int i=0; i<p.length; i++) p[i].add(v);
  }

  public void scale(float a){
    for(int i=0; i<p.length; i++) p[i].scale(a);
  }

  public void divide(float a){
    for(int i=0; i<p.length; i++) p[i].divide(a);
  }

  public void rotateAroundAveragePosition(float a){ // not tested
    for(int i=0; i<p.length; i++) p[i].setRotationAround(averagePosition(), a);
  }

  // SETTING WITHOUT INPUT

  public void setRandomScreen(){
    for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
  }
  
  public void setRandomScreenNatural(){ 
    // Scrambles all points in the polygon while making sure that all points are inside the screen, and that the polygon is not "self intersecting" (see function "selfIntersecting")
    // NOTE - can become really heavy or even crash if the number of points is high (roughly above 25)
    for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
    while(selfIntersecting()) for(int i=0; i<p.length; i++) p[i] = randomPoint2Screen();
  }

  // RETURNING WITH INPUT

  public boolean containPoint(Point2 v){
    int t = 0; 
    float[] a = new float[p.length];
    float[] b = new float[p.length];
    for(int i=0; i<p.length; i++){
      Line2 tLine = new Line2(p[i], p[(i+1)%p.length]);
      a[i] = tLine.tilt();
      b[i] = tLine.offset();

      float intersectX = -((b[i]-v.y)/a[i]);

      if(v.x > intersectX && insideInterval(v.y, p[i].y , p[(i+1)%p.length].y)) t++;
    }

    if(t%2 == 0) return false; // if the polygon's lines has intersected the x-line an even count before reaching mouseX, false is returned, else true
    else return true;
  }

  // RETURNING WITHOUT INPUT

  public boolean selfIntersecting(){
    // Returns true, if two or more of the abstract/drawable lines between the polygon's point are intersecting
    // Returns (for mathimatical reasons) always false, if the number of points in the polygon are below 4 
    // NOTE - does always not work if two or more vertices has the exactly same positions slash Point2-values
    Line2[] l = new Line2[p.length];
    for(int i=0; i<p.length; i++){
      l[i] = new Line2(p[i], p[(i+1)%p.length]);
    }

    if(intersectingMultipleLines(l)) return true;
    else return false;
  }

  public Point2 averagePosition(){
    Point2 a = new Point2();
    for(int i=0; i<p.length; i++) a.add(p[i]);
    a.divide(p.length);
    return a;
  }

  // NEITHER RETURNING NOR SETTING

  public void render(){
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape();
  }

  public void renderFill(){
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }

  public void renderAuto(){
    float factor = 0.01f;
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    fill(0,255*0.5f);
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }

  public void renderAuto(float factor){
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    fill(0,255*0.5f);
    beginShape();
    for(int i=0; i<p.length; i++) vertex(p[i].x, p[i].y);
    endShape(CLOSE);
  }
}



class Point2 extends Vect2{

  // BASE VARIABLES

  // CONSTRUCTORS

  Point2(){
    this.x = 0;
    this.y = 0;
  }

  Point2(float x, float y){
    this.x = x;
    this.y = y;
  }

  // SETTING WITH INPUT

  public void rotateAround(Point2 around, float angle){
    subtract(around);
    float tmpMagnitude = magnitude();
    float tmpAngle = atan2(y, x);
    set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude);
  }

  public void setRotationAround(Point2 around, float angle){
    subtract(around);
    float tmpMagnitude = magnitude();
    set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude);
  }

  public void reflect(Point2 reflector){
    float a = atan2(y, x);
    float b = atan2(reflector.y, reflector.x);
    float c = 2*b-a;

    setRotation(c);
  }

  // SETTING WITHOUT INPUT

  public void setRandomScreen(){
    x = random(width);
    y = random(height);
  }

  // RETURNING WITH INPUT

  public boolean equals(Point2 p){
    if(x == p.x && y == p.y) return true;
    else return false;
  }

  public boolean insideCircle(Point2 v, float r){
    Point2 d = new Point2();
    d.x = x-v.x;
    d.y = y-v.y;
    if(d.x*d.x+d.y*d.y < r*r) return true;
    else return false;
  }

  public boolean insideRect(Point2 min, Point2 max){
    if(x >= min(min.x, max.x) && x <= max(min.x, max.x) && y >= min(min.y, max.y) && y <= max(min.y, max.y)) return true;
    else return false;
  }

  public boolean insidePolygon(Point2[] p){
    int t = 0; 
    float[] a = new float[p.length];
    float[] b = new float[p.length];
    for(int i=0; i<p.length; i++){
      Line2 tLine = new Line2(p[i], p[(i+1)%p.length]);
      a[i] = tLine.tilt();
      b[i] = tLine.offset();

      float intersectX = -((b[i]-y)/a[i]);

      if(x > intersectX && insideInterval(y, p[i].y , p[(i+1)%p.length].y)) t++;
    }

    if(t%2 == 0) return false; // if the polygon's lines has intersected the x-line an even count before reaching mouseX, false is returned, else true
    else return true;
  }
  
  public float angleBetween(Point2 p){
    return atan2(p.y-y,p.x-x);
  }

  public Point2 reflected(Point2 reflector){
    Point2 result = this.copy();

    float a = atan2(y, x);
    float b = atan2(reflector.y, reflector.x);
    float c = 2*b-a;

    result.setRotation(c);

    return result;
  }

  // RETURNING WITHOUT INPUT

  public Point2 copy(){
    return new Point2(x, y);
  }

  public boolean insideScreen(){
    if(x >= 0 && x <= width && y >= 0 && y <= height) return true;
    else return false;
  }

  // NEITHER SETTING NOR RETURNING

  public void render(){
    point(x, y);
  }

  public void renderAuto(){
    float factor = 0.05f;
    strokeWeight((width+height)*0.5f*factor);
    stroke(255,100);
    point(x, y);
    strokeWeight((width+height)*0.5f*factor*0.5f);
    stroke(0,100);
    point(x, y);
  }

  public void renderAuto(float factor){
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    point(x, y);
    strokeWeight((width+height)*0.5f*factor*0.5f);
    stroke(0);
    point(x, y);
  }
}



class Phys2{

  Point2 p, v, a;
  float m, r;
  float rv; // new

  Phys2(){
    p = new Point2();
    v = new Point2();
    a = new Point2();
    m = 1;
    r = 0;
    rv = 0;
  }
  
  Phys2(Point2 pos){
    p = pos.copy();
    v = new Point2();
    a = new Point2();
    m = 1;
    r = 0;
    rv = 0; // new
  }

  public void update(){
    r += rv; // new
    rv *= DRAG; // new
    v.add(a);
    a.setZero();
    v.scale(DRAG);
    p.add(v);
  }
  
  // change
  
  public void addAcc(float x, float y){
    a.x += x/m;
    a.y += y/m;
  }
  
  public void addAcc(Point2 acc){
    a.x += acc.x/m;
    a.y += acc.y/m;
  }
  
  public void addAccInDirection(float acc, float direction){
    float tAcc = acc/m;
    
    a.x += cos(direction)*tAcc;
    a.y += sin(direction)*tAcc;
  }

}


class Line2{
  
  // BASE VARIABLES
  
  Point2 p1, p2;

  // CONSTRUCTORS

  Line2(Point2 p1, Point2 p2){
    this.p1 = p1;
    this.p2 = p2;
  }
  
  // SETTING WITH INPUT

  public void set(Point2 p1, Point2 p2){
    this.p1 = p1;
    this.p2 = p2;
  }

  public void add(Point2 v){
    p1.add(v);
    p2.add(v);
  }

  public void sub(Point2 v){
    p1.subtract(v);
    p2.subtract(v);
  }
  
  // SETTING WITHOUT INPUT
  
  // RETURNING WITH INPUT
  
  public boolean sharesPointWithLine(Line2 l){
    // Returns true, if the one or two end-points of the two lines (it self and the input) has the exact same positions
    if(p1.equals(l.p1) || p1.equals(l.p2) || p2.equals(l.p1) || p2.equals(l.p2)) return true;
    else return false;
  }
  
  public boolean equals(Line2 l){
    if(p1.equals(l.p1) && p2.equals(l.p2)) return true;
    else return false;
  }
  
  public boolean intersectingLine(Line2 l){
    Point2 inter = intersectionLine(l);

    if(inter.insideRect(p1, p2) && inter.insideRect(l.p1, l.p2)) return true;
    else return false;
  }
  
  public Point2 intersectionLine(Line2 l){
    Point2 result = new Point2();

    float a1 = tilt();
    float b1 = offset();
    float a2 = l.tilt();
    float b2 = l.offset();

    result.x = -1*((b1-b2)/(a1-a2));
    result.y = a1*result.x+b1;

    return result;
  }
  
  // RETURNING WITHOUT INPUT
  
  public float tilt(){
    return (p1.y-p2.y)/(p1.x-p2.x);
  }

  public float offset(){
    return p1.y-(p1.x*tilt());
  }
  
  public float length(){
    return sqrt(sq(p1.x-p2.x)+sq(p1.y-p2.y));
  }
  
  public float squareLength(){
    // Far more fast than the similar function "length()", because it doesn't have to calculate a square root
    return (sq(p1.x-p2.x)+sq(p1.y-p2.y));
  }
  
  // NEITHER SETTING NOR RETURNING
  
  public void render(){
    line(p1.x, p1.y, p2.x, p2.y);
  }

  public void renderAuto(){
    float factor = 0.01f;
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    line(p1.x, p1.y, p2.x, p2.y);
    strokeWeight((width+height)*0.5f*factor*0.5f);
    stroke(0);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  public void renderAuto(float factor){
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    line(p1.x, p1.y, p2.x, p2.y);
    strokeWeight((width+height)*0.5f*factor*0.5f);
    stroke(0);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  public void renderGraph(){
    line(0,offset(),width,tilt()*width+offset());
  }
}


public boolean searchString(String searchFor, String searchIn){
  // Searches for a specific string, inside another string
  // Returns 'true' if found, 'false' if not
  // If the string searched in is shorter than the one searched for, 'false' will return
  boolean hit = false;
  if(searchFor.length()<searchIn.length()){
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++){
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)){
        hit = true;
      }
    }
  }
  return hit;
}

public float inbound(float value, float minimum, float maximum){
  // Keeps a value between a minimum and a maximum by recounting
  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

public boolean insideInterval(float a, float b, float c){
  if(a >= min(b,c) && a <= max(b,c)) return true;
  else return false;
}

public int negative(int c){
  return color(255-red(c), 255-green(c), 255-blue(c));
}

public Point2 randomPoint2Screen(){
  return new Point2(random(width), random(height));
}

public boolean intersectingMultipleLines(Line2[] l){
  // If any line in the list is intersecting : returns true
  // NOTE - see the function "selfIntersecting()" in the class "Poly2"
  boolean result = false;
  for(int i=0; i<l.length; i++){
    for(int j=0; j<l.length; j++){
      if(!l[i].equals(l[j]) && !l[i].sharesPointWithLine(l[j]) && l[i].intersectingLine(l[j])){
        result = true;
        break;
      }
    }
  }
  return result;
}

class Force2{

  Phys2[] l;
  float[] p;
  String k;

  Force2(String kind, float[] parameters, Phys2 a, Phys2 b){
    k = kind;
    p = parameters;
    l = new Phys2[2];
    l[0] = a;
    l[1] = b;
  }
  
  Force2(String kind, float[] parameters, Phys2 a, Phys2 b, Phys2 c){
    k = kind;
    p = parameters;
    l = new Phys2[3];
    l[0] = a;
    l[1] = b;
    l[2] = c;
  }

  public void update(){
    if(k == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  public void attraction(){
    
    for(int i=0; i<l.length; i++){
      for(int j=0; j<l.length; j++){
        if(i != j) l[i].addAccInDirection(p[0], l[i].p.angleBetween(l[j].p));
      }
    }
  }
}


class Circle2{
  
  // BASE VARIABLES
  
  Point2 p;
  float r;
  
  // CONSTRUCTORS
  
  Circle2(Point2 position, float radius){
    p = position;
    r = radius;
  }
  
  // SETTING WITH INPUT
  
  // SETTING WITHOUT INPUT
  
  // RETURNING WITH INPUT
  
  public boolean intersectingCircle(Circle2 c){
    if(p.subtracted(c.p).squareMagnitude() < sq(r+c.r)) return true;
    else return false;
  }
  
  public boolean containPoint(Point2 p){
    if(this.p.subtracted(p).squareMagnitude() < sq(r)) return true;
    else return false;
  }
  
  // RETURNING WITHOUT INPUT
  
  // NEITHER RETURNING NOR SETTING
  
  public void render(){
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  public void renderAuto(){
    float factor = 0.01f;
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
  
  public void renderAuto(float factor){
    strokeWeight((width+height)*0.5f*factor);
    stroke(255);
    fill(0);
    ellipse(p.x, p.y, r*2, r*2);
  }
}
/*
  Petri-dish-AI
  By Jacob Harder, begun 22nd of May 2010
  
  The ultimate purpose of this sketch is
  to make an AI-system that, to a being,
  provides the ability to connect the input
  it receives with the output it generates.
  That to such an extend that it can foresee
  the consequences of its actions completely,
  no matter what laws the world it is placed
  in is.
  
  The first instance of such a world and such
  a being, is the simplest i could make up:
  The being is a circle with two lightsensors
  and two legs. The world is much like a rect-
  angular petri dish in a dark room with some
  shining pieces of food. The idea is that the
  being is to learn that light means food.
  Ultimately it should be able to learn to
  calculate the exact position of the food,
  and what move-combinations is best way of
  getting to the food.
*/

/*

  TODO
    food-eating
    memory visualisation
    fix the beings eyes so that they do not see light when the body is inbetween them and the light source
    do the AI
      "wander around"-method
      much, much more..
  
  DONE
    basic setup // 1.6
      the class being // 1.6
        memory // 1.7
        methods // 1.7
    display methods // 1.8
      grid // 1.9
      lightmap * translate fix // 1.9
      translate // 1.9
    basic move methods for ani // 1.9
    make a model for what the AI ultimately should be doing // 2.0
      finish of the method under being-class called "primitive()" // 2.0
    
  ISSUES
    the idea of storing memory as an arrayList is probably not optimal
    it is not currently sure what leg is left, and whats right and what they are called in the memory
*/

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ffffff", "PetriDishAI21" });
  }
}
