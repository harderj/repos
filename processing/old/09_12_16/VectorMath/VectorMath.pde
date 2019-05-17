float globalScale = 10;

PVector zero, midth;

PVector a = directionConstructor(1, 4);

PVector b = directionConstructor(TWO_PI*0.25, 4);

PFont font;

void setup(){
  size(500,500);
  smooth();
  strokeWeight(2);
  zero = new PVector(0,0);
  midth = new PVector(width*0.5, height*0.5);
  
  font = loadFont("Courier-48.vlw");
}

void draw(){
  background(255);
  
  if(mousePressed){
    a.set((mouseX/globalScale) - midth.x/globalScale, (mouseY/globalScale) - midth.y/globalScale, 0);
  }
  
  displayVector(a, midth, "a");
  displayVector(b, midth, "b");
  
  textFont(font, 12);
  fill(0,100,0);
  text("a.x: " + int(a.x), 10, 15);
  text("a.y: " + int(a.y), 10, 30);
  text("b.x: " + int(b.x), 10, 45);
  text("b.y: " + int(b.y), 10, 60);
  text("a.dot.b: " + int(a.dot(b)), 10, 75);
}

PVector directionConstructor(float direction, float magnitude){
  return new PVector(cos(direction)*magnitude, sin(direction)*magnitude);
}

void printVector(PVector vector){
  println("x: " + vector.x);
  println("y: " + vector.y);
  println("mag: " + vector.mag());
}

void displayVector(PVector vector, PVector offset, String name){
  float arrowLength = 0.1;
  float arrowAngle = TWO_PI*0.1;
  stroke(0);
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.mult(globalScale);
  PVector tmpL = new PVector(tmp.x, tmp.y);
  PVector tmpR = new PVector(tmp.x, tmp.y);
  tmpL.mult(arrowLength);
  tmpR.mult(arrowLength);
  tmpL.add(tmp);
  tmpR.add(tmp);
  tmp.add(offset);
  tmpL.add(offset);
  tmpR.add(offset);
  tmpL.set(rotateAround(tmpL, tmp, arrowAngle + PI));
  tmpR.set(rotateAround(tmpR, tmp, -arrowAngle + PI));
  
  line(offset.x, offset.y, tmp.x, tmp.y);
  line(tmp.x, tmp.y, tmpL.x, tmpL.y);
  line(tmp.x, tmp.y, tmpR.x, tmpR.y);
}

PVector rotateAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  float tmpAngle = atan2(tmp.y, tmp.x);
  tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude, 0);
  
  return tmp;
}

PVector setRotationAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude, 0);
  
  return tmp;
}
