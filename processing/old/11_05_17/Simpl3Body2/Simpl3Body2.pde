
Part p1, p2, p3;

float f1 = 0.0000001;
float f2 = 0.0001;

void setup(){

  size(500,500);
  smooth();

  float tmpA = random(TWO_PI);
  p1 = new Part(new PVector(250,250), -24/100, 0, 100);
  p2 = new Part(new PVector(250,200), 1, 0, 20);
  p3 = new Part(new PVector(250,400), 1, 0, 4);
  /*
  p1 = new Part(new PVector(random(width), random(height)));
  p2 = new Part(new PVector(random(width), random(height)));
  p3 = new Part(new PVector(random(width), random(height)));
  */
  
  String hey = "haha";
  println(simplify(hey));
  
}


void draw(){
  fill(0,0,0,2);
  rect(-10,-10,width+20,height+20);

  setAcc(p1, p2);
  setAcc(p1, p3);
  setAcc(p2, p3);

  p1.draw();
  p2.draw();
  p3.draw();

  //fill(noise(millis()*0.0001)*255);
  fill(255);
  p1.render();
  p2.render();
  p3.render();

}

void setAcc(Part p1, Part p2){
  float dx = p1.p.x-p2.p.x;
  float dy = p1.p.y-p2.p.y;
  float dist2 = sq(dx*f2)+sq(dy*f2);
  float idist2 = 1/dist2*f1;
  float ang = atan2(p2.p.y-p1.p.y, p2.p.x-p1.p.x);

  p1.a.add(idist2 * cos(ang) * p1.im * p2.m, idist2 * sin(ang) * p1.im * p2.m, 0);
  p2.a.add(-idist2 * cos(ang) * p2.im * p1.m, -idist2 * sin(ang) * p2.im * p1.m, 0);
}


