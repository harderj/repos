class Force2{
  
  Phys2[] l;
  float[] p;
  String k, t;
  
  Force2(String kind, float[] parameters, String tag){
    k = kind;
    p = parameters;
    t = tag;
    
    searchForPhys(tag);
  }
  
  void searchForPhys(String tag){
    int tmpA = 0;
    for(int i=0; i<phys.size(); i++){
      if(searchString(tag, phys.t)){
        tmpA += 1;
      }
    }
    for(int i=0; i<phys.size(); i++){
      if(searchString(tag, phys.t)){
        tmpA += 1;
      }
    }q
  }

  void update(){
    if(k == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  void attraction(){
    /*
    for(int i=0; i<l.length; i++){
      for(int j=0; j<l.length; j++){
        if(i != j) l[i].addAccInDirection(p[0], l[i].p.angleBetween(l[j].p));
      }
    }
    
    for(int i=0; i<l.length; i++){
      float tmp = Vect2.angleBetween(l[0].p, l[1].p);
      println(tmp);
      l[i].addAccInDirection(p[0], tmp);
    }
    */
  }
}

