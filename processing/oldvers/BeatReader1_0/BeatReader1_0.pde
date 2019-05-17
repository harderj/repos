int instrumentCount = 3;
int tempo = 5;
int beatTimer = 0;

String[] beatRoll = new String[instrumentCount];

int[] place = new int[instrumentCount];

void setup(){
  size(screen.width,instrumentCount*100+50);
  frameRate(30);
  smooth();

  for(int i=0; i<instrumentCount; i++){
    place[i] = 0;
  }

  beatRoll[0] = "X X X X X X X X X X X X X X X X ";
  beatRoll[1] = "    X       X       X       X   ";
  beatRoll[2] = "XX     X  X     XX              ";
}

void draw(){
  noStroke();
  fill(0,0,0,tempo/frameRate*255);
  rect(-1,-1,width,height);
  
  if(beatTimer == tempo){
    for(int i=0; i<instrumentCount; i++){
      if(beatRoll[i].charAt(place[i]) == 'X'){
        noStroke();
        fill(255, 0, 0);
        ellipse(50, 50 + i*100, 25, 25);
      }

      place[i] ++;

      if(place[i] > beatRoll[i].length()-1){
        place[i] = 0;
      }

      beatTimer = -1;
    }
  }

  beatTimer ++;

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
