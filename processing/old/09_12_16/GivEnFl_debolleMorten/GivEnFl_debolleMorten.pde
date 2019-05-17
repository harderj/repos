import processing.opengl.*;

ArrayList textPops;

PFont font;

void setup(){
  size(screen.width, screen.height, OPENGL);
  smooth();
  
  textPops = new ArrayList();
  
  font = loadFont("ComicSansMS-48.vlw");
}

void draw(){
  background(0);
  textPops.add(new TextPop("GIV EN FLØDEBOLLE MORTEN", new Vect2(random(width), random(height)), random(5,20), 50, 255, "111111"));
  updateArrays();
}

void updateArrays(){
  for(int i=0; i<textPops.size(); i++) if(((TextPop) textPops.get(i)).is) ((TextPop) textPops.get(i)).draw();
  else textPops.remove(i);
}
