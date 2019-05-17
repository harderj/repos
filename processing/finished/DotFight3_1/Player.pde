class Player{
  boolean is = true;

  Vect2 pos, vel, acc;
  float direction, turnVel, turnAcc;
  char forward, backward, turnRight, turnLeft, fire, changeWeapon;
  color skin = color(255,0,0);
  float extend = defaultSize;
  float life = defaultStartLife;
  float speed = defaultSpeed;
  float turnSpeed = defaultTurnSpeed;
  float turnDrag = defaultTurnDrag;
  String id;

  String[] weaponList;
  int currentWeapon;
  int cooldownTimer;

  Player(Vect2 posision, String controls, String id){
    forward = controls.charAt(0);
    backward = controls.charAt(1);
    turnLeft = controls.charAt(2);
    turnRight = controls.charAt(3);
    fire = controls.charAt(4);
    changeWeapon = controls.charAt(5);
    pos = new Vect2(posision);
    vel = new Vect2();
    acc = new Vect2();
    direction = 0;
    turnVel = 0;
    turnAcc = 0;
    this.id = id;
    
    float tmpA = random(255);
    float tmpB = random(255-tmpA);
    float tmpC = 255-(tmpA+tmpB);
    skin = color(tmpA, tmpB, tmpC);
    
    int tmp = 10;
    weaponList = new String[tmp];
    for(int i=0; i<tmp; i++) weaponList[i] = "";
    
    weaponList[0] = "1000_arrow";
    weaponList[1] = "10_frozenorb";
    weaponList[2] = "200_spiralshot";
    weaponList[3] = "100_heatseeking";
    weaponList[4] = "3_unfair";
    currentWeapon = 2;
  }

  void draw(){
    manageInput();
    hitScreen();
    hitMissiles();
    updateBaseValues();
    runtimeInformation();
    render();
  }

  void runtimeInformation(){
    int tmpPlaceId = searchString('_', id);
    int tmpNum = int(id.substring(0, tmpPlaceId));

    float offsetX = 0.2;
    float offsetY = 0.1;
    float tmpX = width*offsetX*0.1;
    float tmpY = height*offsetY*0.2;
    int tmpI = 0;

    while(tmpI != tmpNum){
      tmpI ++;
      tmpX += width*offsetX;
      if(tmpX>width*(1-offsetX*0.5)){
        tmpY += height*offsetY;
        tmpX = width*offsetX*0.1;
      }
    }

    // life bar
    noFill();
    strokeWeight(3);
    stroke(255);
    rect(tmpX,tmpY,width*0.1, 20);
    noStroke();
    fill(skin);
    rect(tmpX,tmpY,(width*0.1)*(life/defaultStartLife), 20);

    // text
    String tmpString = weaponList[currentWeapon];
    int tmpPlace = searchString('_', tmpString);
    int tmpCount = int(tmpString.substring(0,tmpPlace));
    tmpString = tmpString.substring(tmpPlace+1);

    fill(255);
    textFont(font, 10);
    text("Weapon : " + tmpString + " : " + tmpCount, tmpX, tmpY + 40);
    
    String tmpName = id;
    int tmpPlace2 = searchString('_', tmpName);
    tmpName = tmpName.substring(tmpPlace2+1);
    text("''" + tmpName + "''", tmpX, tmpY + 55);
    
    fill(255);
    textFont(font, 15);
    text(int(life), tmpX+5, tmpY + 15);
    }

    void hitMissiles(){
      float hitDistance = extend*0.7;
      for(int i=0; i<missiles.size(); i++){
        Vect2 tmpPos = new Vect2(((Missile) missiles.get(i)).pos);
        Vect2 tmpDelta = new Vect2(pos);
        tmpDelta.sub(tmpPos);
        if(tmpDelta.x*tmpDelta.x + tmpDelta.y*tmpDelta.y < hitDistance*hitDistance){
          ((Missile) missiles.get(i)).specialAbilities(3);
          ((Missile) missiles.get(i)).is = false;
          life -= ((Missile) missiles.get(i)).dmg;

          int tmpTextSize = int(((Missile) missiles.get(i)).dmg*textSizeDmgFactor + textSizeMin);
          textPops.add(new TextPop(str(int(((Missile) missiles.get(i)).dmg)), pos, tmpTextSize, 15, 255, "001100"));
        }
      }
    }

  void hitScreen(){
    if(pos.x<0){
      pos.x=0;
      vel.x *= -0.5;
    }
    if(pos.y<0){
      pos.y=0;
      vel.y *= -0.5;
    }
    if(pos.x>width){
      pos.x=width;
      vel.x *= -0.5;
    }
    if(pos.y>height){
      pos.y=height;
      vel.y *= -0.5;
    }
  }

  void manageInput(){
    if(getButtonBinary(forward)) acc.add(cos(direction)*speed, sin(direction)*speed);
    if(getButtonBinary(backward)) acc.add(-cos(direction)*speed, -sin(direction)*speed);
    if(getButtonBinary(turnLeft)) turnAcc -= turnSpeed;
    if(getButtonBinary(turnRight)) turnAcc += turnSpeed;
    if(getButtonBinary(fire)) shoot();
    if(getButtonState(changeWeapon) == "press") changeWeapon();
  }
  
  void changeWeapon(){
    currentWeapon = (currentWeapon+1)%weaponList.length;
    while(weaponList[currentWeapon] == "") currentWeapon = (currentWeapon+1)%weaponList.length;
  }

  void shoot(){
    if(cooldownTimer < 1){
      cooldownTimer = 10;
      String tmpString = weaponList[currentWeapon];
      int tmpPlace = searchString('_', tmpString);
      int tmpCount = int(tmpString.substring(0,tmpPlace));
      tmpString = tmpString.substring(tmpPlace+1);

      Vect2 tmpCannonPos = new Vect2(pos.x+cos(direction)*extend, pos.y+sin(direction)*extend);
      missiles.add(new Missile(tmpString, tmpCannonPos, vel, direction));

      tmpCount --;
      if(tmpCount <= 0){
        weaponList[currentWeapon] = "";
        currentWeapon = 0;
      }
      else{
        weaponList[currentWeapon] = tmpCount + "_" + tmpString;
      }
    }
  }

  void updateBaseValues(){
    if(cooldownTimer > 0) cooldownTimer --;

    turnVel += turnAcc;
    turnVel *= turnDrag;
    direction += turnVel;
    turnAcc = 0;

    vel.add(acc);
    vel.mult(drag);
    pos.add(vel);
    acc.set();
    
    if(life < 0) die();
  }

  void render(){
    fill(skin);
    noStroke();
    ellipse(pos.x,pos.y,extend,extend);
    stroke(155);
    strokeWeight(3);
    float cannonLength = 1/(cooldownTimer*0.1+1);
    line(pos.x, pos.y, pos.x+cos(direction)*extend*cannonLength, pos.y+sin(direction)*extend*cannonLength);
  }
  
  void die(){
    is = false;
    int explosionDensity = 6;
      for(int i=0; i<explosionDensity; i++){
      missiles.add(new Missile("frozenorbspike", pos, vel, (TWO_PI/explosionDensity)*i + direction));
    }
  }
}





