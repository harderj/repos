float startHeight, startWidth;
color stearin, stearinWet, robe, flame, robeWet, black;
int[][] p;

void setup(){
  size(200,500);
  smooth();
  background(0);
  rectMode(CENTER);
  //frameRate(2);

  startHeight = height*0.6;
  startWidth = width*0.2;
  p = new int[width][height];
  
  black = color(0);
  stearin = color(255);
  robe = color(100,50,0);
  flame = color(250,200,0);
  robeWet = color(100,75,75);
  stearinWet = color(200,200,200);

  noStroke();
  fill(stearinWet);
  rect(0,0,50,50);
  fill(stearin);
  rect(0,0,40,50);
  fill(robe);
  rect(0,0,30,50);
  fill(flame);
  rect(0,0,20,50);
  fill(robeWet);
  rect(0,0,10,50);

  noStroke();
  fill(255);
  rect(width*0.5, height-startHeight*0.5, startWidth, startHeight);
  
  loadPixels();
  for(int i = 0; i<width; i++){
    for(int j = 0; j<height; j++){
      if(get(i, j) == black) p[i][j] = 0;
      if(get(i, j) == stearin) p[i][j] = 1;
      if(get(i, j) == stearinWet) p[i][j] = 2;
      if(get(i, j) == robe) p[i][j] = 3;
      if(get(i, j) == robeWet) p[i][j] = 4;
      if(get(i, j) == flame) p[i][j] = 5;
    }
  }
  updatePixels();
}

void draw(){
  loadPixels();
  background(0);
  for(int i = 0; i<width; i++){
    for(int j = 0; j<height; j++){
      if(p[i][j] == 0){
        set(i, j, black);
      }
      if(p[i][j] == 1){
        set(i, j, stearin);
      }
      if(p[i][j] == 2){
        set(i, j, stearinWet);
      }
      if(p[i][j] == 3){
        set(i, j, robe);
      }
      if(p[i][j] == 4){
        set(i, j, robeWet);
      }
      if(p[i][j] == 5){
        set(i, j, flame);
      }
    }
  }
  
  
  
  println(frameRate);
  updatePixels();
}

void fall(int i, int j){
  if(j < height){
    if(p[i][j+1] == 0){
      p[i][j+1] = p[i][j];
      p[i][j] = 0;
    }
  }
}

