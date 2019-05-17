int p;
int num = 100;

float a = 1;
float b = 1;
float c = 0;

void setup(){
  size(300, 200); 
  stroke(255);
}


void draw(){
  background(0);
  p = mouseX/(width/num);
  
  for(int i=0; i<num; i++){
    float x = i;
    line(i*(width/num), height/2, i*(width/num), height*0.5 - pow(a*x,2)+b*x+c);
  }
}
