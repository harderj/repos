Vect2 randomScreen(){
  return new Vect2(random(width), random(height));
}

boolean theSame(Vect2 v1, Vect2 v2){
  if(v1.x == v2.x && v1.y == v2.y) return true;
  else return false;
}

boolean intersecting(Vect2 v1, Vect2 v2, Vect2 v3, Vect2 v4){
  Vect2 inter = lineIntersection(v1, v2, v3, v4);
  
  if(insideRect(inter, v1, v2) && insideRect(inter, v3, v4)) return true;
  else return false;
}

Vect2 lineIntersection(Vect2 v1, Vect2 v2, Vect2 v3, Vect2 v4){
  Vect2 result = new Vect2();

  float a1, b1, a2, b2;

  a1 = lineTilt(pos11, pos12);
  b1 = lineOffset(pos11, pos12);

  a2 = lineTilt(pos21, pos22);
  b2 = lineOffset(pos21, pos22);

  result.x = -1*((b1-b2)/(a1-a2));
  result.y = a1*result.x+b1;

  return result;
}

Vect2 lineIntersection(float a1, float b1, float a2, float b2){
  Vect2 result = new Vect2();

  result.x = -1*((b1-b2)/(a1-a2));
  result.y = a1*result.x+b1;

  return result;
}
