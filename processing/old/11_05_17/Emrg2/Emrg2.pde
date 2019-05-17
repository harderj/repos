float ballR = 15;
float speedUp = 2.7;
float speedDown = -3.5;
float maxVel = 20;
ArrayList balls=new ArrayList();

void setup() {
  size(800,400);
  int n=30;
  for(int i=0;i<n;i++) {
    balls.add(new Ball(i));
  }
}

void draw() {
  background(255);
  updateArrayLists();
}

void updateArrayLists() {
  for(int i=0;i<balls.size();i++) {
    ((Ball) balls.get(i)).updatePosVel();
    ((Ball) balls.get(i)).checkBalls();
    ((Ball) balls.get(i)).render();
  }
}

