
double G = 0.0000004981367808; //Gravitational constant : Gm^3*Yg^-1*day^-2
double mSolar = 1989100000; // Mass : Yg
double mMercury = 330.22;
double mVenus = 4868;
double smaVenus = 108.20893; // Semi Major Axis : Gm
double smaMercury = 57.9091;
double vVenus = 3.025728; // Average orbital velocity : Gm/day
double vMercury = 4.135968;

Part p1, p2, p3;

float scale = 2;

void setup(){

  size(500,500);
  smooth();

  p1 = new Part(0,0,0,0,mSolar);
  p2 = new Part(0,smaMercury,vMercury,0,mMercury);
  p3 = new Part(0,smaVenus,vVenus,0,mVenus);
}


void draw(){
  background(0);
  translate(width*0.5,height*0.5);
  scale(scale);
  /*
  fill(0,0,0,2);
   rect(-10,-10,width+20,height+20);
   */

  double dt = 0.1;
  
  //for(int i=0;i<(int)(1/dt);i++){

    setAcc(p1, p2);
    setAcc(p1, p3);
    setAcc(p2, p3);

    p1.update(dt);
    p2.update(dt);
    p3.update(dt);

    fill(255,255,150);
    p1.render();
    fill(100,100,200);
    p2.render();
    fill(150,150,0);
    p3.render();
 // }

}

void setAcc(Part p1, Part p2){
  double dx = p1.x-p2.x;
  double dy = p1.y-p2.y;
  double dist2 = dx*dx+dy*dy;
  double idist2 = 1/dist2;
  double ang = atan2((float)dy, (float)dx);//180/PI*atan( (float)(dy/dx) );
  double sinu = sin((float)ang);
  double cosi = cos((float)ang);

  p1.ax += -idist2*cosi*p1.im*p2.m*G;
  p1.ay += -idist2*sinu*p1.im*p2.m*G;
  p2.ax += idist2*cosi*p2.im*p1.m*G;
  p2.ay += idist2*sinu*p2.im*p1.m*G;
}

void keyPressed(){
  if(key=='a') scale *= 1.1;
  if(key=='s') scale /= 1.1;
}

