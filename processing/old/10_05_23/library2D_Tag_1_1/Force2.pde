class Force2{

  float[] p;
  String k, t;

  Force2(String kind, float[] parameters, String tag){
    k = kind;
    p = parameters;
    t = tag;
  }

  void update(){
    if(k == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  void attraction(){
    for(int n=0; n<phys.size(); n++){
      if(searchString(t, ((Phys2) phys.get(n)).t)){
        for(int i=0; i<l.length; i++){
          for(int j=0; j<l.length; j++){
            if(i != j) l[i].addAccInDirection(p[0], l[i].p.angleBetween(l[j].p));
          }
        }
      }
    }
  }

  void render(){
    for(int i=0; i<l.length; i++){
      l[i].p.renderAuto();
    }
  }
}


