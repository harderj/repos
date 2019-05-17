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
    float tmpX, tmpY;
    if(pick){
      tmpX = mouseX;
      tmpY = mouseY;
    }
    else {
      tmpX = cardSpaceX*x;
      tmpY = cardSpaceY*y;
    }
    if(n!=1){
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
    else{
      stroke(0);
      strokeWeight(2);
      noFill();
      rect(tmpX, tmpY, cardSpaceX*0.8, cardSpaceY*0.8);
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

