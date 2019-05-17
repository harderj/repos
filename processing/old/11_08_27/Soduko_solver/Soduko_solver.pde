
int n=9;
PFont font;
PVector p[] = new PVector[n*n]; // tekst pos

void setup() {
  font = loadFont("Serif-48.vlw");
  size(500,500);
  smooth();

  float offX = width/27;
  float offY = height/15;
  for(int i=0; i<sq(n); i++) {
    int x = i%n;
    int y = i/n;
    p[i] = new PVector((x+1)*width/(n+2)+offX, (y+1)*height/(n+2)+offY);
  }
  
  changeBoard("1203912039");
  
  println(int('1'));
}

void draw() {
  background(255);
  drawGrid();
  drawNumbers();
}

void drawNumbers() {
  for(int i=0; i<sq(n); i++) {
    textFont(font, 20);
    fill(255,0,0);
    if(p[i].z < 0) fill(0);
    if(int(p[i].z) != 0) {
      text(int(abs(p[i].z)), p[i].x, p[i].y);
    }
  }
}

void changeBoard(String data) {
  for(int i=0; i<min(sq(n),data.length()); i++) {
    p[i].z = data.charAt(i);
  }
}

