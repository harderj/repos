class Dolly {

  int x, y;
  color c;
  int d;

  Dolly(int x, int y) {
    this.x = x;
    this.y = y;
    c = color(random(255), random(255), random(255));
    d = int(random(3));
  }

  Dolly(int x, int y, int startDirection, color paint) {
    this.x = x;
    this.y = y;
    d = startDirection;
    c = paint;
  }

  void update() {
    act();
    die();
    draw();
  }
  
  void die(){
    color g = floorPlan.get(x,y);
    if(red(g)+blue(g)+green(g) > colorTolerance && red(g)+blue(g)+green(g) < 255-colorTolerance){
      x = startX;
      y = startY;
    }
  }

  void act() {
    float probabilityLeft = 0.01;
    float probabilityRight = 0.01;
    float a = random(1);
    if (a<probabilityLeft) turnLeft();
    else if (a<probabilityLeft + probabilityRight) turnRight();
    else moveForward();
  }

  void turnLeft() {
    d=(d+3)%4;
  }

  void turnRight() {
    d=(d+1)%4;
  }

  void moveForward() {
    switch(d) {
    case 0:
      x++;
      break;
    case 1:
      y--;
      break;
    case 2:
      x--;
      break;
    case 3:
      y++;
      break;
    default:
      break;
    }
  }

  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, dollyDrawSize, dollyDrawSize);
  }
}

