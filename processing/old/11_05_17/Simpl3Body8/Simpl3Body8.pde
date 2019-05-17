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

Part p1, p2, p3;
double time = 0.0;
int view = 1;
int views = 4;
int dataSize = 10000;
PFont font;
boolean showGUI;
boolean pause;
double dt = 0.1;

float scale = 1;

void setup(){
  size(600,600);//,OPENGL);
  smooth();
  font = loadFont("Serif-48.vlw");
  textFont(font, 14);
  
  restart();
}

void draw(){
  background(0);
  if(!pause) particles();
  if(showGUI) GUI();
}

void GUI(){
  showPlanets();
  showSlides();
  showInfo();
}

void showPlanets(){
  
}

void showSlides(){
  showScaleSlider();
  showTimeSlider();
}

void showTimeSlider(){
  
}

float SSF = 20; // scale slider factor
boolean SSG = false; // scale slider 'grabbed'
float offset=0.5;

void showScaleSlider(){
  if(SSG) println(random(1));
  noFill();
  stroke(255);
  strokeWeight(3);
  float tmpX = (width*(SSF*offset+log(scale)))/SSF;
  line(width*0.1, height*0.99, tmpX,height*.99);
  ellipse(tmpX,height*.99,5,5);
  if(mousePressed){
    if(insideRect(mouseX, mouseY, tmpX, height*.99,width*0.01)) SSG = true;
  }
  else SSG=false;
  if(SSG) scale = exp(((mouseX-width*offset)/width)*SSF);
  
  float tmpW = ((width*(SSF*offset+log(scale)))/SSF-width*0.1);
  float tmpV = tmpW*1000000/scale;
  int tmpF = (int)(logX(tmpV,10));
  String tmpS = str(tmpV);
  tmpS = tmpS.charAt(0) + "." + tmpS.charAt(1) + tmpS.charAt(2) + tmpS.charAt(3);
  text(tmpV + "·10^" + tmpF + "m", (width*(SSF*offset+log(scale)))/SSF +width*0.01, height*0.995);
}

boolean insideRect(float x1, float y1, float x2, float y2, float h){
  return(x1<x2+h*0.5&&x1>x2-h*0.5&&y1<y2+h*0.5&&y1>y2-h*0.5);
}

void showInfo(){
  fill(0,255,0);
  text("Days: " + (int)time, width*0.01, height*0.99);
  stroke(255);
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
  if(view == 3) translate(width*0.5,height*0.5);
  scale(scale);
  p1.render(dSolar, color(255,255,0), 0);
  p2.render(dEarth, color(0,200,255), 1);
  p3.render(dMoon, color(200,200,200), 2);
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

void keyPressed(){
  if(key=='g') showGUI = !showGUI;
}

float logX(float v, float x){
  return log(v)/log(x);
}
