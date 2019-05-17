class Force2{

  Phys2[] l;
  float[] p;
  String k;

  Force2(String kind, float[] parameters, Phys2 a, Phys2 b){
    k = kind;
    p = parameters;
    l = new Phys2[2];
    l[0] = a;
    l[1] = b;
  }

  void update(){
    if(kind == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  void attraction(){
    for(int i=0; i<l.length(); i++){
      for(int j=0; j<l.length(); j++){
        if(i!=j){
          float tmp = Vect2.angleBetweenUnits(l.[i], l.[j]);
          l[i].addAccInDirection(p[0], tmp);
        }
      }
    }
  }
}

