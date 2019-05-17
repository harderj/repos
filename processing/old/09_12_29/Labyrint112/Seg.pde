class Seg{

  Vect2 pos;
  Seg parent;

  Seg(Vect2 pos, Seg parent){
    this.pos = pos.copy();
    this.parent = parent;
    
    segs.add(this);
  }

  void render(){
    stroke(0);
    point(pos.x, pos.y);
  }

}

