//general
double G = 0.0000004981367808; //Gravitational constant : Gm^3*Yg^-1*day^-2
//sun
float dSolar = 1.391; // Diameter : Gm
double mSolar = 1989100000; // Mass : Yg
//mercury
double smaMercury = 57.9091;
double mMercury = 330.22;
double vMercury = 4.135968;
float dMercury = 0.0048794;
//venus
double mVenus = 4868;
double vVenus = 3.025728; // Average orbital velocity : Gm/day
double smaVenus = 108.20893; // Semi Major Axis : Gm
float dVenus = 0.0121036;
//earth
double smaEarth = 149.598261;
double mEarth = 5973.6;
double vEarth = 2.572992;
float dEarth = 0.0127420;
//moon
double smaMoon = 0.384399;
double mMoon = 73.477;
double vMoon = 0.0883008;
float dMoon = 0.0034742;

color colM = color(100,100,100); //color moon
color colS = color(250,150,0);//color sun
color colE = color(0,0,200);//color earth
color colG = color(0);//color GUI
color colB = color(255);//color background
color colT = color(0,100,0);//color text

float cicSiz = 12;
float cicThickness = 2;
float partThickness = 3; // of the particles
float transp = 150; // transparency of particles

Part p1, p2, p3;
double time = 0.0;
int view = 1;
int views = 3;
int dataSize = 4000;
PFont font;
boolean showGUI = true;
boolean pause;
double dt = 0.1;
float scale = 1;

float GmDay_KmSec = 625/54;
float Gm_Km = 1000000;
float Day_Sec = 86400;

void setup(){
  size(500,500);//,OPENGL);
  smooth();
  font = loadFont("Serif-48.vlw");
  textFont(font, 12);
  
  restart();
}

void draw(){
  background(colB);
  if(!pause) particles();
  if(showGUI) GUI();
}

boolean insideRect(float x1, float y1, float x2, float y2, float h){
  return(x1<x2+h*0.5&&x1>x2-h*0.5&&y1<y2+h*0.5&&y1>y2-h*0.5);
}

void particles(){
  setAcc(p1, p2);
  setAcc(p1, p3);
  setAcc(p2, p3);

  p1.update(dt);
  p2.update(dt);
  p3.update(dt);

  time += dt;
  
  drawParticles();
}

void drawParticles(){
  pushMatrix();
  if(view == 0) translate(width*0.5-(float)p2.x*scale,height*0.5-(float)p2.y*scale);
  if(view == 1) translate(width*0.5-(float)p1.x*scale,height*0.5-(float)p1.y*scale);
  if(view == 2) translate(width*0.5-(float)p3.x*scale,height*0.5-(float)p3.y*scale);
  scale(scale);
  p1.render(dSolar, colS);
  p2.render(dEarth, colE);
  p3.render(dMoon, colM);
  popMatrix();
}

void restart(){
  p1 = new Part(0,0,0,0,mSolar);
  p2 = new Part(0,smaEarth,vEarth,0,mEarth);
  p3 = new Part(0,smaEarth+smaMoon,vEarth+vMoon,0,mMoon);
}

void setAcc(Part p1, Part p2){
  double dx = p1.x-p2.x;
  double dy = p1.y-p2.y;
  double dist2 = dx*dx+dy*dy;
  double idist2 = 1/dist2;
  double ang = atan2((float)dy, (float)dx);//180/PI*atan( (float)(dy/dx) );
  double sinu = sin((float)ang);
  double cosi = cos((float)ang);

  p1.ax += -idist2*cosi*p2.m*G;
  p1.ay += -idist2*sinu*p2.m*G;
  p2.ax += idist2*cosi*p1.m*G;
  p2.ay += idist2*sinu*p1.m*G;
}

float logX(float v, float x){
  return log(v)/log(x);
}
