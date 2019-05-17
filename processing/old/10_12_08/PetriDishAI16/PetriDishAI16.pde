
Point2 MIDTH;
float BEING_RADIUS = 10;
float BEING_SENS_ANGLE = PI*0.25;
float BEING_SENS_FACTOR = 0.01;
float FOOD_RADIUS = 5;
float DRAG = 0.99;
int GRID_NUM = 50;

boolean lightmapping = true;
boolean gridding = true;

Being ani;
Point2 f1;

void setup(){
  size(500,500);
  smooth();
  rectMode(CENTER);
  ellipseMode(CENTER);

  MIDTH = new Point2(width*0.5, height*0.5);
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
}

void draw(){
  background(0);
  if(gridding || lightmapping) grid();
  ani.update();
  renderFood();
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
}

