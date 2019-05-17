boolean searchString(String searchFor, String searchIn){
  // Searches for a specific string, inside another string
  // Returns 'true' if found, 'false' if not
  // If the string searched in is shorter than the one searched for, 'false' will return
  boolean hit = false;
  if(searchFor.length()<searchIn.length()){
    for(int i=0; i<(searchIn.length() - searchFor.length()); i++){
      String tmp = searchIn.substring(i,i+searchFor.length());
      if(tmp.equals(searchFor)){
        hit = true;
      }
    }
  }
  return hit;
}

float inbound(float value, float minimum, float maximum){
  // Keeps a value between a minimum and a maximum by recounting
  while(value>maximum){
    value -= maximum - minimum;
  }

  while(value<minimum){
    value += maximum - minimum;
  }

  return value;
}

boolean insideInterval(float a, float b, float c){
  if(a >= min(b,c) && a <= max(b,c)) return true;
  else return false;
}

color negative(color c){
  return color(255-red(c), 255-green(c), 255-blue(c));
}

Point2 randomPoint2Screen(){
  return new Point2(random(width), random(height));
}

boolean intersectingMultipleLines(Line2[] l){
  // If any line in the list is intersecting : returns true
  // NOTE - see the function "selfIntersecting()" in the class "Poly2"
  boolean result = false;
  for(int i=0; i<l.length; i++){
    for(int j=0; j<l.length; j++){
      if(!l[i].equals(l[j]) && !l[i].sharesPointWithLine(l[j]) && l[i].intersectingLine(l[j])){
        result = true;
        break;
      }
    }
  }
  return result;
}
