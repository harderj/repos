import processing.opengl.*;

int cardSpaceX = 90;
int cardSpaceY = 150;
int picked = -1;

String[] nameList = {
  "Es", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
String[] suitList = {
  "heart", "diamont", "spade", "club"};

ArrayList cards;
PFont font;

void setup(){
  size(cardSpaceX*14, cardSpaceY*5, OPENGL);
  rectMode(CENTER);
  smooth();

  cards = new ArrayList();
  font = loadFont("Courier-48.vlw");

  for(int i=0; i<13; i++){
    for(int j=0; j<4; j++){
      cards.add(new Card(i+1, j+1, i+1, j+1));
    }
  }
}

void draw(){
  background(125);

  for(int i=0; i<cards.size(); i++) if(i != picked) ((Card) cards.get(i)).draw(false);
  if(picked > -1) ((Card) cards.get(picked)).draw(true);
}

void mix(){
  for(int i=0; i<10000; i++){
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

void keyPressed(){
  if(key == 'm') mix();
  if(key == 's') solve();
}

void mousePressed(){
  int tmpX = 1 + (int) (mouseX-cardSpaceX*0.5)/cardSpaceX;
  int tmpY = 1 + (int) (mouseY-cardSpaceY*0.5)/cardSpaceY;

  checkSwap(tmpX, tmpY);
}


int findCard(int x, int y){
  int a = -1;
  for(int i=0; i<cards.size(); i++){
    if(x == ((Card) cards.get(i)).x && y == ((Card) cards.get(i)).y){
      a = i;
    }
  }

  return a;
}

void swap(int a, int b){
  int tmpX = ((Card) cards.get(a)).x;
  int tmpY = ((Card) cards.get(a)).y;
  ((Card) cards.get(a)).x = ((Card) cards.get(b)).x;
  ((Card) cards.get(a)).y = ((Card) cards.get(b)).y;
  ((Card) cards.get(b)).x = tmpX;
  ((Card) cards.get(b)).y = tmpY;
}

void checkSwap(int a, int b){
  int tmpCard = findCard(a, b);
  if(tmpCard > -1){
    if(picked == -1){
      if(((Card) cards.get(tmpCard)).n != 1){
        picked = tmpCard;
      }
    }
    else {
      if(((Card) cards.get(tmpCard)).n == 1){
        int otherCard = findCard(a-1, b);
        if(otherCard > -1){
          if(((Card) cards.get(picked)).s == ((Card) cards.get(otherCard)).s && ((Card) cards.get(picked)).n == ((Card) cards.get(otherCard)).n + 1 && ((Card) cards.get(picked)).n != 2){
            swap(picked, tmpCard);
            picked = -1;
          }
          else {
            picked = -1;
          }
        }
        else{
          if(((Card) cards.get(picked)).n == 2){
            swap(picked, tmpCard);
            picked = -1;
          }
          else {
            picked = -1;
          }
        }
      }
      else {
        picked = -1;
      }
    }
  }
}

