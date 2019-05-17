int w = 500;
int h = 500;
int num = 50;
boolean noLerp = false;
boolean hsbMode = false;
float factor = 10;
color[][] globalColor = new color[w][h];

Vect2[] position = new Vect2[num];
color[] colour = new color[num];

void setup(){
  size(w, h);
  background(0);
  noCursor();
  smooth();
  if(hsbMode){
    colorMode(HSB);
  }
}

void draw(){
  for(int i=0; i<w; i++){
    for(int j=0; j<h; j++){
      set(i,j,globalColor[i][j]);
    }
  }
  fill(0);
  stroke(255);
  ellipse(mouseX,mouseY,2,2);
}

void keyPressed(){
  if(key == 'a'){
    factor *= 1.25;
    remap(false);
  }
  if(key == 's'){
    factor /= 1.25;
    remap(false);
  }

  println("factor: " + factor);
}

void mousePressed(){
  println(frameRate);
  remap(true);
}

void remap(boolean rePos){
  if(rePos){
    for(int i=0; i<num; i++){
      position[i] = new Vect2(random(width), random(height));
      colour[i] = color(random(255), random(255), random(255));
    }
  }

  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      color tmpCol = color(0);
      float tmpMax = 0;
      float tmpRed = 0;
      float tmpGre = 0;
      float tmpBlu = 0;
      float[] tmpPro = new float[num];

      for(int k=0; k<num; k++) tmpMax += pow(1/(dist(i, j, position[k].x, position[k].y)),factor);
      for(int k=0; k<num; k++) tmpPro[k] = (pow(1/(dist(i, j, position[k].x, position[k].y)),factor))/tmpMax;

      if(!noLerp){
        for(int k=0; k<num; k++){
          if(!hsbMode){
            tmpRed += tmpPro[k]*red(colour[k]);
            tmpGre += tmpPro[k]*green(colour[k]);
            tmpBlu += tmpPro[k]*blue(colour[k]);
          } 
          else {
            tmpRed += tmpPro[k]*hue(colour[k]);
            tmpGre += tmpPro[k]*saturation(colour[k]);
            tmpBlu += tmpPro[k]*brightness(colour[k]);
          }
        }
      } 
      else {
        float tmpWin = max(tmpPro);
        for(int k=0; k<num; k++){
          if(tmpWin == tmpPro[k]){
            if(!hsbMode){
              tmpRed = red(colour[k]);
              tmpGre = green(colour[k]);
              tmpBlu = blue(colour[k]);
            } 
            else {
              tmpRed = hue(colour[k]);
              tmpGre = saturation(colour[k]);
              tmpBlu = brightness(colour[k]);
            }
          }
        }
      }

      tmpCol = color(tmpRed, tmpGre, tmpBlu);
      globalColor[i][j] = color(tmpCol);
    }
  }
}
