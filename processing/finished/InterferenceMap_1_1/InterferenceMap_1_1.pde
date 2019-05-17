import processing.opengl.*;

PVector p1 = new PVector(width*0.25, height*0.5);
PVector p2 = new PVector(width*0.75, height*0.5);

float lambda = 0.2;

void setup(){
  //size(500,500,OPENGL);
  size(200,200);
  background(255);
  smooth();

  //reDraw();
}

void draw(){
  reDraw();
  if(mousePressed){
    if(dist(p1.x, p1.y, mouseX, mouseY) < dist(p2.x, p2.y, mouseX, mouseY)){
      p1.x = mouseX;
      p1.y = mouseY;
    }
    else {
      p2.x = mouseX;
      p2.y = mouseY;
    }

    strokeWeight(10);
    stroke(255, 0, 0);

    point(p1.x, p1.y);
    
    stroke(0,255,0);
    point(p2.x, p2.y);
  }
}

void keyPressed(){
  if(key == 'a'){
    lambda *= 1.1;
  }
  if(key == 's'){
    lambda /= 1.1;
  }
  if(key == 'r'){
    reDraw();
  }
  
  if(key == 't'){
    p1.y -= 1;
  }
  if(key == 'g'){
    p1.y += 1;
  }
  if(key == 'f'){
    p1.x -= 1;
  }
  if(key == 'h'){
    p1.x += 1;
  }
  
  
  if(key=='p') saveFrame();
}

void reDraw(){
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      set(i, j, color(255-125*(sin(dist(i, j, p1.x, p1.y)*lambda) + sin(dist(i, j, p2.x, p2.y)*lambda))));
      //if(get(i, j) == color(0)) set(i, j, color(0,255,0));
    }
  }


  strokeWeight(10);
  stroke(255, 0, 0);

  point(p1.x, p1.y);
  
  stroke(0,255,0);
  point(p2.x, p2.y);
}

/*
set((int)p1.x, (int)p1.y, color(255,0,0));
 set((int)p2.x, (int)p2.y, color(255,0,0));
 */



