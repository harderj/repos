import processing.opengl.*;

PFont font;

void setup(){
  size(1000,500,OPENGL);
  background(0);
  smooth();
  makeTerrain();
  
  font = loadFont("Arial-BoldMT-48.vlw");
  textFont(font, 20);
}

void draw(){
  
  println(frameRate);
  //makeTerrain();
  //updateScreen();
  if(mousePressed){
    set(mouseX, mouseY, color(0));
  }
}

void updateScreen(){
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      if(get(i, j) == color(0,255,0) && j != height){
        if(get(i,j+1) == color(0)){
          set(i,j, color(0));
          set(i,j+1, color(0,255,0));
        }
      }
    }
  }
}

void makeTerrain(){
  for(int i=0; i<width; i++){
    for(int j=0; j<int(noise(float(i)*0.01)*height*0.4); j++){
      set(i,height-j, color(0,255,0));
    }
  }
}
