/*
Keeps a float value within an interval, by recounting from minimum and maximum
 */

void setup(){
  println(inbound(-10,0,100));
}

void draw(){

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





/*
  if(value>maximum){
 value -= minimum;
 maximum -= minimum;
 
 value = value%maximum;
 
 value += minimum;
 }
 */

