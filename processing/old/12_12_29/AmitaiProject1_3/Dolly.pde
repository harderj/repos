class Dolly {

  int[] genome;
  IntVect[] path;
  IntVect p; // position
  color c;
  int age; // current age
  int goalsReached;
  boolean alive;

  Dolly() {
    genome = new int[genomeLength];
    path = new IntVect[genomeLength];
    p = new IntVect(startX, startY);
    c = color(random(255), random(255), random(255));
    newGenome();
    restart();
  }

  void update() {
    if (alive) act();
    die();
    draw();
  }

  void restart() {
    age=0;
    goalsReached = 0;
    alive = true;
    x=startX;
    y=startY;
    for (int i=0; i<genomeLength; i++) {
      path[i].set(startX, startY);
    }
  }

  void reincarnate(int[] fatherGenome) {
    restart();
    genome = mutate(fatherGenome);
  }

  int[] mutate(int[] f) {
    int[] r = new int[f.length];
    for (int i=0; i<f.length; i++) {
      r[i]=f[i];
      float a = random(1);
      if (a<mutationRate) {
        r[i] = randomGene();
      }
    }
    return r;
  }

  void newGenome() {
    for (int i=0; i<genomeLength; i++) {
      genome[i] = randomGene();
    }
  }

  void die() {
    color g = floorPlan.get(x, y);
    if (red(g)+blue(g)+green(g) < 255*3-colorTolerance) alive = false;
    else if (age>genomeLength-1) alive = false;
    else {
      for (int i=0; i<genomeLength; i++) {
        if (p==path[i]) {
          alive = false;
          break;
        }
      }
    }
  }

  float value() {
    Goal currentGoal = ((IntVect) goals.get(goalsReached));
    return 1/p.dist(currentGoal);
  }

  void act() {
    move(genome[age]);
    age++;
    path[age].set(p);
  }

  void move(int d) {
    switch(d) {
    case 0:
      p.x++;
      break;
    case 1:
      p.x++;
      p.y--;
      break;
    case 2:
      p.y--;
      break;
    case 3:
      p.y--;
      p.x--;
      break;
    case 4:
      p.x--;
      break;
    case 5:
      p.x--;
      p.y++;
      break;
    case 6:
      p.y++;
      break;
    case 7:
      p.y++;
      p.x++;
      break;
    default:
      break;
    }
  }

  void render() {
    noStroke();
    fill(c);
    ellipse(x, y, dollyDrawSize, dollyDrawSize);
  }
}

