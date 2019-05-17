class Card {
  int x, y, n, s;

  Card(int x, int y, int n, int s){
    this.x = x;
    this.y = y;
    this.n = n;
    this.s = s;
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
}
