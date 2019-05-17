int cardSpaceX = 30;
int cardSpaceY = 50;
int picked = -1;

char[] nameList = {
  'E', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'B', 'D', 'K'};
char[] suitList = {
  'h', 'd', 's', 'c'};

ArrayList cards;
PFont font;

void setup(){
  size(cardSpaceX*14, cardSpaceY*5);
  rectMode(CENTER);

  cards = new ArrayList();
  font = loadFont("ArialHebrew-48.vlw");

  for(int i=0; i<13; i++){
    for(int j=0; j<4; j++){
      cards.add(new Card(i+1, j+1, i+1, j+1));
    }
  }

  mix();
}

void draw(){
  background(0);

  for(int i=0; i<cards.size(); i++) ((Card) cards.get(i)).draw();
}

void mix(){
  for(int i=0; i<1000; i++){
    int r1 = (int) random(cards.size());
    int r2 = (int) random(cards.size());
    int tmpX = ((Card) cards.get(r1)).x;
    int tmpY = ((Card) cards.get(r1)).y;
    ((Card) cards.get(r1)).x = ((Card) cards.get(r2)).x;
    ((Card) cards.get(r1)).y = ((Card) cards.get(r2)).y;

    ((Card) cards.get(r2)).x = tmpX;
    ((Card) cards.get(r2)).y = tmpY;
  }
}

class Card {
  int x, y, n, s;

  Card(int x, int y, int n, int s){
    this.x = x;
    this.y = y;
    this.n = n;
    this.s = s;
  }

  void draw(){
    if(n!=1){
      stroke(255);
      strokeWeight(2);
      if(s<3) fill(255, 0, 0);
      else fill(125);
      rect(cardSpaceX*x, cardSpaceY*y, cardSpaceX*0.8, cardSpaceY*0.8);
      fill(0);
      textFont(font, 15);
      text(nameList[n-1] + " " + suitList[s-1], cardSpaceX*x-cardSpaceX*0.3, cardSpaceY*y);
    }
  }
}

void keyPressed(){
  mix();
}

void mousePressed(){
  int tmpX = 1 + (int) (mouseX-15)/cardSpaceX;
  int tmpY = 1 + (int) (mouseY-24)/cardSpaceY;

  for(int i=0; i<cards.size(); i++){
    if(tmpX == ((Card) cards.get(i)).x && tmpY == ((Card) cards.get(i)).y){
      //println(((Card) cards.get(i)).n + " " + ((Card) cards.get(i)).s);
      if(picked == -1){
        if(((Card) cards.get(i)).n != 1){
          picked = i;
        }
      }
      else {
        if(){
          
        }
      }
    }
  }

  //println(tmpX + " " + tmpY);
}


