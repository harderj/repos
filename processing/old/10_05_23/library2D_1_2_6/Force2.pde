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
  
  Force2(String kind, float[] parameters, Phys2 a, Phys2 b, Phys2 c){
    k = kind;
    p = parameters;
    l = new Phys2[3];
    l[0] = a;
    l[1] = b;
    l[2] = c;
  }
  
  Force2(String kind, float[] parameters, Phys2[] lis){
    k = kind;
    p = parameters;
    l = lis;
    /*
    l = new Phys2[lis.length];
    for(int i=0; i<lis.length; i++){
      l[i] = lis[i];
    }
    */
  }

  void update(){
    if(k == "attraction") attraction();
  }

  // ATTRACTION
  //
  // Parameters
  // '0' = acceleration

  void attraction(){
    
    for(int i=0; i<l.length; i++){
      for(int j=0; j<l.length; j++){
        if(i != j) l[i].addAccInDirection(p[0], l[i].p.angleBetween(l[j].p));
      }
    }
    /*
    for(int i=0; i<l.length; i++){
      float tmp = Vect2.angleBetween(l[0].p, l[1].p);
      println(tmp);
      l[i].addAccInDirection(p[0], tmp);
    }
    */
  }
  
  void render(){
    for(int i=0; i<l.length; i++){
      l[i].p.renderAuto();
    }
  }
}

