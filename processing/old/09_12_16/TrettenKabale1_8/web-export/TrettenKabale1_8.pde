import processing.opengl.*;

int cardSpaceX = 90;
int cardSpaceY = 150;
int picked = -1;

String[] nameList = {
  "Es", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
String[] suitList = {
  "heart", "diamond", "spade", "club"};

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
  if(key == 'b') bodilAlgorithm();
  if(key == 'k') kingAlgorithm();
}

void mousePressed(){
  int tmpX = 1 + (int) (mouseX-cardSpaceX*0.5)/cardSpaceX;
  int tmpY = 1 + (int) (mouseY-cardSpaceY*0.5)/cardSpaceY;

  checkSwap(tmpX, tmpY);
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
  int tmpCard = findPos(a, b);
  if(tmpCard > -1){
    if(picked == -1){
      if(((Card) cards.get(tmpCard)).n != 1){
        picked = tmpCard;
      }
    }
    else {
      if(((Card) cards.get(tmpCard)).n == 1){
        int otherCard = findPos(a-1, b);
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

void solve(){
  for(int i=0; i<1000; i++){
    picked = floor(random(cards.size()));
    
    if(((Card) cards.get(picked)).n != 1){
      int tmpR = floor(random(4));
      checkSwap(((Card) cards.get(tmpR)).x, ((Card) cards.get(tmpR)).y);
    }
  }
}
void bodilAlgorithm(){
  boolean fussy = true;

  int counter = 0;
  for(int e=0; e<8; e++){
    if(e == 4 && counter == 0) fussy = false;
    Card es = new Card(((Card) cards.get(e%4)));
    if(fussy){
      print("fussy");
      if(es.x == 1){
        print("ex.x = 1");
        counter += 1;
        checkSwap(findId(2, es.s), e%4);
      }
      else {
        print("ex.x != 1");
        Card next = new Card(((Card) cards.get(findPos(es.x-1, es.y))));

        if(next.n == 13){
          print("next = 13");
        }
        else {
          print("next != 13");
          Card fit = new Card(((Card) cards.get(findId(next.n+1, next.s))));

          if(((Card) cards.get(findPos(fit.x-1, fit.y))).n == 13){
            counter -= 1;
          }
          else {
            int tmpS = -1;
            for(int i=0; i<(fit.x-1); i++){
              Card tmpI = new Card(((Card) cards.get(findPos(i+1, fit.y))));

              if(i==0){
                if(tmpI.n == 2){
                  tmpS = tmpI.s;
                }
              }
              else {
                if(tmpS != -1){
                  if(tmpI.s == tmpS && tmpI.n == tmpI.x){

                  }
                  else {
                    tmpS = -1;
                  }
                }
              }
            }
            if(tmpS > 0){
              counter += 1;
              checkSwap(findId(next.n+1, next.s), e%4);
            }
          }
        }
      }
    }
    else {
      print("anti fussy");
      if(es.x == 1){
        checkSwap(findId(2, es.s), e%4);
      }
      else {
        Card next = new Card(((Card) cards.get(findPos(es.x-1, es.y))));

        if(next.n == 13){

        }
        else {
          checkSwap(findId(next.n+1, next.s), e%4);
        }
      }
    }
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
  
  Card(Card c){
    this.x = c.x;
    this.y = c.y;
    this.n = c.n;
    this.s = c.s;
  }

  void draw(boolean pick){
    if(n!=1){
      float tmpX, tmpY;
      if(pick){
        tmpX = mouseX;
        tmpY = mouseY;
      }
      else {
        tmpX = cardSpaceX*x;
        tmpY = cardSpaceY*y;
      }
      stroke(0);
      strokeWeight(2);
      fill(255);
      rect(tmpX, tmpY, cardSpaceX*0.8, cardSpaceY*0.8);
      
      if(s<3) fill(255, 0, 0);
      else fill(0);
      textFont(font, 50);
      float tmpX2 = tmpX;
      if(n == 10) tmpX2 -= cardSpaceX*0.15;
      text(nameList[n-1], tmpX2-cardSpaceX*0.20, tmpY);
      if(s==2) textFont(font, 13);
      else if(s==4) textFont(font, 22);
      else textFont(font, 17);
      text(suitList[s-1], tmpX-cardSpaceX*0.3, tmpY+cardSpaceY*0.3);
    }
  }
  
  void prnt(){
    println("x: " + x + " y: " + y + " number: " + n + " suit: " + s);
  }
}

int findPos(int x, int y){
  int a = -1;
  for(int i=0; i<cards.size(); i++){
    if(x == ((Card) cards.get(i)).x && y == ((Card) cards.get(i)).y){
      a = i;
    }
  }

  return a;
}

int findId(int n, int s){
  int a = -1;
  for(int i=0; i<cards.size(); i++){
    if(n == ((Card) cards.get(i)).n && s == ((Card) cards.get(i)).s){
      a = i;
    }
  }

  return a;
}
void kingAlgorithm(){

  Card es = new Card(((Card) cards.get(findId(1, (int) random(4)))));

  if(es.x > 1){
    Card byEs = new Card(((Card) cards.get(findPos(es.x+1, es.y))));
  }
  else {
    for(int i=0; i<4; i++){
      Card two = new Card(((Card) cards.get(findId(2, i+1))));

      if(two.x > 1){
        Card byTwo = new Card(((Card) cards.get(findPos(two.x+1, two.y))));
      }
    }
  }
}


