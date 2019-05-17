void regressionFunction2D(Vect[] array){
  Vect deltaArray = new Vect(2);
  float regressionNumber = 0;
  
  for(int i=0; i<array.length-1; i++){
    deltaArray.add(array[i+1]);
    deltaArray.sub(array[i]);
  }
  
  /*
  for(int i=0; i<array.length; i++){
    regressionNumber += abs(array[i].n[1] -(array.directionalFunction2D(array[i], "slope") ))
  }
  */
  
  deltaArray.div(array.length);
  println("Delta Array: (" + deltaArray.n[0] + ", " + deltaArray.n[1] + ")");
  
  
  
  deltaArray.directionalFunction2D(new Vect(0,0));
}
