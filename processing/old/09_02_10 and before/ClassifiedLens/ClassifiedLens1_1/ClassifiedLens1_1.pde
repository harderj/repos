import processing.opengl.*;

ArrayList lenses;

PGraphics lensEffect;

void setup() {

  size(640, 360, OPENGL);
  
  
  // Create buffered image for lens effect
  lensEffect = createGraphics(width, height, P2D);

  // Load background image 
  lensEffect.beginDraw();
  lensEffect.image(loadImage("red_smoke.jpg"), 0, 0, lensEffect.width, lensEffect.height);
  lensEffect.endDraw();
  
  lenses = new ArrayList();
  
  lenses.add(new LensEffect(100));
  
  lenses.add(new LensEffect(10));
}

void draw() {
  
  // Restore the original picture
  image(lensEffect, 0, 0, width, height);
  
  updateArrayLists();
}

void updateArrayLists(){
  for(int i=0; i<lenses.size(); i++) if(((LensEffect) lenses.get(i)).is) ((LensEffect) lenses.get(i)).draw();
  else remove(i);
}

