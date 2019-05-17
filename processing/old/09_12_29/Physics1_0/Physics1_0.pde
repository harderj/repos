ArrayList particles, forces;
int idNext;
int idTarget;

void setup(){
  size(300,300);
  frameRate(20);
  smooth();

  ellipseMode(CENTER);

  particles = new ArrayList();
  forces = new ArrayList();

  idNext = 0;
  idTarget = -1;

  for(int i=0; i<30; i++){
    Vect2 tmpPos = new Vect2(random(width*0.25, width*0.75), random(height*0.25, height*0.75));
    particles.add(idNext, new Particle(idNext,tmpPos));
  }

  Vect2 tmpGravity = new Vect2(0, 2);
  forces.add(new Force(tmpGravity));

  forces.add(new Force("mouseBound", 0));

  for(int i=0; i<20; i++){
    forces.add(new Force(i, i+1, (int) random(10,20)));
  }
}

void draw(){
  background(0);
  updAL();
}

void updAL(){
  for(int i=0; i<forces.size(); i++){
    ((Force) forces.get(i)).upd();
    ((Force) forces.get(i)).display();
  }

  for(int i=0; i<particles.size(); i++){
    ((Particle) particles.get(i)).upd();
    ((Particle) particles.get(i)).display();
  }
}

void mousePressed(){
  for(int i=0; i<particles.size(); i++){
    Vect2 tmpPos = new Vect2(((Particle) particles.get(i)).pos);
    if(dist(mouseX, mouseY, tmpPos.x, tmpPos.y)<10){
      if(idTarget == -1){
        idTarget = i;
      } 
      else {
        if(idTarget != i && searchString("mouseBound" , ((Particle) particles.get(i)).classification)){
          forces.add(new Force("mouseBound", idTarget));
        } 
        else {
          idTarget = 0;
        }
      }
    }
  }
}

boolean searchString(String searchFor, String searchIn){
  boolean searchHit = false;
  if(searchFor.length()<searchIn.length()){
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++){
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)){
        searchHit = true;
      }
    }
  }
  return searchHit;
}

