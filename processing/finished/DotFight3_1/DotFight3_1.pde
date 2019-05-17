import processing.opengl.*;

// game settings
int playerCount = 2;
float drag = 0.95;

// player
float defaultStartLife = 1000;
float defaultSize = 10;
float defaultSpeed = 0.25;
float defaultTurnSpeed = PI*0.05;
float defaultTurnDrag = 0.7;

// details
float stackDistance = 30;
float textSizeDmgFactor = 4;
float textSizeMin = 25;

String[] keyList;

ArrayList players;
ArrayList missiles;
ArrayList buttons;
ArrayList textPops;

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
  
  for(int i=0; i<players.size(); i++) if(((Player) players.get(i)).is) ((Player) players.get(i)).draw();
  else players.remove(i);

  for(int i=0; i<missiles.size(); i++) if(((Missile) missiles.get(i)).is) ((Missile) missiles.get(i)).draw();
  else missiles.remove(i);
}

void renderRuntimeInformation(){
  fill(0,200,0);
  textFont(font, 10);

  // framerate
  text(frameRate, 5, height-5);
}

/*
void mousePressed(){
  textPops.add(new TextPop(str(int(random(20))), new Vect2(float(mouseX), float(mouseY)), 50, 20, 255, "001100", "hey"));
}
*/
