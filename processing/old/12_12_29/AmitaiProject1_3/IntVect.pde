class IntVect {

  int x, y;

  IntVect(IntVect) {
    set(IntVect);
  }

  IntVect(int x, int y) {
    set(x, y);
  }

  IntVect(float x, float y) {
    set(x, y);
  }

  void set(IntVect v) {
    set(v.x, v.y);
  }

  void set(int x, int y) {
    this.x=x;
    this.y=y;
  }

  void set(float x, float y) {
    set(int(x), int(y));
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
    return sqrt(dist2(a, b));
  }

  void draw(int i, float s) {
    ellipse(x, y, s, s);
    text(i, x, y);
  }
}

