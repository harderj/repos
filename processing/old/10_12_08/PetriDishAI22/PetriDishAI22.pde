
float BEING_RADIUS = 10;
float BEING_LEGS_ANGLE = PI*1.50;
float BEING_SENS_ANGLE = PI*0.30;
float BEING_SENS_FACTOR = 0.01;
float BEING_SENS_RADIUS_FACTOR = 0.3;
float BEING_SPEED = 0.2;
float BEING_ROTATIONAL_SPEED = 0.01;
float FOOD_RADIUS = 5;
float DRAG = 0.99;
int GRID_NUM = 30;
int MEMORYVIZ_DEFINITION = 500;

boolean translating = false;
boolean frameRating = true;
boolean lightmapping = false;
boolean gridding = false;
boolean memoryVizing = true;

Point2 MIDTH;
PFont FONT;

float stableFrameRate;

Being ani; // I call my first being "ani"
Point2 f1; // .. and ani's first meal 'fi'

void setup(){
  size(500,500);
  //smooth();
  //rectMode(CENTER);
  ellipseMode(CENTER);

  MIDTH = new Point2(width*0.5, height*0.5);
  FONT = loadFont("Serif-48.vlw");

  f1 = randomPoint2Screen();
  ani = new Being(MIDTH);
  ani.b.m = BEING_RADIUS;

  startingPrints();
}

void startingPrints(){
  println("COMMANDS");
  println("'i': prints sensor info");
  println("'g': turns gridding on/off");
  println("'l': turns lightmapping on/off");
  println("'f': turns frameRating on/off");
  println("'m': turns on/off the memory visualisation");
  println("'q': use ani's first leg");
  println("'w': use ani's second leg");
  println("'t': turns translate on/off");
}

void draw(){
  background(0);
  if(frameRating) displayFrameRate();
  if(gridding || lightmapping) grid();
  if(translating) translate(-ani.b.p.x+width*0.5, -ani.b.p.y+height*0.5);
  renderFood();
  ani.update();
  if(memoryVizing) memoryViz();
}

void memoryViz(){
  fadeScreen();

  float memoryScale = (float)ani.memory.size()/(float)MEMORYVIZ_DEFINITION;

  float xOffset = width*0.1;
  float yOffset = height*0.2;
  float xScale = (width-xOffset*2)/MEMORYVIZ_DEFINITION;
  float yScale = height*0.1;

  stroke(255,200);
  strokeWeight(xScale*1.26);
  rect(xOffset, yOffset-yScale, (width-xOffset*2), yScale);

  for(int i=0; i<MEMORYVIZ_DEFINITION; i++){
    int memoryPlace = int((float)i*memoryScale);
    Memo m = ((Memo) ani.memory.get(memoryPlace));
    
    if(m.s1>m.s2){
      strokeWeight(xScale*1.25);
      stroke(255,0,0);
      line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yOffset-m.s1*yScale);
      strokeWeight(xScale*2);
      stroke(255,255,0);
      line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yOffset-m.s2*yScale);
    }
    else {
      strokeWeight(xScale*1.25);
      stroke(0,255,0);
      line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yOffset-m.s2*yScale);
      strokeWeight(xScale*2);
      stroke(255,255,0);
      line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yOffset-m.s1*yScale);
    }
    /*
    strokeWeight(2);
    stroke(255,0,0);
    if(m.m1) line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yScale);
    stroke(0,255,0);
    if(m.m2) line(xOffset + float(i)*xScale, yOffset, xOffset + float(i)*xScale, yScale);
    */
  }

}

void fadeScreen(){
  noStroke();
  fill(0,175);
  //rect(width*0.5,height*0.5,width,height); // if rectMode == CENTER
  rect(0,0,width,height); // if rectMode == CORNER
}

void displayFrameRate(){
  float stableness = 2;
  if(abs(stableFrameRate-frameRate) > stableness) stableFrameRate = frameRate;
  fill(0,255,0);
  textFont(FONT, 15);
  text("FrameRate: " + stableFrameRate, width*0.70, height*0.99);
}

void grid(){ // only works with square displays
  float scaling = width/float(GRID_NUM);
  for(int i=0; i<GRID_NUM; i++){
    for(int j=0; j<GRID_NUM; j++){
      float tmpX = float(i)*scaling+scaling*0.5;
      float tmpY = float(j)*scaling+scaling*0.5;

      if(lightmapping){
        Point2 tmpP;
        if(!translating) tmpP = new Point2(tmpX, tmpY);
        else tmpP = new Point2(tmpX - (-ani.b.p.x+width*0.5), tmpY - (-ani.b.p.y+height*0.5));
        fill(0,0,255*calcSens(tmpP),200);
      } 
      else {
        noFill();
      }

      if(gridding){
        stroke(255,200);
      } 
      else {
        noStroke();
      }

      strokeWeight(0.2);
      rect(tmpX, tmpY, scaling, scaling);
      strokeWeight(1);
    }
  }
}

void renderFood(){
  noStroke();
  fill(0,255,0,200);
  ellipse(f1.x, f1.y, FOOD_RADIUS*2, FOOD_RADIUS*2);
}

void keyPressed(){
  if(key == 'i'){ // prints ani's sensors current data
    println( "One: " + ((Memo) ani.memory.get(ani.memory.size()-1)).s1 );
    println( "Two: " + ((Memo) ani.memory.get(ani.memory.size()-1)).s2 );
  }

  if(key == 'l'){ // turns on/off light mapping
    if(lightmapping) lightmapping = false;
    else lightmapping = true;
  }

  if(key == 'g'){ // turns on/off grid
    if(gridding) gridding = false;
    else gridding = true;
  }

  if(key == 'f'){ // turns on/off frameRating
    if(frameRating) frameRating = false;
    else frameRating = true;
  }

  if(key == 'm'){ // prints ani's memory info
    if(memoryVizing){
      memoryVizing = false;
    }
    else {
      memoryVizing = true;
    }
  }

  if(key == 'q'){ // uses ani's first leg
    ani.useLeg(true);
  }

  if(key == 'w'){ // uses ani's second leg
    ani.useLeg(false);
  }

  if(key == 't'){ // turns on/off frameRating
    if(translating) translating = false;
    else translating = true;
  }
}


