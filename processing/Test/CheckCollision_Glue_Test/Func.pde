
boolean checkCollision(PVector pos1, PVector pos2, float r1, float r2){
  boolean result = false;

  if((pos1.x-pos2.x)*(pos1.x-pos2.x)+(pos1.y-pos2.y)*(pos1.y-pos2.y) < (r1+r2)*(r1+r2)) result = true;

  return result;
}

PVector keepCirclesGlued(PVector posChange, PVector posAround, float r1, float r2){
  PVector result = new PVector();

  float a = atan2(posChange.y-posAround.y, posChange.x-posAround.x);

  result.set(posAround.x + cos(a)*(r1+r2), posAround.y + sin(a)*(r1+r2), 0.0);

  return result;
}

PVector calcVelCircleCollision(PVector posChange, PVector posAround, PVector velChange){
  PVector result = new PVector();

  float aP = atan2(posChange.y-posAround.y, posChange.x-posAround.y);
  float aV = atan2(velChange.y, velChange.x);
  float aO = 2*aP-aV+PI;
  float d = dist(0,0,velChange.x,velChange.y);

  result.set(cos(aO)*d, sin(aO)*d, 0.0);

  return result;
}

PVector intersect(PVector pos1, PVector pos2, PVector posC, float r){
  PVector result = new PVector();

  float a, b;

  a = tilt(pos1, pos2);
  b = intersectAxisY(pos1, pos2);

  /*
  result.x = ((-a*b)+sqrt(-(b*b)+(r*r)+(a*a)*(r*r)))/(1+(a*a));
   result.y = result.x*a+b;
   */

  result.x = -(-posC.x-a*posC.y-a*b+sqrt(2*posC.x*a*posC.y+2*posC.x*a*b-2*b*posC.y-posC.y*posC.y+r*r-b*b-a*a*posC.x*posC.x+a*a*r*r))/(1+a*a);
  result.y = result.x*a+b;

  return result;
}

PVector intersect(PVector pos11, PVector pos12, PVector pos21, PVector pos22){
  PVector result = new PVector();

  float a1, b1, a2, b2;

  /*
  a1 = (pos11.y-pos12.y)/(pos11.x-pos12.x);
   b1 = pos11.y-(pos11.x*a1);
   
   a2 = (pos21.y-pos22.y)/(pos21.x-pos22.x);
   b2 = pos21.y-(pos21.x*a2);
   */

  a1 = tilt(pos11, pos12);
  b1 = intersectAxisY(pos11, pos12);

  a2 = tilt(pos21, pos22);
  b2 = intersectAxisY(pos21, pos22);

  result.x = -1*((b1-b2)/(a1-a2));
  result.y = a1*result.x+b1;

  return result;
}

float tilt(PVector v1, PVector v2){
  return (v1.y-v2.y)/(v1.x-v2.x);
}

float intersectAxisY(PVector v1, PVector v2){
  return v1.y-(v1.x*((v1.y-v2.y)/(v1.x-v2.x)));
}


