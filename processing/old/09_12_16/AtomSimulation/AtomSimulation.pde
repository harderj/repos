import processing.opengl.*;

ArrayList atoms;

PVector gravity;
float drag;

void setup(){
  size(500,500,OPENGL);
  smooth();
  ellipseMode(CENTER);
  atoms = new ArrayList();

  gravity = new PVector(0, 1);
  drag = 0.99;
}

void draw(){
  background(255);
  updateArrays();
}

void updateArrays(){
  for(int i=0; i<atoms.size(); i++) if(((Atom) atoms.get(i)).is) ((Atom) atoms.get(i)).update(i);
  else atoms.remove(i);
}

void mousePressed(){
  atoms.add(new Atom(new PVector(mouseX, mouseY), new PVector(mouseX-pmouseX, mouseY-pmouseY)));
}

void keyPressed(){
  if(key == 'e'){
    float tmp = 0;
    for(int i=0; i<atoms.size(); i++) tmp += ((Atom) atoms.get(i)).vel.mag();
    println(tmp);
  }
}

