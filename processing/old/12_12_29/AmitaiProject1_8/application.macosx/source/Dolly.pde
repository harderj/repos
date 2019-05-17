class Dolly {
  int ID;
  int[] genome;
  IntVect[] path;
  IntVect p; // position
  color c;
  int d;
  int age; // current age
  int reincarnations;
  int goalsReached;
  float value;

  Dolly(int i) {
    ID = i;
    genome = new int[genomeLength];
    path = new IntVect[genomeLength];
    p = new IntVect(start);
    c = color(random(255), random(255), random(255));
    reincarnations = 0;
    newGenome();
    restart();
  }

  void update() {
    act();
    die();
    render();
  }

  void act() {
    move(genome[age]);
    path[age].set(p);
    float dis = 9999999;
    if (goalsReached < goals.size()) {
      dis = p.dist(((IntVect) goals.get(goalsReached)));
      if (dis<goalDistanceRequired && goalsReached < goals.size()-1) {
        goalsReached ++;
      }
      dis = p.dist(((IntVect) goals.get(goalsReached)));
      float v = calculateValue(dis);
      if (v>bestValue) {
        for (int i=0; i<age; i++) {
          bestGenes[i] = genome[i];
          bestPath[i] = path[i];
        }
        bestValue = v;
        bestAge = age;
      }
    }
    age++;
  }

  void restart() {
    age=0;
    d=startDirection;
    goalsReached = 0;
    p.set(start);
    for (int i=0; i<genomeLength; i++) {
      path[i] = new IntVect(start);
    }
  }

  void mixWith(int[] g) {
    for (int i=0; i<genome.length; i++) {
      if (i<bestAge) genome[i] = g[i];
    }
  }

  int[] mutate(int[] f, int t) {
    for (int i=0; i<f.length; i++) {
      float a = random(1);
      if (a<mutationRate*((float(i)/float(t*2)))) f[i] = randomGene();
    }
    return f;
  }

  void newGenome() {
    for (int i=0; i<genomeLength; i++) {
      genome[i] = randomGene();
    }
  }

  void die() {
    boolean alive = true;
    color g = floorPlan.get(p.x, p.y);
    if (red(g)+blue(g)+green(g) < 255*3-colorTolerance) alive = false;
    else if (age>genomeLength-2) alive = false;
    if (!alive) {
      mixWith(bestGenes);
      mutate(genome, age);
      restart();
    }
  }

  float calculateValue(float dis) {
    IntVect currentGoal = ((IntVect) goals.get(goalsReached));
    return goalValue-dis+goalsReached*goalValue-age*ageFactor;
  }

  void turnLeft() {
    d=(d+1)%8;
  }

  void turnRight() {
    d=(d+7)%8;
  }

  void move(int a) {
    if (a==1) turnLeft();
    if (a==2) turnRight();
    switch(d) {
    case 0:
      p.x+=gridScale;
      break;
    case 1:
      p.x+=gridScale;
      p.y-=gridScale;
      break;
    case 2:
      p.y-=gridScale;
      break;
    case 3:
      p.y-=gridScale;
      p.x-=gridScale;
      break;
    case 4:
      p.x-=gridScale;
      break;
    case 5:
      p.x-=gridScale;
      p.y+=gridScale;
      break;
    case 6:
      p.y+=gridScale;
      break;
    case 7:
      p.y+=gridScale;
      p.x+=gridScale;
      break;
    default:
      break;
    }
  }

  void render() {
    noStroke();
    fill(c);
    ellipse(p.x, p.y, dollyDrawSize, dollyDrawSize);

    noFill();
    stroke(c);
    strokeWeight(1);
    beginShape();
    for (int i=1; i<age;i++) {
      vertex(path[i].x, path[i].y);
    }
    endShape();
  }
}

