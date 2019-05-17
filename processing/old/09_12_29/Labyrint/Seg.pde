class Seg{

  Vect2 pos;
  //int id, parent;

  Seg(Vect2 pos /*, int id, int parent*/){
    this.pos = new Vect2(pos);
    //this.id = id;
    //this.parent = parent;
  }

  Seg(float x, float y, int id, int parent){
    pos = new Vect2();
    pos.x = x;
    pos.y = y;
//    this.id = id;
//    this.parent = parent;
  }

  void render(){
    stroke(0);
    point(pos.x, pos.y);
  }

}

