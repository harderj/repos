void setup(){
  float a = -2.0;
  float b = 3.0;
  float c = 2.01;

  println(valueType(a, 'z'));
  println(valueType(a, 'e'));
  println(valueType(a, 'o'));

  println(valueType(b, 'z'));
  println(valueType(b, 'e'));
  println(valueType(b, 'o'));
  
  println(valueType(c, 'z'));
  println(valueType(c, 'e'));
  println(valueType(c, 'o'));
}

boolean valueType(float value, char type){
  boolean reflection = false;
  switch(type){
  case 'z':
    if(round(value) == value) reflection = true;
    break;

  case 'e':
    if(round(value*0.5) == value*0.5) reflection = true;
    break;

  case 'o':
    if(round((value-1)*0.5) == (value-1)*0.5) reflection = true;
    break;
  }
  
  return reflection;
}
