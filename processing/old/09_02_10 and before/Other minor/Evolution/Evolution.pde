ArrayList cells;

void setup(){
  size(300,300);
  
  cells = new ArrayList();
}

void draw(){
  updateArrays();
}

void updateArrays(){
  for(int i = 0; i<cells.size(); i++) if(((Cell) cells.get(i)).is) ((Cell) cells.get(i)).draw(); else cells.remove(i);
}
