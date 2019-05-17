boolean insideScreen(float x, float y){
  if(x >= 0 && x <= width && y >= 0 && y <= height) return true;
  else return false;
}

boolean insideInterval(float a, float min, float max){
  if(a >= min && a <= max) return true;
  else return false;
}
