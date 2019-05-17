size(500,500);
background(255);
smooth();

PVector p1 = new PVector(width*0.25, height*0.5);
PVector p2 = new PVector(width*0.75, height*0.5);

float lambda = 0.2;

for(int i=0; i<width; i++){
  for(int j=0; j<height; j++){
    set(i, j, color(255-125*(sin(dist(i, j, p1.x, p1.y)*lambda) + sin(dist(i, j, p2.x, p2.y)*lambda))));
    //if(get(i, j) == color(0)) set(i, j, color(0,255,0));
  }
}

strokeWeight(10);
stroke(255, 0, 0);

point(p1.x, p1.y);
point(p2.x, p2.y);

/*
set((int)p1.x, (int)p1.y, color(255,0,0));
set((int)p2.x, (int)p2.y, color(255,0,0));
*/
