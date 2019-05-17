import processing.opengl.*;

int playerNum = 2;
int buttonPush = -1;
int frameCounter = 0;
int doom = 2;
int doomTimer = 100;
int loool = 10; //int(Critmize(random(250,500)));

boolean[] button = new boolean[12];
boolean[] buttonRelease = new boolean[12];

ArrayList players;
ArrayList missiles;
ArrayList textPops;
ArrayList astroids;
ArrayList stars;

PFont fontA;
PImage stoneTEXTURE;

void setup(){
  size(800,600, OPENGL);
  frameRate(25);
  smooth();
  fontA = loadFont("Ziggurat-HTF-Black-32.vlw");
  stoneTEXTURE = loadImage("lawl.jpg");
  textFont(fontA,10);
  setArrayLists();
  addPlayers();
  for(int i=0; i<100; i++){
    stars.add(new Star(random(width),random(height)));
  }
}

void setArrayLists(){
  players = new ArrayList();
  missiles = new ArrayList();
  textPops = new ArrayList();
  astroids = new ArrayList();
  stars = new ArrayList();
}

void addPlayers(){
  if(playerNum == 1) players.add(new Player(50,250));
  if(playerNum == 2){
    players.add(new Player(50,250));
    players.add(new Player(450,250));
  }
}

void draw(){
  clear(doom);
  if(doom == 2 || doom == 3) doAllThatShit();
  else{
    doomTimer --;
    if(doom == 0){
      textFont(fontA,30);
      fill(0,255,0);
      text("GREEN WON", width/2, height/2);
    }
    else {
      textFont(fontA,30);
      fill(255,0,0);
      text("RED WON", width/2, height/2);
    }
  }
  if(doomTimer < 0){
    doom = 3;
  }
}

void doAllThatShit(){
  frameCounter ++;
  addAstroids();
  updateArrays();
  updateButtons();
}

void clear(int tmp){
  noStroke();
  if(tmp == 0) fill(0,0,0,0);
  if(tmp == 1) fill(0,0,0,0);
  if(tmp == 2) fill(0,0,0,150);
  if(tmp == 3) fill(0,0,0,5);
  fill(0);
  rect(-1,-1,width+2,height+2);
  textFont(fontA,14);
  fill(255);
  text("Elapsed Time: " + frameCounter/1500 + " minutes / " + (frameCounter/25 - 60*(frameCounter/1500)) + " seconds", width/50, height/50*48);
  fill(255,0,0);
  text("astroid thinkness: " + int(loool), width/50*1, height/50*47);
  fill(0,255,0);
  text("frames / second: " + int(frameRate), width/50*1, height/50*49);
  if(frameCounter/25 - 15*(frameCounter/375) == 0) loool = 10000;
}

void addAstroids(){
  int tmp = 100;
  if(random(10000)<tmp/2){
    if(int(random(2))<1){
      astroids.add(new Astroid(0-10,int(random(height)),random(-PI*0.5,PI*0.5),random(1,5),Critmize(random(1,20))));
    } 
    else {
      astroids.add(new Astroid(int(random(width)),0-10,random(PI),random(1,5),Critmize(random(1,20))));
    }
  }
  if(random(10000)<tmp/2){
    if(int(random(2))<1){
      astroids.add(new Astroid(width+10,int(random(height)),random(-PI*1.5,-PI*0.5),random(1,5),Critmize(random(1,20))));
    } 
    else {
      astroids.add(new Astroid(int(random(width)),height+10,random(-PI),random(1,5),Critmize(random(1,20))));
    }
  }
}

void updateArrays(){
  for(int i=0; i<stars.size(); i++){
    ((Star) stars.get(i)).draw();
  }
  for(int i=0; i<missiles.size(); i++){
    ((Missile) missiles.get(i)).draw();
    if(!((Missile) missiles.get(i)).act) missiles.remove(i);
  }
  if(doom == 2){
    for(int i=0; i<textPops.size(); i++){
      ((TextPop) textPops.get(i)).draw();
      if(!((TextPop) textPops.get(i)).active) textPops.remove(i);
    }
  }
  for(int i=0; i<astroids.size(); i++){
    ((Astroid) astroids.get(i)).draw();
    if(!((Astroid) astroids.get(i)).act) astroids.remove(i);
  }
  for(int i=0; i<playerNum; i++){
    ((Player) players.get(i)).draw();
  }
}

void updateButtons(){
  buttonRelease[0] = false;
  buttonRelease[1] = false;
  buttonRelease[2] = false;
  buttonRelease[3] = false;
  buttonRelease[4] = false;
  buttonRelease[5] = false;
  buttonRelease[6] = false;
  buttonRelease[7] = false;
  buttonRelease[8] = false;
  buttonRelease[9] = false;
  buttonRelease[10] = false;
  buttonRelease[11] = false;
}

void keyPressed(){
  if(key == 'w') button[0] = true;
  if(key == 's') button[1] = true;
  if(key == 'd') button[2] = true;
  if(key == 'a') button[3] = true;
  if(key == 'x') button[4] = true;
  if(key == 'z') button[5] = true;
  if(key == 'u') button[6] = true;
  if(key == 'j') button[7] = true;
  if(key == 'k') button[8] = true;
  if(key == 'h') button[9] = true;
  if(key == 'm') button[10] = true;
  if(key == 'n') button[11] = true;
}

void keyReleased(){
  if(key == 'w' && button[0]){
    if(button[0]) buttonRelease[0] = true; 
    button[0] = false;
  }
  if(key == 's' && button[1]){
    if(button[1]) buttonRelease[1] = true; 
    button[1] = false;
  }
  if(key == 'd' && button[2]){
    if(button[2]) buttonRelease[2] = true; 
    button[2] = false;
  }
  if(key == 'a' && button[3]){
    if(button[3]) buttonRelease[3] = true;
    button[3] = false;
  }
  if(key == 'x' && button[4]){
    if(button[4]) buttonRelease[4] = true;
    button[4] = false;
  }
  if(key == 'z' && button[5]){
    if(button[5]) buttonRelease[5] = true; 
    button[5] = false;
  }
  if(key == 'u' && button[6]){
    if(button[6]) buttonRelease[6] = true; 
    button[6] = false;
  }
  if(key == 'j' && button[7]){
    if(button[7]) buttonRelease[7] = true; 
    button[7] = false;
  }
  if(key == 'k' && button[8]){
    if(button[8]) buttonRelease[8] = true; 
    button[8] = false;
  }
  if(key == 'h' && button[9]){
    if(button[9]) buttonRelease[9] = true;
    button[9] = false;
  }
  if(key == 'm' && button[10]){
    if(button[10]) buttonRelease[10] = true;
    button[10] = false;
  }
  if(key == 'n' && button[11]){
    if(button[11]) buttonRelease[11] = true; 
    button[11] = false;
  }
}

void mousePressed(){
  ((Player) players.get(0)).dir = atan2(mouseY-((Player) players.get(0)).y,mouseX-((Player) players.get(0)).x);
  ((Player) players.get(1)).dir = atan2(mouseY-((Player) players.get(1)).y,mouseX-((Player) players.get(1)).x);
  astroids.add(new Astroid(mouseX,mouseY,random(PI*2),random(3,5),random(10,15)));
}
