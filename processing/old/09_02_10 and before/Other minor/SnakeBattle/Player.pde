class Player{
  boolean act = true;

  float x,y;
  color col;
  String keys;
  String mode = "stand";
  int deads = 0;

  Player(int x, int y, color col, String keys){
    this.x = float(x);
    this.y = float(y);
    this.col = col;
    this.keys = keys;
  }

  void draw(){
    if(mode != "dead"){
      keyActions();
      move();
    }
    if(mode != "stand") areaActions();
    render();
  }

  void move(){
    if(mode == "up") y--;
    if(mode == "down") y++;
    if(mode == "left") x--;
    if(mode == "right") x++;
  }

  void areaActions(){
    for(int i=0; i<areas.size(); i++){
      boolean tmpHitFlag = false;
      if(((Area) areas.get(i)).mode != "none") tmpHitFlag = true;
      float tmpThisX = x*GWS;
      float tmpThisY = y*GHS;
      float tmpThatX = ((Area) areas.get(i)).x*GWS;
      float tmpThatY = ((Area) areas.get(i)).y*GHS;
      if(tmpThisX>tmpThatX-5 && tmpThisX<tmpThatX+5 && tmpThisY>tmpThatY-5 && tmpThisY<tmpThatY+5){
        if(tmpHitFlag){
          if(mode != "dead"){
            mode = "dead";
            deads ++;
          }
        }
        else {
          ((Area) areas.get(i)).renderFlag = true;
          ((Area) areas.get(i)).mode = "taken";
          ((Area) areas.get(i)).col = col;
        }
      }
    }
  }

  void render(){
    float tmpX = x * GWP;
    float tmpY = y * GHP;
    float tmpVolX = GWP*2;
    float tmpVolY = GHP*2;

    fill(col);
    if(mode == "dead") fill(125,125,125);
    ellipse(tmpX,tmpY,tmpVolX,tmpVolY);
  }

  void keyActions(){
    char tmpFind = 'a';
    boolean tmpButtonMode0 = false;
    boolean tmpButtonMode1 = false;
    boolean tmpButtonMode2 = false;
    boolean tmpButtonMode3 = false;

    tmpFind = keys.charAt(0); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        tmpButtonMode0 = ((Button) buttons.get(i)).pressed;
      }
    }

    tmpFind = keys.charAt(1); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        tmpButtonMode1 = ((Button) buttons.get(i)).pressed;
      }
    }

    tmpFind = keys.charAt(2); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        tmpButtonMode2 = ((Button) buttons.get(i)).pressed;
      }
    }

    tmpFind = keys.charAt(3); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        tmpButtonMode3 = ((Button) buttons.get(i)).pressed;
      }
    }

    int tmpPressCount = 0;
    if(tmpButtonMode0) tmpPressCount ++;
    if(tmpButtonMode1) tmpPressCount ++;
    if(tmpButtonMode2) tmpPressCount ++;
    if(tmpButtonMode3) tmpPressCount ++;

    if(tmpPressCount == 1){
      if(tmpButtonMode0){
        mode = "up";
      }
      if(tmpButtonMode1){
        mode = "down";
      }
      if(tmpButtonMode2){
        mode = "left";
      }
      if(tmpButtonMode3){
        mode = "right";
      }
    }
  }
}
