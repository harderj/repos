boolean isInsideInterval(float a, float min, float max){
  if(a >= min && a <= max) return true;
  else return false;
}

boolean isInsideRect(Vect2 v, Vect2 min, Vect2 max){
  if(v.x >= min.x && v.x <= max.x && v.y >= min.y && v.y <= max.y) return true;
  else return false;
}

boolean isInsideRect(Vect2 v, float minX, float maxX, float minY, float maxY){
  if(v.x >= minX && v.x <= maxX && v.y >= minY && v.y <= maxY) return true;
  else return false;
}

boolean isInsideScreen(Vect2 v){
  if(v.x >= 0 && v.x <= width && v.y >= 0 && v.y <= height) return true;
  else return false;
}

boolean isInsideCircle(Vect2 v1, Vect2 v2, float r){
  Vect2 v = v1.subtracted(v2);
  if(v.squareMagnitude() < r*r) return true;
  else return false;
}
