
void draw(){
}

double fnf(double x, double y){ 
  return -x*y;
}

double euler(double yn, double xn, double h){
  return yn+h*fnf(xn,yn);
}

void setup(){
  double y=1;
  println(euler(y, 1, 1));
}



//println(ev/h + ":"+round((float)(ev/h))+":"+n);
//double diff=exp(-.5*sq((float)(x+h)))-y;
//println(i+":"+x+":"+y+":"+diff);

