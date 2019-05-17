ArrayList procs, buttons;
Vect2 gravity = new Vect2(.0,.3);
float drag = 0.995;

Vect2 mPos, mVel;


void setup(){
  size(800,500);

  procs = new ArrayList();
  buttons = new ArrayList();

  buttons.add(new Button('a'));
  buttons.add(new Button('d'));
  buttons.add(new Button('w'));

  mPos = new Vect2(width/2, height*0.9);
  mVel = new Vect2();
}

void draw(){
  background(0);
  updateArrays();
  updateMan();
}

void updateArrays(){
  for (int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).act) ((Button) buttons.get(i)).draw(); 
  else buttons.remove(i);

  for (int i=0; i<procs.size(); i++) if(((Proc) procs.get(i)).act) ((Proc) procs.get(i)).draw(); 
  else procs.remove(i);
}

void updateMan(){
  controlMan();
  moveMan();
  hitFrameMan();
  renderMan();
}

void controlMan(){
  char tmpFind;
  
  tmpFind = 'a';
  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      if(((Button) buttons.get(i)).pressed){
        mVel.addX(-1);
      }
    }
  }
  
  tmpFind = 'd';
  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      if(((Button) buttons.get(i)).pressed){
        mVel.addX(1);
      }
    }
  }
  
  tmpFind = 'w';
  for(int i=0; i<buttons.size(); i++){
    if(tmpFind == ((Button) buttons.get(i)).order){
      if(((Button) buttons.get(i)).pressed){
        if(mPos.y > height-15){
          mVel.addY(-4);
        }
      }
    }
  }
}

void moveMan(){
  mVel.add(gravity);
  mVel.mult(0.9);
  mPos.add(mVel);
}

void hitFrameMan(){
  if(mPos.x < 0){
    mPos.setX(width-10);
  }
  if(mPos.x > width){
    mPos.setX(10);
  } 
  if(mPos.y > height-5){
    mPos.setY(height-5);
    mVel.setY(0);
  }
}

void renderMan(){
  noStroke();
  fill(255);
  ellipse(mPos.x, mPos.y, 10, 20);
}

void mousePressed(){
  Vect2 tmpPos = new Vect2(width/2, 0);
  Vect2 tmpVel = new Vect2(cos(atan2(0-mouseY, width/2-mouseX))*-100, sin(atan2(0-mouseY, width/2-mouseX))*-100);
  procs.add(new Proc(tmpPos, tmpVel, "shot", color(255)));
}
