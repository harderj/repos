

void setup(){
  ellipseMode(CENTER);
}

void draw(){
  background(0);
  fill(255);
  noStroke();
  ellipse(inbound(mouseX, 50, 150)-50, inbound(mouseY, 50, 150)-50, 20, 20);
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
