int num = 20;

float a = 1;

void setup(){

  for(int i=0; i<num; i++){
    
    
    println(a);

    a = a - (funcA(a)/funcB(a));
    

  }
  
}

float funcA(float x){
  return ((1/(x+1))-(sqrt(x)));
}

float funcB(float x){
  return -(1/((x+1)*(x+1)))-(1/(2*(sqrt(x))));
}

