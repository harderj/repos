/*
Done:
         ----- Part 1 -----
  - Basic Setup
  - The Button-array
  - The Text Function
  - The Bace Fighter Attacks (theological)
  - The Bace Fighter Attacks (practical)
    - textPop's on attacks
  
Needed:
    - randomized damage
      - critmize function (remake)
      - randmize function (remake)
  - Bug fixes
         ----- Part 2 -----
  - Advanced Fighter Attacks (theological)
  - Advanced Fighter Attacks (practical)
  - Visuel remake
  - Sound effects
         ----- Part 3 -----
  - Game Program 
  - Editor program
         ----- Part 4 -----
  - Securing
  - Uploading
         ----- Part 5 -----
  - Advancing
  - Reuploading
  - Selling
*/

ArrayList buttons;
ArrayList textPops;

PFont font;

color backgroundColor = color(0,0,0);
float startLife = 100;

String mode1, mode2;
float life1, life2;
float x1, x2;

float strikingStrikingDmg = 20;
float strikingStrikeDmg = 8;
float strikingBackDmg = 5;
float strikingHlstrikingDmg = 15;
float strikingHlstrikeDmg = 10;
float strikingBlockDmg = 5;
float backingStrikeDmg = 3;
float blockingStrikeDmg = 12;
float hlstrikingGeneralDmg = 5;
float blockCrushDmg = 25;


void setup(){
  size(500,500);
  frameRate(25);
  background(backgroundColor);
  font = loadFont("Arial-Black-48.vlw");
  
  buttons = new ArrayList();
  textPops = new ArrayList();
  
  mode1 = "back";
  mode2 = "back";
  life1 = startLife;
  life2 = startLife;
  x1 = width/3;
  x2 = width/3*2;

  buttons.add(new Button('s'));
  buttons.add(new Button('w'));
  buttons.add(new Button('a'));
  buttons.add(new Button('d'));
  buttons.add(new Button('q'));
  buttons.add(new Button('e'));
  
  buttons.add(new Button('j'));
  buttons.add(new Button('u'));
  buttons.add(new Button('h'));
  buttons.add(new Button('k'));
  buttons.add(new Button('y'));
  buttons.add(new Button('i'));
}

void draw(){
  fade();
  
  updateArrays();
  
  microFighters();
  
  // framerate
  fill(20,150,0);
  textFont(font, 10);
  text("FrameRate: " + int(frameRate),width/40,height/98*97);
}

void fade(){
  fill(backgroundColor,255);
  rect(-1,-1,width+2,height+2);
}

void updateArrays(){
  for(int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).active) ((Button) buttons.get(i)).draw(); 
  else buttons.remove(i);
  
  for(int i=0; i<textPops.size(); i++) if(((TextPop) textPops.get(i)).active) ((TextPop) textPops.get(i)).draw(); 
  else textPops.remove(i);
}

void keyPressed(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order && ((Button) buttons.get(i)).mode != "on") ((Button) buttons.get(i)).mode = "press";
}

void keyReleased(){
  for(int i=0; i<buttons.size(); i++) if(key == ((Button) buttons.get(i)).order) ((Button) buttons.get(i)).mode = "release";
}

void mousePressed(){
  textPops.add(new TextPop("459!",mouseX,mouseY,20,100,color(255,255,255),"01111110")); // popMode has 6 features in the last String value, who can be activated by typing a 1 in their place on the string.
}
