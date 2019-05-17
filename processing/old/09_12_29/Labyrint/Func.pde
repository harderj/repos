boolean isInside(float a, float min, float max){
  if(a >= min && a <= max) return true;
  else return false;
}

boolean isInside(Vect2 v, Vect2 min, Vect2 max){
  if(v.x >= min.x && v.x <= max.x && v.y >= min.y && v.y <= max.y) return true;
  else return false;
}

boolean isInside(Vect2 v, float minX, float maxX, float minY, float maxY){
  if(v.x >= minX && v.x <= maxX && v.y >= minY && v.y <= maxY) return true;
  else return false;
}

boolean isInside(Vect2 v){
  if(v.x >= 0 && v.x <= width && v.y >= 0 && v.y <= height) return true;
  else return false;
}

boolean isInside(Vect2 v1, Vect2 v2, float r){
  Vect2 v = v1.subtracted(v2);
  if(v.squareMagnitude() < r*r) return true;
  else return false;
}

//int random(int[] l){
//  float r = random(0,1);
//  
//  int i=-1;
//  while(i < l.length+1){
//    i++;
//    if(((float)i/(float)l.length)*i < r) break;
//  }
//  
//  return l[i];
//}
//
//float random(float[] l){
//  float r = random(0,1);
//  
//  int i=-1;
//  while(i < l.length+1){
//    i++;
//    if(((float)i/(float)l.length)*i < r) break;
//  }
//  
//  return l[i];
//}

//Vect2 sub(Vect2 subtracted, Vect2 subtractor){
//  return new Vect2(subtracted.x-subtractor.x, subtracted.y-subtractor.y);
//}
