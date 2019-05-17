ArrayList forces;

void setup(){
  size(300,300);
  frameRate(20);
  smooth();

  ellipseMode(CENTER);

  forces = new ArrayList();
  
  Particle par1 = new Particle();
  Particle par2 = new Particle();
  Particle par3 = new Particle();

  forces.add(new Force(new Vect2(0,1)));

  forces.add(new Force("mouseBound", par1));
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
}

void mousePressed(){
  /*
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
  */
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

