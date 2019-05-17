ArrayList buttons;

void setup(){
  frameRate(5);
  smooth();
  
  buttons = new ArrayList();
  
  buttons.add(new Button('a'));
}

void draw(){
  background(0);
  
  for(int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).is) ((Button) buttons.get(i)).draw();
  else buttons.remove(i);
  
  noFill();
  strokeWeight(5);
  if(getButtonState('a') == "press") fill(0,255,0);
  if(getButtonState('a') == "on") fill(100);
  if(getButtonState('a') == "release") fill(255,0,0);
  if(getButtonBinary('a')) stroke(255); 
  else{ 
    noStroke();
  }
  ellipse(50,50,50,50);
  
}

