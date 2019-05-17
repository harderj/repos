import ce.audio.*;

PFont font;

int instrumentCount = 3;
int tempo = 1;
int now = 0;

Player[] player;
String[] beatRoll = new String[instrumentCount];
int[] place = new int[instrumentCount];

void setup(){
  size(screen.width,instrumentCount*100+50);
  frameRate(20);
  smooth();
  Audio.start( this );
  font = loadFont( "Courier-48.vlw" );

  player = new Player[instrumentCount];

  player[0] = Audio.newPlayer( "Tink.aiff" );
  player[1] = Audio.newPlayer( "Pop.aiff" );
  player[2] = Audio.newPlayer( "RScan14.aif" );

  beatRoll[0] = "X   X   X   X   X   X   X   X   X   X   X   X   X   X   X   X   ";
  beatRoll[1] = "        X               X               X               X       ";
  beatRoll[2] = "X X           X     X           X X                             ";
}

void draw(){
  noStroke();
  fill(0,0,0,tempo/frameRate*255);
  rect(-1,-1,width,height);
  
  fill(0);
  rect(15, height - 5, width - 10, 5);
  fill(0,255,100);
  textFont(font, 20);
  text("frameRate: " + frameRate, 10, height - 10);

  if(now == tempo){
    for(int i=0; i<instrumentCount; i++){
      if(beatRoll[i].charAt(place[i]) == 'X'){
        noStroke();
        fill(255, 0, 0);
        ellipse(50, 50 + i*100, 25, 25);
        
        player[i].play();
      }

      place[i] ++;

      if(place[i] > beatRoll[i].length()-1){
        place[i] = 0;
      }

      now = -1;
    }
  }

  now ++;

  for(int i=0; i<instrumentCount; i++){
    noFill();
    stroke(255);
    ellipse(50, 50 + i*100, 25, 25);

    for(int j=0; j<beatRoll[i].length(); j++){
      if(beatRoll[i].charAt(j) == 'X'){
        noStroke();
        fill(255, 0, 0);
        ellipse(100 + 20*j, 50 + i*100, 10, 10);
      }
      
      if(inbound(place[i]-1, 0, beatRoll[i].length()) == j) strokeWeight(5);
      noFill();
      stroke(255);
      ellipse(100 + 20*j, 50 + i*100, 10, 10);
      strokeWeight(1);
    }
  }
}

float inbound(float value, float minimum, float maximum){

  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}
