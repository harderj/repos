float globalScale = 2;
float bindingLimit = 2;
float speedBace = 0.3;
float speedSizeFactor = 0.5;

ArrayList drops;

void setup(){
  size(300, 500);
  ellipseMode(CENTER);
  
  bindingLimit *= globalScale;
  speedBace *= globalScale;
  speedSizeFactor *= globalScale;
  
  drops = new ArrayList();
}

void draw(){
  background(0);
  arrays();
  
  drops.add(new Drop(random(width), random(height), random(4)));
}

void arrays(){
  for(int i=0; i<drops.size(); i++) if(((Drop) drops.get(i)).is) ((Drop) drops.get(i)).draw();
  else drops.remove(i);
}
