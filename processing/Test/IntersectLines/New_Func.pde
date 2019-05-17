color negative(color c){
  return color(255-red(c), 255-green(c), 255-blue(c));
}

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

  a1 = lineTilt(v1, v2);
  b1 = lineOffset(v1, v2);

  a2 = lineTilt(v3, v4);
  b2 = lineOffset(v3, v4);

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

void renderVect2(Vect2 v){
  point(v.x, v.y);
}

void renderVect2Auto(Vect2 v){
  float factor = 0.01;
  strokeWeight((width+height)*0.5*factor);
  stroke(255);
  point(v.x, v.y);
  strokeWeight((width+height)*0.5*factor*0.5);
  stroke(0);
  point(v.x, v.y);
}

void renderVect2Auto(Vect2 v, float factor){
  strokeWeight((width+height)*0.5*factor);
  stroke(255);
  point(v.x, v.y);
  strokeWeight((width+height)*0.5*factor*0.5);
  stroke(0);
  point(v.x, v.y);
}

void renderLineGraph(float a, float b){
  line(0,b,width,a*width+b);
}
