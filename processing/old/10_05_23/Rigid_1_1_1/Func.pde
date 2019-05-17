Point2 average(Point2[] p){
  Point2 t = new Point2();
  for(int i=0; i<p.length; i++) t.add(p[i]);
  t.divide(p.length);
  return t;
}

Point2[] createPoint2List(Point2 a, Point2 b){
  Point2[] p = new Point2[2];
  p[0] = a.copy();
  p[1] = b.copy();
  return p;
}
