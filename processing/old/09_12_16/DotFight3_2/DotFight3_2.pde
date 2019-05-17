import processing.opengl.*;

// game settings
int playerCount = 3;
float drag = 0.95;

// player
float defaultStartLife = 1000;
float defaultSize = 5;
float defaultSpeed = 0.25;
float defaultTurnSpeed = PI*0.05;
float defaultTurnDrag = 0.7;

// details
float stackDistance = 30;
float textSizeDmgFactor = 2;
float textSizeMin = 25;
float randomPointFactorAstroid = 0.3;
float astroidDirectionDiversity = 0.02;
float astroidSpeedMin = 5;
float astroidSpeedMax = 8;
float astroidSizeMin = 5;
float astroidSizeMax = 40;
float astroidSpin = 0.2;
float astroidCreationDist = 1000;
float astroidStormStrengthDiversity = 300;
float astroidStormSpeedDiversityMin = 0.1;
float astroidStormSpeedDiversityMax = 2;
float astroidStormChangeFrequency = 0.3;
int astroidPointCountDiversity = 2;
int astroidPointCount = 10;

String[] keyList;
float astroidStormDirection = random(TWO_PI);
float astroidFrequency = random(0,astroidStormStrengthDiversity);
float astroidSpeedCurrent = 0.5;

ArrayList players;
ArrayList missiles;
ArrayList buttons;
ArrayList textPops;
ArrayList astroids;

PFont font;

void setup(){
  size(800,800, OPENGL);
  frameRate(25);
  smooth();
  ellipseMode(CENTER);
  font = loadFont("Arial-Black-48.vlw");

  players = new ArrayList();
  missiles = new ArrayList();
  buttons = new ArrayList();
  textPops = new ArrayList();
  astroids = new ArrayList();

  // add players
  keyList = new String[3];
  keyList[0] = "wsadq1";
  keyList[1] = "tgfhr4";
  keyList[2] = "ikjlu7";
  for(int i=0; i<playerCount; i++){
    addButtons(keyList[i]);
    addPlayers(i);
  }
}

void addPlayers(int i){
  if(i==0) players.add(new Player(new Vect2(width*0.2, height*0.2), keyList[0], "0_Heino"));
  if(i==1) players.add(new Player(new Vect2(width*0.5, height*0.2), keyList[1], "1_Brian"));
  if(i==2) players.add(new Player(new Vect2(width*0.2, height*0.5), keyList[2], "2_Jürgen"));
}

void draw(){
  background(0);
  gameEvents();
  updateArrays();
  renderRuntimeInformation();
}

void gameEvents(){
  // astroid events
  if(random(1000)<astroidFrequency){
    float tmpSize = random(astroidSizeMin, astroidSizeMax);
    float tmpDir = astroidStormDirection + random((TWO_PI)-astroidDirectionDiversity, (TWO_PI)+astroidDirectionDiversity);
    
    Vect2 tmpPos = new Vect2(width*0.5, height*0.5);
    float tmpAng = random((astroidStormDirection + PI) - PI*0.25, (astroidStormDirection + PI) + PI*0.25);
    tmpPos.add(cos(tmpAng)*astroidCreationDist, sin(tmpAng)*astroidCreationDist);
    /*
    tmpPos.set(random(width), 50);
    tmpPos.set(random(width), height - 50);
    tmpPos.set(50, random(height));
    tmpPos.set(width - 50, random(height));
    
    if(astroidStormDirection > 0 && astroidStormDirection < PI*0.5) tmpPos.set(50, random(height));
    if(astroidStormDirection > PI*0.5 && astroidStormDirection < PI) tmpPos.set(random(width), height - 50);
    if(astroidStormDirection > PI && astroidStormDirection < PI*1.5) tmpPos.set(random(width), 50);
    if(astroidStormDirection > PI*1.5 && astroidStormDirection < PI*2) tmpPos.set(width - 50, random(height));
    */
    
    Vect2 tmpVel = new Vect2(cos(tmpDir)*random(astroidSpeedMin, astroidSpeedMax), sin(tmpDir)*random(astroidSpeedMin, astroidSpeedMax));
    tmpVel.mult(astroidSpeedCurrent);
    
    astroids.add(new Astroid(tmpPos, tmpVel, tmpSize));
  }
  
  if(random(1000)<astroidStormChangeFrequency){
    astroidStormDirection = random(TWO_PI);
    astroidFrequency = random(astroidStormStrengthDiversity);
    astroidSpeedCurrent = random(astroidStormSpeedDiversityMin, astroidStormSpeedDiversityMax);
  }
  
  // last man standing
  if(players.size() == 1){
    String tmpName = ((Player) players.get(0)).id;
    int tmpPlace = searchString('_', tmpName);
    tmpName = tmpName.substring(tmpPlace+1);

    float tmpSize = 0.05;
    color tmpSkin = ((Player) players.get(0)).skin;
    textPops.add(new TextPop(tmpName + " WON", new Vect2(width*0.5, height*0.5), sqrt(width*height)*tmpSize, 100, tmpSkin, "000000"));

    ((Player) players.get(0)).is = false;
  }

  if(players.size() == 0) for(int i=0; i<playerCount; i++) addPlayers(i);
}

void updateArrays(){
  for(int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).is) ((Button) buttons.get(i)).draw();
  else buttons.remove(i);

  for(int i=0; i<textPops.size(); i++) if(((TextPop) textPops.get(i)).is) ((TextPop) textPops.get(i)).draw();
  else textPops.remove(i);

  for(int i=0; i<missiles.size(); i++) if(((Missile) missiles.get(i)).is) ((Missile) missiles.get(i)).draw();
  else missiles.remove(i);
  
  for(int i=0; i<astroids.size(); i++) if(((Astroid) astroids.get(i)).is) ((Astroid) astroids.get(i)).draw(); // println("hey");
  else astroids.remove(i);
  
  for(int i=0; i<players.size(); i++) if(((Player) players.get(i)).is) ((Player) players.get(i)).draw();
  else players.remove(i);
}

void renderRuntimeInformation(){
  fill(0,200,0);
  textFont(font, 10);

  // framerate
  text("Framerate: " + frameRate, 5, height-5);
  
  text("Astroid Count: " + astroids.size(), 5, height-15);
}

void mousePressed(){
  Vect2 tmpMouse = new Vect2(mouseX, mouseY);
  Vect2 tmpMouseDelta = new Vect2(mouseX-pmouseX, mouseY-pmouseY);
  astroids.add(new Astroid(tmpMouse, tmpMouseDelta, random(5,10)));
}


