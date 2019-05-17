
float s=500;
int n=3;
float qn = sqrt(float(n));

void setup(){
  size(int(s),int(s));
  smooth();
}

void draw(){
  background(255);
  drawPoints();
  drawLines();
}

void drawLines(){
  n-(1+i);
}  

void drawPoints(){
  float fac=0.1;
  noStroke();
  fill(0);
  for(int i=0; i<n; i++){
    float a = float(i)/float(n)*TWO_PI;
    float l = s/3;
    float tx = cos(a)*l;
    float ty = sin(a)*l;
    ellipse(s/2+tx,s/2+ty,s/qn*fac,s/qn*fac);
  }
}

void keyPressed(){
  if(key=='a') n++;
  if(key=='s') n--;
  qn = sqrt(float(n));
}
