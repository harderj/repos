void debugVectArray(Vect[] array){
  for(int i=0; i<array.length; i++) array[i].debug("Array #" + i);
}

void regressionFunction2DPrint(Vect[] array){
  Vect[] arr = new Vect[array.length];
  for(int i=0; i<arr.length; i++){
    arr[i] = new Vect(2);
    arr[i].set(array[i]);
  }
  Vect regFunc = new Vect(2);
  float regressionNumber = 0;
  
  for(int i=0; i<arr.length-1; i++){
    regFunc.n[0] += arr[i].directionalFunction2D(arr[i+1], "interseptY");
    regFunc.n[1] += arr[i].directionalFunction2D(arr[i+1], "slope");
  }
  regFunc.div(arr.length-1);
  
  for(int i=0; i<arr.length; i++){
    regressionNumber += abs(arr[i].n[1] -(arr[i].n[1]*regFunc.n[1] + regFunc.n[0]));
  }
 
  println(" - - Regression(straight line) based on point-array");
  regFunc.div(arr.length);
  println("Regression Number: " + regressionNumber);
  Vect tmpA = new Vect(0, regFunc.n[0]);
  tmpA.directionalFunction2D(new Vect(1,regFunc.n[1]+regFunc.n[0]));
  for(int i=0; i<arr.length; i++) print("#" + i + "=(" + arr[i].n[0] + ", " + arr[i].n[1] + ") ");
  println();
  println("End - -");
}


Vect regressionFunction2D(Vect[] array){
  Vect[] arr = new Vect[array.length];
  for(int i=0; i<arr.length; i++){
    arr[i] = new Vect(2);
    arr[i].set(array[i]);
  }
  Vect regFunc = new Vect(2);
  float regressionNumber = 0;
  
  for(int i=0; i<arr.length-1; i++){
    regFunc.n[0] += arr[i].directionalFunction2D(arr[i+1], "interseptY");
    regFunc.n[1] += arr[i].directionalFunction2D(arr[i+1], "slope");
    println("interseptY = " + arr[i].directionalFunction2D(arr[i+1], "interseptY"));
    println("slope = " + arr[i].directionalFunction2D(arr[i+1], "slope"));
  }
  regFunc.div(arr.length);
  
  for(int i=0; i<arr.length; i++){
    regressionNumber += abs(arr[i].n[1] -(arr[i].n[1]*regFunc.n[1] + regFunc.n[0]));
  }
 
  Vect tmpA = new Vect(0, regFunc.n[0]);
  tmpA.directionalFunction2D(new Vect(1,regFunc.n[1]+regFunc.n[0]));
  
  regFunc.debug();
  return regFunc;
}
