import jmetude.*;

Etude[] e;

/*
// create a new score with the title 'bluebossa'
 e.createScore("bluebossa");
 
 // create a new part with the title "melody"
 e.createPart("melody");
 ...
 // create a new phrase with the title "intro_melody";
 e.createPhrase("intro_melody");
 ...
 // add a phrase to a part
 e.addPhrasePart("melody", "intro_melody");
 ...
 //add a part to a score
 e.addScorePart("bluebossa", "melody");
 */



int instrumentCount = 3;
int tempo = 4;
int now = 0;

String[] beatRoll = new String[instrumentCount];

int[] place = new int[instrumentCount];

void setup(){
  size(screen.width,instrumentCount*100+50);
  frameRate(20);
  smooth();

  e = new Etude[instrumentCount];

  for(int i=0; i<instrumentCount; i++){
    place[i] = 0;

    e[i] = new Etude(this);

    float[][] notes = {
      {
        i*5+10,0.1            }
    }; 
    e[i].createPhrase("phrase_" + i, notes);
    e[i].setPhraseInstrument("phrase_" + i, e[i].SYNTH_DRUMS);
    e[i].transpose("phrase_" + i, 12);
  }

  beatRoll[0] = "X X X X X X X X X X X X X X X X ";
  beatRoll[1] = "    X       X       X       X   ";
  beatRoll[2] = "XX     X  X     XX              ";
}

void draw(){
  noStroke();
  fill(0,0,0,tempo/frameRate*255);
  rect(-1,-1,width,height);

  if(now == tempo){
    for(int i=0; i<instrumentCount; i++){
      if(beatRoll[i].charAt(place[i]) == 'X'){
        noStroke();
        fill(255, 0, 0);
        ellipse(50, 50 + i*100, 25, 25);

        //e[i].stopMIDI();
        e[i].playMIDI("phrase_" + i);
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

      if(place[i] == j) strokeWeight(5);
      noFill();
      stroke(255);
      ellipse(100 + 20*j, 50 + i*100, 10, 10);
      strokeWeight(1);
    }
  }
}
