Player p1, p2;

float gravity, drag;

void setup(){
  size(500,500);
  smooth();

  gravity = 0.01;
  drag = 0.999;

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


