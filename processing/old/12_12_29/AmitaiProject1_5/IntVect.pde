class IntVect {

  int x, y;

  IntVect(IntVect v) {
    x=v.x;
    y=v.y;
  }

  IntVect(int x, int y) {
    this.x=x;
    this.y=y;
  }

  IntVect(float x, float y) {
    this.x=int(x);
    this.y=int(y);
  }

  void set(IntVect v) {
    x=v.x;
    y=v.y;
  }

  void set(int x, int y) {
    this.x=x;
    this.y=y;
  }

  void set(float x, float y) {
    this.x=int(x);
    this.y=int(y);
  }

  int dist2(int a, int b) {
    return (x-a)*(x-a)+(y-b)*(y-b);
  }

  int dist2(float a, float b) {
    IntVect v = new IntVect(a, b);
    return dist2(v);
  }

  int dist2(IntVect v) {
    return dist2(v.x, v.y);
  }

  int dist(int a, int b) {
    return int(sqrt(float(dist2(a, b))));
  }
  
  int dist(IntVect v) {
    return dist(v.x, v.y);
  }
  
  boolean equals(IntVect v){
    return (x==v.x && y==v.y);
  }

  void draw(int i, float s) {
    ellipse(x, y, s, s);
    text(i, x-3, y-5);
  }
}

