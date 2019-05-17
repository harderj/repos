PVector rotateAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  float tmpAngle = atan2(tmp.y, tmp.x);
  tmp.set(around.x + cos(tmpAngle+angle)*tmpMagnitude, around.y + sin(tmpAngle+angle)*tmpMagnitude, 0);
  
  return tmp;
}

PVector setRotationAround(PVector vector, PVector around, float angle){
  PVector tmp = new PVector(vector.x, vector.y);
  tmp.sub(around);
  float tmpMagnitude = tmp.mag();
  tmp.set(around.x + cos(angle)*tmpMagnitude, around.y + sin(angle)*tmpMagnitude, 0);
  
  return tmp;
}

PVector relate(PVector position, PVector viewer, float rotation){
  position.sub(viewer);
  float tmpMag = position.mag();
  float tmpAng = atan2(position.y, position.x);
  position = rotateAround(position, zero, tmpAng +rotation);
  
  return position;
}

PVector relate(PVector position, PVector viewer){
  position.sub(viewer);
  
  return position;
}
