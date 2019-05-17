class Seg{

  Vect2 pos;

  Seg(Vect2 pos){
    this.pos = new Vect2(pos);
  }

  Seg(float x, float y, int id, int parent){
    pos = new Vect2();
    pos.x = x;
    pos.y = y;
  }

  void render(){
    stroke(0);
    point(pos.x, pos.y);
  }

}

