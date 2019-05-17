

double dt=0.1;
double k=1;
double a,v,x = -10;

double size = 500;
double scale =5;
double thinkingtime = 10;
int gridNum = 11;
double gridScale = size/(gridNum+1);
double pixs = size/scale;
PFont font;

double t = 0.0;

void setup(){
  size((int)size,(int)size);
  smooth();
  font = loadFont("Courier-48.vlw");
}

void draw(){
  double mil = millis();
  background(255);
  stroke(100,100,100,100);
  textFont(font, 10);
  for(int i=1; i<gridNum+1;i++){
    line((float)(i*gridScale), 0.0, (float)(i*gridScale), height);
    line(0.0, (float)(i*gridScale), width, (float)(i*gridScale));
    //text((float)(i*gridScale), -10.0, 
  }
  fill(0);
  text("Time: " + (int)t, width*0.5, height*0.95);
  translate(width*0.5, height*0.5);
  scale((float)scale);
  
  //while(millis()-mil<thinkingtime){
    
    //v+=-k*(x+v-k*x*dt)*dt;
    v+=-k*x*dt;
    x+=v*dt;
    a=0;
    
    t += dt;
  //}
  
  float tmpK = sqrt((float)k);
  double numeric = 5*(double)((cos((float)(tmpK*t)))+sin((float)(tmpK*t)));
  
  noFill();
  stroke(0);
  line(0,0,0,(float)x);
  ellipse(0,(float)numeric,5,5);
  stroke(0,255,0);
  ellipse(0,(float)x,5,5);
}
