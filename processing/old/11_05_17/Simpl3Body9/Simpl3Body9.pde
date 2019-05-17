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
int views = 3;
int dataSize = 10000;
PFont font;
boolean showGUI = true;
boolean pause;
double dt = 0.1;
float scale = 1;

float GmDay_KmSec = 625/54;
float Gm_Km = 1000000;
float Day_Sec = 86400;

void setup(){
  size(600,600);//,OPENGL);
  smooth();
  font = loadFont("Serif-48.vlw");
  textFont(font, 12);
  
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
  float offY = height*0.92;
  float offX = width*0.03;
  float offP = height*0.04;
  
  noStroke();
  fill(255,255,100);
  ellipse(offX, offY - offP*0, 10,10);
  fill(0,100,255);
  ellipse(offX, offY - offP*1, 10,10);
  fill(200,200,200);
  ellipse(offX, offY - offP*2, 10,10);
  
  strokeWeight(2);
  stroke(255);
  noFill();
  if(view == 1) ellipse(offX, offY - offP*0, 15,15);
  if(view == 0) ellipse(offX, offY - offP*1, 15,15);
  if(view == 2) ellipse(offX, offY - offP*2, 15,15);
  
  if(insideRect(mouseX, mouseY, offX, offY-offP*0,10)){
    showPlanetInfo(1);
    if(mousePressed) view = 1;
  }
  if(insideRect(mouseX, mouseY, offX, offY-offP*1,10)){
    showPlanetInfo(2);
    if(mousePressed) view = 0;
  }
  if(insideRect(mouseX, mouseY, offX, offY-offP*2,10)){
    showPlanetInfo(3);
    if(mousePressed) view = 2;
  }
}

void showPlanetInfo(int v){
  float offY = height*0.92;
  float offX = width*0.06;
  float offP = height*0.04;
  
  Part p = new Part();
  if(v==1) p=p1;
  if(v==2) p=p2;
  if(v==3) p=p3;
  
  float vel = dist(0,0,(float)p.vx,(float)p.vy)*GmDay_KmSec;
  float dist0 = dist(0,0,(float)p.x,(float)p.y);
  
  fill(0,255,0);
  stroke(0,255,0);
  if(v==1) text("'Sun'",offX,offY-offP*0);
  if(v==2) text("'Earth'",offX,offY-offP*0);;
  if(v==3) text("'Moon'",offX,offY-offP*0);;
  text("Velocity: " + vel + " km/s",offX,offY-offP*1);
  text("Position: " + dist0 + " Gm",offX,offY-offP*2);
  
}

void showSlides(){
  showScaleSlider();
  showTimeSlider();
}

boolean timeSliderGrab = false;

void showTimeSlider(){
  float factor = 0.02; // scale slider factor
  float offS=width*0.1;
  float offX = width*0.02;
  float offY = height*0.05;
  float offXText = width*0.04;
  float ballSize = width*0.02;
  
  float tmpX = -log((float)dt)/factor+offX+offS; //1/(pow((dt*pow(factor,4)),0.25)+offX;
  if(mousePressed){
    if(insideRect(mouseX, mouseY, tmpX, height-offY,ballSize)) timeSliderGrab = true;
  }
  else timeSliderGrab=false;
  if(timeSliderGrab){
    dt = exp(-factor*(mouseX-offX-offS)); // exp((mouseX-offX)*factor);
  }
  
  float tmpW = abs(tmpX-offX);
  fill(0,255,0);
  text("dt: " + (float)dt*24 + " hours", tmpW + offXText, height-offY+5);
  
  noFill();
  stroke(125);
  strokeWeight(3);
  line(offX, height-offY, tmpX, height-offY);
  stroke(255);
  ellipse(tmpX,height-offY,ballSize*.5,ballSize*.5);
}

boolean scaleSliderGrab = false; // scale slider 'grabbed'

void showScaleSlider(){
  float factor = 0.05; // scale slider factor
  float offS=width*0.4;
  float offX = width*0.02;
  float offY = height*0.02;
  float offXText = width*0.04;
  float ballSize = width*0.02;
  
  float tmpX = (factor*offX+log(scale))/factor+offS;
  if(mousePressed){
    if(insideRect(mouseX, mouseY, tmpX, height-offY,ballSize)) scaleSliderGrab = true;
  }
  else scaleSliderGrab=false;
  if(scaleSliderGrab){
    scale = exp(factor*(mouseX-offX-offS)); // exp((mouseX-offX)*factor);
  }
  
  float tmpW = abs(tmpX-offX);
  float tmpV = tmpW*1000000/scale;
  fill(0,255,0);
  text(tmpV + " m", tmpW + offXText, height-offY+5);
  
  noFill();
  stroke(125);
  strokeWeight(3);
  line(offX, height-offY, tmpX, height-offY);
  stroke(255);
  ellipse(tmpX,height-offY,ballSize*.5,ballSize*.5);
}

boolean insideRect(float x1, float y1, float x2, float y2, float h){
  return(x1<x2+h*0.5&&x1>x2-h*0.5&&y1<y2+h*0.5&&y1>y2-h*0.5);
}

void showInfo(){
  fill(0,255,0);
  text("Days: " + (int)time, width*0.02, height*0.04);
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
