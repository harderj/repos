class Dolly {

  int[] genome;
  IntVect[] path;
  IntVect p; // position
  color c;
  int d;
  int age; // current age
  int goalsReached;
  float value;

  Dolly() {
    genome = new int[genomeLength];
    path = new IntVect[genomeLength];
    p = new IntVect(start);
    c = color(random(255), random(255), random(255));
    newGenome();
    restart();
  }

  void update() {
    act();
    die();
    render();
  }

  void restart() {
    age=0;
    d=0;
    goalsReached = 0;
    p.set(start);
    for (int i=0; i<genomeLength; i++) {
      path[i] = new IntVect(start);
    }
  }
  
  void becomeChildOf(int i) {
    genome = mutate(((Dolly) dollys.get(i)).genome);
  }

  int[] mutate(int[] f) {
    for (int i=0; i<f.length; i++) {
      float a = random(1);
      if (a<mutationRate) f[i] = randomGene();
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
    else {
      for (int i=0; i<genomeLength; i++) {
        if (p.equals(path[i])) {
          alive = false;
          break;
        }
      }
    }
    if(!alive){
      genome[age-1]=randomGene();
      restart();
    }
  }

  float value() {
    IntVect currentGoal = ((IntVect) goals.get(goalsReached));
    return 1000-p.dist(currentGoal)+goalsReached*1000;
  }

  void act() {
    path[age].set(p);
    move(genome[age]);
    value = max(value,value());
    age++;
  }
  
  void turnLeft(){
    d=(d+1)%8;
  }
  
  void turnRight(){
    d=(d+7)%8;
  }

  void move(int a) {
    if(a==1) turnLeft();
    if(a==2) turnRight();
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
    stroke(120,120,120);
    strokeWeight(1);
    beginShape();
    for(int i=0; i<age;i++){
      vertex(path[i].x,path[i].y);
    }
    endShape();
    
    textFont(font, 10);
    fill(0);
    text(int(value),p.x,p.y);
  }
}

