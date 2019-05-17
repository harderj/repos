
float BEING_RADIUS = 10;
float BEING_LEGS_ANGLE = PI*1.50;
float BEING_SENS_ANGLE = PI*0.30;
float BEING_SENS_FACTOR = 0.01;
float BEING_SENS_RADIUS_FACTOR = 0.3;
float FOOD_RADIUS = 5;
float DRAG = 0.99;
int GRID_NUM = 50;

boolean frameRating = true;
boolean lightmapping = false;
boolean gridding = false;

Point2 MIDTH;
PFont FONT;

float stableFrameRate;

Being ani;
Point2 f1;

void setup(){
  size(500,500);
  smooth();
  rectMode(CENTER);
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
  println("'i': prints the sensor info");
  println("'g': turns gridding on/off");
  println("'l': turns lightmapping on/off");
  println("'f': turns frameRating on/off");
}

void draw(){
  background(0);
  displayings();
  ani.update();
  renderFood();
}

void displayings(){
  if(gridding || lightmapping) grid();
  if(frameRating) displayFrameRate();
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
        Point2 tmpP = new Point2(tmpX, tmpY);
        fill(0,0,255*calcSens(tmpP),200);
      } else {
        noFill();
      }
      
      if(gridding){
        stroke(255,200);
      } else {
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
}

