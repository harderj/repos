/*
// create a new instance of etude
 
 ...
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

import jmetude.*;

int num;

Etude[] e;

void setup(){
  size(200,200);

  num = 2;

  e = new Etude[num];

  for(int i=0; i<num; i++){
    e[i] = new Etude(this);
  }

  float[][] notes = {
    {
      e[0].C5,e[0].Q    }
    , {
      e[0].D5,e[0].Q    }
    , {
      e[0].E5, e[0].Q    }
  };

  e[0].createPhrase("Phrase #" + 1, notes);
  e[0].setPhraseInstrument("Phrase #" + 1, e[0].SYNTH_BASS);
}

void draw(){
  background(0);
}

void mousePressed(){
  if(mouseButton == LEFT){
    e[0].playMIDI("Phrase #1");
  } 
  else {
    e[0].stopMIDI();
  }
}


