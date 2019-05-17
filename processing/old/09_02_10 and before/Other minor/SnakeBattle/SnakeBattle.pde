import processing.opengl.*;

ArrayList players;
ArrayList buttons;
ArrayList areas;

float GW = 1200; // Global Width
float GH = 800; // Global Height
float GWS = 150; // Global Width Scale
float GHS = 100; // Global Height Scale
float GWP = GW/GWS; // Global Width Pixel volume
float GHP = GH/GHS; // Global Height Pixel volume
float GT = 0; // Global Time
boolean RF = false; // Round Flag
float RT = 0; // Round Time
int RC = 0; // Round Count
int RTimer = 10; // Round Timer
color BGC = color(0); // BackGround Color
PFont font;
boolean testFlag = true;

void setup(){
  size(int(GW),int(GH),OPENGL);
  background(BGC);
  frameRate(20);
  ellipseMode(CENTER);
  rectMode(CENTER);

  font = loadFont("Arial-Black-48.vlw");

  players = new ArrayList();
  buttons = new ArrayList();
  areas = new ArrayList();

  createAreas();

  buttons.add(new Button('w'));
  buttons.add(new Button('s'));
  buttons.add(new Button('a'));
  buttons.add(new Button('d'));
  players.add(new Player(int(random(GWS)),int(random(GHS)),color(random(10,255),random(10,255),random(10,255)), "wsad"));

  buttons.add(new Button('t'));
  buttons.add(new Button('g'));
  buttons.add(new Button('f'));
  buttons.add(new Button('h'));
  players.add(new Player(int(random(GWS)),int(random(GHS)),color(random(10,255),random(10,255),random(10,255)), "tgfh"));

  buttons.add(new Button('i'));
  buttons.add(new Button('k'));
  buttons.add(new Button('j'));
  buttons.add(new Button('l'));
  players.add(new Player(int(random(GWS)),int(random(GHS)),color(random(10,255),random(10,255),random(10,255)), "ikjl"));
}

void createAreas(){
  int tmpCount = int(GWS*GHS);
  int tmpX = 0;
  int tmpY = 0;

  for(int i=0; i<tmpCount; i++){
    areas.add(new Area(tmpX,tmpY));
    tmpX += 1;
    if(tmpX > GWS){
      tmpY += 1;
      tmpX = 0;
    }
  }
}

void draw(){
  updateVariables();
  updateRound();
  fade();
  updateArrays();
  screenTexts();
}

void updateVariables(){
  GT += 1/frameRate;
  if(RTimer > 0) RTimer --;
  if(!RF && RTimer <= 0){
    newRound();
  }
}

void updateRound(){
  RT += 1/frameRate;
  int tmpDeadCount = 0;
  for(int i=0; i<players.size(); i++){
    if(((Player) players.get(i)).mode == "dead"){
      tmpDeadCount ++;
    }
  }
  if(tmpDeadCount >= players.size()-1){
    RF = false;
    RTimer = 100;
  }
}

void newRound(){
  RC ++;
  RT = 0;
  RF = true;
  for(int i=0; i<players.size(); i++){
    ((Player) players.get(i)).mode = "stand";
    ((Player) players.get(i)).x = int(random(GWS));
    ((Player) players.get(i)).y = int(random(GHS));
  }
}

void screenTexts(){
  float tmpF = 10; // flirness factor of the texts color
  textFont(font, 9);

  // time
  int tmpS;
  int tmpM;
  int tmpH;

  fill(255+int(random(tmpF,-tmpF)),0+int(random(tmpF,-tmpF)),0+int(random(tmpF,-tmpF)),200);
  tmpS = second();
  tmpM = minute();
  tmpH = hour();
  text("Real time:  " + tmpH + ":" + tmpM + ":" + tmpS, width/100*3, height/100*91);

  fill(255+int(random(tmpF,-tmpF)),125+int(random(tmpF,-tmpF)),0+int(random(tmpF,-tmpF)),200);
  tmpS = floor(GT);
  tmpM = floor(tmpS/60);
  tmpH = floor(tmpM/60);
  tmpS -= tmpM*60;
  tmpM -= tmpH*60;
  text("Time passed ca:  " + tmpH + ":" + tmpM + ":" + tmpS, width/100*3, height/100*93);

  // frame info
  fill(125+int(random(tmpF,-tmpF)),255+int(random(tmpF,-tmpF)),0+int(random(tmpF,-tmpF)),200);
  text("Frames passed:  " + frameCount, width/100*3, height/100*95);

  fill(0+int(random(tmpF,-tmpF)),255+int(random(tmpF,-tmpF)),0+int(random(tmpF,-tmpF)),200);
  text("Frames per second:  " + int(frameRate), width/100*3, height/100*97);

  // player info

  fill(255);
  float tmpY = width/100*3;
  float tmpAddY = width/100*3;
  for(int i=0; i<players.size(); i++){
    text("Player " + i + "'s score: " + ((Player) players.get(i)).deads, width/100*3, tmpY);
    tmpY += tmpAddY;
  }
}

void updateArrays(){
  for (int i=0; i<areas.size(); i++){
    if(((Area) areas.get(i)).act){
      if(((Area) areas.get(i)).mode != "inact"){
        ((Area) areas.get(i)).draw();
      }
    }
    else{
      areas.remove(i);
    }
  }

  for (int i=0; i<players.size(); i++) if(((Player) players.get(i)).act) ((Player) players.get(i)).draw(); 
  else players.remove(i);

  for (int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).act) ((Button) buttons.get(i)).draw(); 
  else buttons.remove(i);
}

void fade(){
  fill(BGC);
  stroke(255,255,255,50);
  rect(GW/2,GH/2,GW,GH);
}
