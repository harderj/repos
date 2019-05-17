// editable
int _size = 400;

// constants
int fieldNum = 64;
int pieceNum = 32;
int sqrtFieldNum = 8;
PFont font;
float dis;
int marked;

Fig[] f = new Fig[32];

void setup() {
  size(_size,_size);
  smooth();
  font = loadFont("Serif-48.vlw");
  textFont(font,13);
  dis = _size/(sqrtFieldNum + 1);


  for(int i=0; i<pieceNum;i++) {
    f[i] = new Fig('K', 1,1,0,i);
  }
  restartBoard();
}

void restartBoard() {
  String tmpRow = "rkbqKbkrpppppppprkbqKbkrpppppppp";
  int x,y=0;
  int c=0;
  for(int i=0; i<pieceNum;i++) {
    x=i%8;
    if(i==8) y++;
    if(i==16) {
      y=sqrtFieldNum-1; 
      c=1;
    }
    if(i==24) y--;
    f[i] = new Fig(tmpRow.charAt(i), x,y,c, i);
  }
}

void draw() {
  drawBoard(0);
}

void drawBoard(int startColor) {
  background(128);

  float space = 1;

  for(int i=0;i<fieldNum;i++) {
    int x = i%sqrtFieldNum;
    int y = floor( (float) i / (float) sqrtFieldNum );
    if(y%2 == 1) x = sqrtFieldNum - i%sqrtFieldNum - 1;

    noStroke();
    rectMode(CENTER);
    if((i+startColor)%2 == 1) fill(0);
    else fill(255);
    rect(x*dis+dis, y*dis+dis, dis-space, dis-space);
  }

  for(int i=0;i<pieceNum;i++) {
    f[i].draw();
  }
}

class Fig {
  int ID;
  int col;
  int x,y;
  char kind;

  Fig(char _kind, int _x, int _y, int _color, int _ID) {
    kind = _kind;
    x = _x;
    y = _y;
    col = _color;
    ID = _ID;
  }

  void draw() {
    float offX = -_size*0.04;
    float offY = _size*0.01;
    float posX = x*dis+dis+offX;
    float posY = y*dis+dis+offY;
    fill(128);
    if(marked!=ID) noStroke();
    else stroke(0,255,0);
    rectMode(CENTER);
    rect(posX-offX,posY-offY,width*0.1,height*0.05);
    fill(col*255); //fill(((col+1)%2)*200);
    if(kind == 'p') text("Pawn",posX,posY);
    if(kind == 'K') text("King",posX,posY);
    if(kind == 'q') text("Queen",posX,posY);
    if(kind == 'b') text("Bishop",posX,posY);
    if(kind == 'k') text("Knight",posX,posY);
    if(kind == 'r') text("Rook",posX,posY);
    
    if(marked == ID){
      int[] m = moves(kind,x,y,col);
      
      for(int i=0;i<m.length/2;i++){
        noFill();
        stroke(255,0,0);
        ellipseMode(CENTER);
        ellipse(m[i*2]*dis+dis,m[i*2+1]*dis+dis,10,10);
      }
    }
  }
  
}

void mousePressed(){
  int x=(int)((mouseX+dis*0.5) /dis)-1;
  int y=(int)((mouseY+dis*0.5) /dis)-1;
  
  marked = whosAt(x,y);
}

int whosAt(int x, int y){
  int i=0;
  while(i<pieceNum){
    if(f[i].x==x && f[i].y==y) break;
    else i++;
  }
  return i;
}

int[] moves(char k, int x, int y, int col){
  if(k == 'p'){
    int tmpC = 0;
    int tmpWay = 1-col*2;
    boolean front = false;
    boolean left = false;
    boolean right = false;
    if(whosAt(x,y+tmpWay) == pieceNum){
      tmpC ++;
      front = true;
    }
    if(whosAt(x+1,y+tmpWay) != pieceNum){
      left = true;
      tmpC ++;
    }
    if(whosAt(x-1,y+tmpWay) != pieceNum){
      right = true;
      tmpC ++;
    }
    if(col == 0 && y == 
    int[] tmpL = new int[tmpC*2];
    int tmpT = 0;
    if(front){
      tmpL[tmpT*2] = x;
      tmpL[tmpT*2+1] = y+tmpWay;
      tmpT ++;
    }
    if(left){
      tmpL[tmpT*2] = x+1;
      tmpL[tmpT*2+1] = y+tmpWay;
      tmpT ++;
    }
    if(right){
      tmpL[tmpT*2] = x-1;
      tmpL[tmpT*2+1] = y+tmpWay;
    }
    return tmpL;
  }
  int[] whatever = { 2, 23, 1, 2 };
  return whatever;
}


