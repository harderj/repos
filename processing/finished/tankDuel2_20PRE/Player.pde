class Player{

  float x,y,dir;
  float speX = 0;
  float speY = 0;
  int shootTimer,shootTimerReset;
  int weaponCounter = 0;
  int weaponCount = 9;
  int arrayNum;
  int lifeStart = 3000;
  int life = lifeStart;
  String[] weaponArray = new String[weaponCount];
  int[] weaponArrayCount = new int[weaponCount];
  String weapon = "test";

  Player(float x, float y){
    this.x = x;
    this.y = y;
    this.dir = 0;
    weaponArray[0] = "frozen orb";
    weaponArray[1] = "chance bomb";
    weaponArray[2] = "tree bomb";
    weaponArray[3] = "shot";
    weaponArray[4] = "sixcored bomb";
    weaponArray[5] = "hotshooting missile";
    weaponArray[6] = "mine";
    weaponArray[7] = "nova";
    weaponArray[8] = "breath";
    weaponArrayCount[0] = 0;
    weaponArrayCount[1] = 0;
    weaponArrayCount[2] = 0;
    weaponArrayCount[3] = 0;
    weaponArrayCount[4] = 0;
    weaponArrayCount[5] = 0;
    weaponArrayCount[6] = 0;
    weaponArrayCount[7] = 0;
    weaponArrayCount[8] = 0;
    buttonPush ++;
    arrayNum = buttonPush;
  }

  void draw(){
    updateTimers();
    keyActions();
    hit();
    render();
  }

  void updateTimers(){
    if(shootTimer > 0) shootTimer --;
    else shootTimerReset = -1;
  }

  void keyActions(){
    //move
    if(button[0+arrayNum*6]){
      speX += cos(dir)*0.25;
      speY += sin(dir)*0.25;
    }
    if(button[1+arrayNum*6]){
      speX -= cos(dir)*0.2;
      speY -= sin(dir)*0.2;
    }
    speX = speX*0.96;
    speY = speY*0.96;
    if(speX >= 5) speX = speX*0.9;
    if(speX <= -5) speX =  speX*0.9;
    if(speY >= 5) speY = speY*0.9;
    if(speY <= -5) speY = speY*0.9;
    x += speX;
    y += speY;
    //turn
    if(button[2+arrayNum*6]) dir += PI/16;
    if(button[3+arrayNum*6]) dir -= PI/16;
    //shoot
    if(buttonRelease[4+arrayNum*6] && shootTimer <= 0){
      missiles.add(new Missile(weapon,x,y,dir,5,arrayNum));
      if(weapon == "frozen orb") shootTimer = 25;
      if(weapon == "chance bomb") shootTimer = 6;
      if(weapon == "tree bomb") shootTimer = 17;
      if(weapon == "shot") shootTimer = 2;
      if(weapon == "sixcored bomb") shootTimer = 60;
      if(weapon == "hotshooting missile") shootTimer = 35;
      if(weapon == "mine") shootTimer = 7;
      if(weapon == "nova") shootTimer = 9;
      if(weapon == "breath") shootTimer = 13;
      shootTimerReset = shootTimer;
      weaponArrayCount[weaponCounter] --;
    }
    //change weapon
    if(buttonRelease[5+arrayNum*6]) changeWeapon();
    for(int tmp = 0; tmp < weaponCount; tmp++){
      if(weaponArrayCount[weaponCounter] <= 0) changeWeapon();
    }
    weapon = weaponArray[weaponCounter];
  }

  void changeWeapon(){
    weaponCounter ++;
    if(weaponCounter >= weaponCount) weaponCounter = 0;
  }

  void hit(){
    //walls
    if(x < 0){
      x = 1;
      speX = speX*-1.5;
    }
    if(x > width){
      x = width -1;
      speX = speX*-1.5;
    }
    if(y < 0){
      y = 1;
      speY = speY*-1.5;
    }
    if(y > height){
      y = height -1;
      speY = speY*-1.5;
    }
    //missiles
    for(int i=0; i<missiles.size(); i++){
      if(dist(x, y, ((Missile) missiles.get(i)).x, ((Missile) missiles.get(i)).y) < 10 && ((Missile) missiles.get(i)).owner != arrayNum){
        float tmp;
        tmp = ((Missile) missiles.get(i)).dmg;
        tmp = Variate(tmp);
        tmp = Critmize(tmp);
        ((Missile) missiles.get(i)).act = false;
        life -= int(tmp);
        if(((Missile) missiles.get(i)).name != "breath Piece"){
          speX += (cos(((Missile) missiles.get(i)).dir)/10-cos(((Missile) missiles.get(i)).dir)/20)*tmp;
          speY += (sin(((Missile) missiles.get(i)).dir)/10-sin(((Missile) missiles.get(i)).dir)/20)*tmp;
        }
        if(((Missile) missiles.get(i)).name == "frozen orb Piece1" || ((Missile) missiles.get(i)).name == "frozen orb Piece2" || ((Missile) missiles.get(i)).name == "frozen orb"){
          shootTimerReset += 21;
          shootTimer += 21;
        }
        color tmpCol = color(0);
        if(((Missile) missiles.get(i)).owner == 0) tmpCol = color(255,0,0);
        if(((Missile) missiles.get(i)).owner == 1) tmpCol = color(0,255,0);
        textPops.add(new TextPop(str(int(tmp)),x,y,(tmp/5)+10,20,tmpCol,"001111"));
      }
    }
    //astroids
    for(int i=0; i<astroids.size(); i++){
      if(dist(x, y, ((Astroid) astroids.get(i)).x, ((Astroid) astroids.get(i)).y) < ((Astroid) astroids.get(i)).vol){
        float tmp = dist(((Astroid) astroids.get(i)).speX + ((Astroid) astroids.get(i)).x, ((Astroid) astroids.get(i)).speY + ((Astroid) astroids.get(i)).y, ((Astroid) astroids.get(i)).x, ((Astroid) astroids.get(i)).y);
        tmp *= 5;
        tmp = Variate(tmp);
        life -= int(tmp);
        speX += (cos(((Astroid) astroids.get(i)).dirSpe)*0.75-cos(((Astroid) astroids.get(i)).dirSpe)*0.5)*tmp;
        speY += (sin(((Astroid) astroids.get(i)).dirSpe)*0.75-sin(((Astroid) astroids.get(i)).dirSpe)*0.5)*tmp;
        textPops.add(new TextPop(str(int(tmp)),x,y,(tmp/5)+10,20,color(255,255,255),"100011"));
      }
    }
    if(life < 1) doom = arrayNum;
  }

  void render(){
    //body
    noStroke();
    if(arrayNum == 0) fill(255,0,0);
    if(arrayNum == 1) fill(0,255,0);
    ellipse(x,y,10,10);
    //arm
    stroke(255);
    line(x, y, x + cos(dir)*11, y + sin(dir)*11);
    //viewers
    int tmpX = 0;
    int tmpY = 15;
    if(arrayNum == 0){
      tmpX = 0;
      tmpY = 15;
    }
    if(arrayNum == 1){
      tmpX = 200;
      tmpY = 15;
    }
    //cooldown viewer
    noFill();
    strokeWeight(1);
    stroke(255);
    rect(tmpX, tmpY, 100, tmpY -5);
    noStroke();
    if(arrayNum == 0) fill(255,0,0);
    if(arrayNum == 1) fill(0,255,0);
    float tmpA = float(shootTimer);
    float tmpB = float(shootTimerReset);
    rect(tmpX, tmpY,((tmpA+1)/(tmpB+1)*100), tmpY -5);
    //weapon viewer
    textFont(fontA,10);
    fill(255);
    text(weapon + " " + weaponArrayCount[weaponCounter], tmpX +3, 10);
    //life viewer
    textFont(fontA,10);
    if(arrayNum == 0) fill(255,0,0);
    if(arrayNum == 1) fill(0,255,0);
    text("Life: " + life, tmpX +3, 40);
    noFill();
    strokeWeight(1);
    stroke(255);
    rect(tmpX, tmpY + 30, 100, tmpY -5);
    noStroke();
    if(arrayNum == 0) fill(255,0,0);
    if(arrayNum == 1) fill(0,255,0);
    rect(tmpX, tmpY +30, float(life)/lifeStart*100, tmpY -5);
  }
}
