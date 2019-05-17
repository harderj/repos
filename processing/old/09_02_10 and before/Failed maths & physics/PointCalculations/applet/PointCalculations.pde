void setup(){
  Vect A = new Vect(1,2);
  Vect B = new Vect(3,4);
  int arraySize = 10;
  Vect[] vectArray = new Vect[arraySize];
  
  for(int i=0; i<arraySize; i++){
    vectArray[i] = new Vect(2);
    vectArray[i].n[0] = i*10+random(-10,10);
    vectArray[i].n[1] = i*10+random(-10,10);
    
    
  }
  
  A.directionalFunction2D(B);
  regressionFunction2D(vectArray);
}

void draw(){

}
