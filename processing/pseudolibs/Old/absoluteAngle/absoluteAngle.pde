

void setup(){
  println("Radians: " + (absoluteAngle(14092)));
  println("Degrees: " + (degrees(absoluteAngle(14092))));
}

void draw(){
  
}

float absoluteAngle(float a){
  a = inbound(a + TWO_PI,0, TWO_PI);
  
  return a;
}

float inbound(float value, float minimum, float maximum){

  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}
