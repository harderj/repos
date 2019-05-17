ArrayList balls, textPops;
Vect2 gravity;
float airFriction;
float ballFriction;
float[] frameFriction = new float[4];
PFont font;

void setup(){
  size(500, 500);
  smooth();
  noStroke();
  font = loadFont("Arial-Black-48.vlw");

  balls = new ArrayList();
  textPops = new ArrayList();
  
  gravity = new Vect2(.0, .3);
  airFriction = 1;
  ballFriction = 1;
  frameFriction[0] = 1;
  frameFriction[1] = 1;
  frameFriction[2] = 1;
  frameFriction[3] = 1;
  
  balls.add(new Ball(new Vect2(width/4,height/4), new Vect2(2,1), 30));
  balls.add(new Ball(new Vect2(width/2,height/3), new Vect2(), 20));
}

void draw(){
  fill(255,20);
  rect(-10,-10,width*2,height*2);
  //background(51);
  updateArrayLists();
  //checkObjectCollision(balls, vels);
}

void updateArrayLists(){
  for(int i=0; i<balls.size(); i++) if(((Ball) balls.get(i)).use) ((Ball) balls.get(i)).run(i);
  else balls.remove(i);
  
  for(int i=0; i<textPops.size(); i++) if(((TextPop) textPops.get(i)).use) ((TextPop) textPops.get(i)).run();
  else textPops.remove(i);
}

void mousePressed(){
  if(mouseButton == RIGHT){
    Vect2 tmpV = new Vect2(mouseX-pmouseX, mouseY-pmouseY);
    Vect2 tmpP = new Vect2(mouseX, mouseY);
    balls.add(new Ball(tmpP, tmpV, random(5,60)));
  }
  else{
    for(int i=0; i<balls.size(); i++){
      Vect2 tmpV = new Vect2(((Ball) balls.get(i)).pos);
      float tmpR = ((Ball) balls.get(i)).r;
      float tmpD = dist(mouseX,mouseY,tmpV.x,tmpV.y);
      if(tmpD < tmpR) balls.remove(i);
    }
    textPops.add(new TextPop("POW!", mouseX, mouseY, 20, 30, color(255), "111111"));
  }
}

void keyPressed(){
  if(key=='p') saveFrame();
}
