float x = 0;
float t = 0;
float a = PI/8;

float time = 0;
float record = 0;

void setup(){
  size(400,200);
  smooth();
}

void draw(){
  time ++;
  if(x > width/4 || x < -width/4){
    reset();
  }
  if(record < time){
    record = time;
  }
  if(keyPressed){
    if(key == 'a'){
      x--;
    }
    if(key == 's'){
      x++;
    }
  }
  
  x += a*0.5;

  t += x*0.00001;

  a += t*0.6;

  background(0);
  stroke(255);
  noFill();
  line(width/2+cos(a)*width/4, height/2+sin(a)*width/4, width/2+cos(a)*-width/4, height/2+sin(a)*-width/4);

  ellipse(width/2+cos(a)*x, height/2+sin(a)*x, 10,10);
}

void reset(){
  x = 1;
  t = 0;
  a = 0;
  time = 0;
}

