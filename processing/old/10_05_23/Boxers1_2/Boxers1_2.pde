Player p1, p2;

float gravity;

void setup(){
  size(500,500);
  smooth();
  
  gravity = 0.01;

  p1 = new Player();
  p2 = new Player();
}

void draw(){
  background(255);
  update();
}

void update(){
  p1.update();
  p2.update();
}

