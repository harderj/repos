//du fatter intet

PFont font;


void setup(){
  size(500,500);
  font = loadFont("Times-Roman-48.vlw");
}

void draw(){
background(0);
  fill(random(255), random(255), random(255));
  textFont(font, 30);
  text("<h1>GIR DU EN FLØDEBOLLE til he?!", 50, height*0.5);
}
