float drag = 0.95;
float angularDrag = 0.99;

ArrayList astroids, buttons;

PVector offset, mouse, dmouse, midth, zero;
PVector spos, svel, sacc;
float sdirection;

void setup(){
  size(500, 500);
  ellipseMode(CENTER);
  smooth();
  
  astroids = new ArrayList();
  buttons = new ArrayList();
  
  spos = new PVector(0, 0);
  svel = new PVector(0, 0);
  sacc = new PVector(0, 0);
  mouse = new PVector(0, 0);
  dmouse = new PVector(0, 0);
  midth = new PVector(width*0.5, height*0.5);
  zero = new PVector(0, 0);
  
  addButtons("ws");
}

void draw(){
  background(0);
  translate(midth.x -spos.x, midth.y -spos.y);
  basicValues();
  updateSelf();
  updateArrays();
}

void basicValues(){
  mouse.set(mouseX -midth.x, mouseY -midth.y, 0);
  dmouse.set(mouseX -pmouseX, pmouseY -pmouseX, 0);
  sdirection = atan2(mouse.y, mouse.x);
}

void updateArrays(){
  for(int i=0; i<astroids.size(); i++) if(((Astroid) astroids.get(i)).is) ((Astroid) astroids.get(i)).update(); else astroids.remove(i);
  for(int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).is) ((Button) buttons.get(i)).update(); else buttons.remove(i);
}

void updateSelf(){
  if(getButtonBinary('w')) sacc.add(cos(sdirection), sin(sdirection), 0);
  
  svel.add(sacc);
  svel.mult(drag);
  spos.add(svel);
  sacc.mult(0);
  
  renderSelf();
}

void renderSelf(){
  fill(255);
  noStroke();
  ellipse(spos.x, spos.y, 20, 20);
  stroke(255);
  strokeWeight(5);
  line(spos.x, spos.y, spos.x +cos(sdirection)*20, spos.y +sin(sdirection)*20);
}

void mousePressed(){
  astroids.add(new Astroid(new PVector(mouse.x, mouse.y), new PVector(mouseX -pmouseX, mouseY -pmouseY), 20));
}
