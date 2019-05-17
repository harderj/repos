float globalScale = 100;
Vect[] vectArray;

void setup(){
  size(500,500);
  strokeWeight((width+height)/200);
  
  int arraySize = 10;
  vectArray = new Vect[arraySize];
  for(int i=0; i<arraySize; i++){
    vectArray[i] = new Vect(2);
    vectArray[i].n[0] = i+random(-1,1);
    vectArray[i].n[1] = i+random(-1,1);
  }
  regressionFunction2D(vectArray);
}

void draw(){
  
}

void keyPressed(){
  if(key == 'x') background(0);
  if(key == 'a'){
    visualize(vectArray);
    debugVectArray(vectArray);
  }
}

void visualize(Vect[] array){
  color col = color(random(255),random(255),random(255),150);
  for(int i=0; i<array.length; i++){
    Vect tmp = array[i];
    tmp.div(globalScale);
    stroke(col);
    point(tmp.n[0]*width, height-tmp.n[1]*height);
  }
}



