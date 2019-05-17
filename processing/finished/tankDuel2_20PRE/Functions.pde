void Triangle(float x, float y, float dir, float vol){
  triangle(x + cos(dir+(PI*2/3*1))*vol, y + sin(dir+(PI*2/3*1))*vol, x + cos(dir+(PI*2/3*2))*vol, y + sin(dir+(PI*2/3*2))*vol, x + cos(dir+(PI*2/3*3))*vol, y + sin(dir+(PI*2/3*3))*vol);
}

// randomize
float Variate(float a){
  a = random(a-a/5,a+a/5);
  return a;
}

//critmize
float tmpCritmizeA;
float tmpCritmizeB;

float Critmize(float a){
  tmpCritmizeA = a;
  tmpCritmizeB = a;
  if(random(100) < 7.5) Crit();
  return tmpCritmizeA;
}

void Crit(){
  tmpCritmizeA += tmpCritmizeB;
  if(random(100) < 75) Crit();
}

//stars
class Star{

  float x,y,vol,dir;

  Star(float x, float y){
    this.x = x;
    this.y = y;
    vol = Critmize(random(1,3));
    dir = random(PI*2);
  }

  void draw(){
    boolean tmp = false;
    if(random(1000) < 1){
      vol += 2;
      tmp = true;
    }
    x += cos(dir)/25;
    y += sin(dir)/25;
    if(vol < 2) vol =2;
    if(vol < 5){
      noStroke();
      fill(255,255,255,100);
      stroke(255);
      ellipse(x,y,vol*0.5,vol*0.5);
    }
    if(vol > 4 && vol < 8){
      noStroke();
      fill(255,255,255,100);
      stroke(255);
      ellipse(x,y,vol*0.5,vol*0.5);
      line(x,y-vol,x,y+vol);
      line(x-vol,y,x+vol,y);
    }
    if(vol > 7){
      noStroke();
      fill(255,255,255,100);
      ellipse(x,y,vol*0.3,vol*0.3);
      stroke(255);
      line(x,y-vol*1.2,x,y+vol*1.2);
      line(x-vol,y,x+vol,y);
      line(x-vol*0.3,y-vol*0.3,x+vol*0.3,y+vol*0.3);
      line(x+vol*0.3,y-vol*0.3,x-vol*0.3,y+vol*0.3);
    }
    if(tmp) vol -= 2;
  }
}
