String rules;
boolean[][] world;

void setup() {
  //frameRate(12);
  size(200, 200, P2D);

  world = new boolean[width][height];

  //whiteSpreadsRandomlyRules(0.35);
  //randomizeRules();
  boolean[] tmp = {true, true, true, false, false, true, true, true, true, false};
  countingRules(tmp);
  //randomWorld(0.05);
  
  //conwayRules();
  whiteSeedWorld();
}

void draw() {
  renderWorld();
  updateWorld();
  println(frameRate);
}

void keyPressed(){
  if(key=='r') randomWorld();
  if(key=='b') blackWorld();
}

void renderWorld() {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      if (world[x][y]) set(x, y, color(255));
      else set(x, y, color(0));
    }
  }
}

void updateWorld() {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      String situation = "";
      for (int i=-1; i<2; i++) {
        for (int j=-1; j<2; j++) {
          if (get((x-i+width)%(width), (y-j+height)%(height)) == color(255)) situation += '1';
          else situation += '0';
        }
      }
      world[x][y] = (rules.charAt(unbinary(situation)) == '1');
    }
  }
}

void blackWorld() {
  for (int x=0; x<width; x++)
    for (int y=0; y<height; y++)
      world[x][y] = false;
}

void whiteSeedWorld() {
  blackWorld();
  world[int(width*0.5)][int(height*0.5)] = true;
}

void randomWorld() {
  for (int x=0; x<width; x++)
    for (int y=0; y<height; y++)
      world[x][y] = (random(1.0) < 0.5);
}

void randomWorld(float a) {
  for (int x=0; x<width; x++)
    for (int y=0; y<height; y++)
      world[x][y] = (random(1.0) < a);
}

void countingRules(boolean[] a){
  for (int i=0; i<pow(2, 9); i++) {
    String b = binary(i, 9);
    int n=0;
    for (int j=0; j<9; j++) if (b.charAt(j) == '1') n++;
    if(a[n]) rules += '1';
    else rules += '0';
  }
}

void randomCountingRules(){
  boolean[] a = new boolean[10]; // there are 10 levels of whiteness of the 3x3 square
  for (int j=0; j<10; j++) a[j] = (random(1)<0.5);
  for (int i=0; i<pow(2, 9); i++) {
    String b = binary(i, 9);
    int n=0;
    for (int j=0; j<9; j++) if (b.charAt(j) == '1') n++;
    if(a[n]) rules += '1';
    else rules += '0';
  }
}

void whiteAlwaysWinRules() {
  rules = "";
  for (int i=0; i<pow(2, 9); i++) rules += '1';
}

void whiteSpreadsRules() {
  rules = "0";
  for (int i=1; i<pow(2, 9); i++) rules += '1';
}

void whiteSpreadsRandomlyRules(float a) {
  rules = "0";
  for (int i=1; i<pow(2, 9); i++){
    if(random(1)<a) rules += '1';
    else rules += '0';
  }
}

void conwayRules() {
  rules = "";
  for (int i=0; i<pow(2, 9); i++) {
    String b = binary(i, 9);
    int n=0;
    for (int j=0; j<9; j++) if(j!=4 && b.charAt(j) == '1') n++;
    if((n == 3) || (b.charAt(4) == '1' && 1 < n && n < 4)) rules += '1';
    else rules += '0';
  }
}

void randomRules() {
  rules = "";
  for (int i=0; i<pow(2,9); i++) rules += int(random(2));
  println(rules);
}
