class Dolly {

  int[] genome;
  int x, y;
  color c;
  int d;
  int l;
  int goalsReached;
  boolean alive;

  Dolly(int x, int y) {
    genome = new int[genomeLength];
    newGenome();
    this.x = x;
    this.y = y;
    c = color(random(255), random(255), random(255));
    restartBasics();
  }

  void update() {
    if (alive) act();
    die();
    draw();
  }
  
  void restartBasics(){
    l=0;
    goalsReached = 0;
    alive = true;
    d=0;
    x=startX;
    y=startY;
  }

  void restart(int[] fatherGenome) {
    restartBasics();
    genome = mutated(fatherGenome);
  }

  int[] mutated(int[] f) {
    int[] r = new int[f.length];
    for (int i=0; i<f.length; i++) {
      r[i] = f[i];
      float a = random(1);
      if (a<probabilityGeneMutation){
        if (f[i]==0) r[i]=1+int(random(2)%2);
        else r[i]=0;
      }
    }
    return r;
  }

  void newGenome() {
    for (int i=0; i<genomeLength; i++) {
      genome[i]=0;
      float probabilityLeft = 0.01;
      float probabilityRight = 0.01;
      float a = random(1);
      if (a<probabilityLeft) genome[i]=1;
      else if (a<probabilityLeft + probabilityRight) genome[i]=2;
    }
  }

  void die() {
    if (l>genomeLength-1) alive = false;
    color g = floorPlan.get(x, y);
    if (red(g)+blue(g)+green(g) < 255*3-colorTolerance) {
      alive = false;
    }
  }
  
  float value(){
    Goal currentGoal = ((Goal) goals.get(goalsReached));
    return 1000000/sqrt(dist2(x,y,currentGoal.x,currentGoal.y));
  }

  void randomizeDirection() {
    d = round(random(8))%8;
  }

  void act() {
    if (genome[l]==0) moveForward();
    if (genome[l]==1) turnLeft();
    if (genome[l]==2) turnRight();
    if (alive) l++;
  }

  void turnLeft() {
    d=(d+7)%8;
  }

  void turnRight() {
    d=(d+1)%8;
  }

  void moveForward() {
    switch(d) {
    case 0:
      x++;
      break;
    case 1:
      x++;
      y--;
      break;
    case 2:
      y--;
      break;
    case 3:
      y--;
      x--;
      break;
    case 4:
      x--;
      break;
    case 5:
      x--;
      y++;
      break;
    case 6:
      y++;
      break;
    case 7:
      y++;
      x++;
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

