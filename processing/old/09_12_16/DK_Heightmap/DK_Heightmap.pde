PImage theMap;
PImage tmpMap;

void setup(){
  theMap = loadImage("Picture 1.png");
  tmpMap = theMap;
  size(theMap.width, theMap.height);
  background(theMap);
}

void draw(){
  //println(brightness(get(mouseX, mouseY)));
}

void keyPressed(){
  if(key == 'c'){
    drawCoastline();
  }
  if(key == 'q'){
    background(theMap);
  }
}

void drawCoastline(){
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      if(brightness(get(i, j)) == 0.0){
        for(int k=0; k<2; k++){
          for(int l=0; l<2; l++){
            if(brightness(get(abs(i+1-(k*2)), abs(j+1-(l*2)))) != 0.0 && get(abs(i+1-(k*2)), abs(j+1-(l*2))) != color(255,0,0)){
              set(i,j,color(255,0,0));
              //println(int(i-k) + " and " + int(j-l));
            }
          }
        }
      }
    }
  }
}


