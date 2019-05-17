import processing.opengl.*;

ArrayList lenses;

PGraphics ground;

void setup() {

  size(640, 360, OPENGL);
  
  
  // Create buffered image for lens effect
  ground = createGraphics(width, height, P2D);

  // Load background image 
  ground.beginDraw();
  ground.image(loadImage("red_smoke.jpg"), 0, 0, ground.width, ground.height);
  ground.endDraw();
  
  lenses = new ArrayList();
  
  lenses.add(new LensEffect(100));
  
  lenses.add(new LensEffect(10));
}

void draw() {
  
  // Restore the original picture
  image(ground, 0, 0, width, height);
  
  updateArrayLists();
}

void updateArrayLists(){
  for(int i=0; i<lenses.size(); i++) if(((LensEffect) lenses.get(i)).is) ((LensEffect) lenses.get(i)).draw();
  else remove(i);
}

