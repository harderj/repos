int globalWidth = 500;
int globalHeight = 500;
float globalScale = 100;
float globalStrokeWeight = (globalWidth+globalHeight)/200;
Vect[] vectArray;

void setup(){
  size(globalWidth, globalHeight);
  strokeWeight(globalStrokeWeight);
  
  int arraySize = 100;
  vectArray = new Vect[arraySize];
  
  reArrange();
  
  //regressionFunction2D(vectArray);
}

void reArrange(){
  for(int i=0; i<vectArray.length; i++){
    vectArray[i] = new Vect(2);
    vectArray[i].n[0] = i+random(-0.4,0.4);
    vectArray[i].n[1] = i+random(-0.4,0.4);
  }
  
  Vect testFunc = new Vect(2);
  testFunc = regressionFunction2D(vectArray);
  visualize(testFunc);
}

void draw(){
  
}

void keyPressed(){
  if(key == 'x') background(0);
  if(key == 'a'){
    visualize(vectArray);
    reArrange();
  }
}

void visualize(Vect[] array){
  stroke(random(255),random(255),random(255),150);
  strokeWeight(globalStrokeWeight);
  for(int i=0; i<array.length; i++){
    Vect tmp = new Vect(array[i].n[0], array[i].n[1]);
    tmp.div(globalScale);
    point(tmp.n[0]*width, height-tmp.n[1]*height);
  }
}

void visualize(Vect func){
  stroke(random(255),random(255),random(255),150);
  strokeWeight(globalStrokeWeight);
  Vect tmp = new Vect(func);
  //tmp.div(globalScale);
  line(0, height-tmp.n[0], width, height-width*tmp.n[1]+tmp.n[0]);
}

