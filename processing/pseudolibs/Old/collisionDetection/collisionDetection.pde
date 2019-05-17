PVector[] polygonFramed = new PVector[3];
PVector[] polygonSolid = new PVector[4];
PVector start, end, circle;
float radius;

void setup(){
  noCursor();
  smooth();
  ellipseMode(CENTER);

  radius = 5;

  start = new PVector(10, 20);
  end = new PVector(width*0.5, height*0.4);
  circle = new PVector(width-20, 15);

  polygonFramed[0] = new PVector(width*0.5, 10);
  polygonFramed[1] = new PVector(10, height -10);
  polygonFramed[2] = new PVector(width -10, height -10);
  
  polygonSolid[0] = new PVector(width*0.5, height -20);
  polygonSolid[1] = new PVector(width*0.7, height -50);
  polygonSolid[2] = new PVector(width*0.5, height -35);
  polygonSolid[3] = new PVector(width*0.3, height -50);
}

void draw(){
  background(0);

  // line
  noFill();
  stroke(255);
  line(start.x, start.y, end.x, end.y);
  if(collidesLine(new PVector(mouseX, mouseY), end, start, radius)) fill(255, 0, 0, 200);
  ellipse(mouseX, mouseY, radius*2, radius*2);

  // point
  point(circle.x, circle.y);
  noStroke();
  noFill();
  if(collidesCircles(new PVector(mouseX, mouseY), circle, radius, 0)) fill(0, 255, 0, 200);
  ellipse(mouseX, mouseY, radius*2, radius*2);

  // framed polygon
  stroke(255);
  noFill();
  beginShape();
  for(int i=0; i<polygonFramed.length; i++) vertex(polygonFramed[i].x, polygonFramed[i].y); //vertex(random(width), random(height));//vertex(points[i].x, points[i].y);
  endShape(CLOSE);
  if(collidesPolygonFrame(new PVector(mouseX, mouseY), polygonFramed, radius)) fill(0, 0, 255, 200);
  ellipse(mouseX, mouseY, radius*2, radius*2);
  
  // solid polygon
  stroke(255);
  fill(255, 100);
  beginShape();
  for(int i=0; i<polygonSolid.length; i++) vertex(polygonSolid[i].x, polygonSolid[i].y); //vertex(random(width), random(height));//vertex(points[i].x, points[i].y);
  endShape(CLOSE);
  if(collidesPolygonSolid(new PVector(mouseX, mouseY), polygonSolid, radius)) fill(0, 0, 255, 200);
  ellipse(mouseX, mouseY, radius*2, radius*2);
}

boolean insidePolygon(PVector position, float[] poly ){
  int pnum=poly.length/2;
  int id1,id2;
  int i, j, c = 0;
  for (i = 0, j = pnum-1; i < pnum; j = i++) {
    id1=i*2;
    id2=j*2;
    if( (((poly[id1+1] <= y) && (y < poly[id2+1])) || ((poly[id2+1] <= y) && 
      (y < poly[id1+1]))) && (x < (poly[id2] - poly[id1]) * (y - poly[id1+1]) / (poly[id2+1] - poly[id1+1]) + poly[id1]) ){
      c = (c+1)%2;
    }
  }
  return c == 1;
}



boolean collidesPolygonSolid(PVector position, PVector[] points, float radius){
  float[] poly = new float[points.length*2];
  for(int i=0; i<points.length*2; i++){
    if(i%2 == 0) poly[i] = points[i*0.5].x;
    else poly[i] = points[i*0.5].y;
  }
  return insidePolygon(position, poly);
}

boolean collidesPolygonFrame(PVector position, PVector[] points, float radius){
  boolean tmp = false;
  for(int i=0; i<points.length; i++){
    int tmpI = (i+2)%points.length;
    tmp = collidesLine(position, points[i], points[tmpI], radius);
    if(tmp) break;
  }
  return tmp;
}

boolean collidesCircles(PVector position1, PVector position2, float radius1, float radius2){
  PVector delta = new PVector(position1.x, position1.y);
  delta.sub(position2);
  float min2 = (radius1+radius2)*(radius1+radius2);
  float dist2 = delta.x*delta.x + delta.y*delta.y;

  if(min2 > dist2) return true;
  else return false;
}

boolean collidesLine(PVector position, PVector lineStart, PVector lineEnd, float radius){
  float tmpAngle = atan2(lineStart.y-lineEnd.y, lineStart.x-lineEnd.x);

  PVector zero = new PVector(0, 0);
  PVector tmp1 = rotateAround(lineStart, zero, -tmpAngle);
  PVector tmp2 = rotateAround(lineEnd, zero, -tmpAngle);
  PVector tmpPos = rotateAround(position, zero, -tmpAngle);
  PVector tmpMax = new PVector(max(tmp1.x, tmp2.x), max(tmp1.y, tmp2.y));
  PVector tmpMin = new PVector(min(tmp1.x, tmp2.x), min(tmp1.y, tmp2.y));

  if(tmpPos.x < tmpMax.x +radius && tmpPos.x > tmpMin.x -radius && tmpPos.y > tmp1.y -radius && tmpPos.y < tmp1.y +radius ) return true;
  else return false;
}

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

/*

 boolean collidesCircles(float position1x, float position1y, float position2x, float position2y, float radius1, float radius2){
 PVector position1 = new PVector(position1x, position1y);
 PVector position2 = new PVector(position2x, position2y);
 PVector delta = new PVector(position1.x, position1.y);
 delta.sub(position2);
 float min2 = (radius1+radius2)*(radius1+radius2);
 float dist2 = delta.x*delta.x + delta.y*delta.y;
 
 if(min2 > dist2) return true;
 else return false;
 }
 
 
 boolean collidesLine(float x, float y, float startX, float startY, float endX, float endY, float radius){
 PVector position = new PVector(x, y);
 PVector lineStart = new PVector(startX, startY);
 PVector lineEnd = new PVector(endX, endY);
 
 float tmpAngle = atan2(lineStart.y-lineEnd.y, lineStart.x-lineEnd.x);
 
 PVector zero = new PVector(0, 0);
 PVector tmp1 = rotateAround(lineStart, zero, -tmpAngle);
 PVector tmp2 = rotateAround(lineEnd, zero, -tmpAngle);
 PVector tmpPos = rotateAround(position, zero, -tmpAngle);
 PVector tmpMax = new PVector(max(tmp1.x, tmp2.x), max(tmp1.y, tmp2.y));
 PVector tmpMin = new PVector(min(tmp1.x, tmp2.x), min(tmp1.y, tmp2.y));
 
 if(tmpPos.x < tmpMax.x +radius && tmpPos.x > tmpMin.x -radius && tmpPos.y > tmp1.y -radius && tmpPos.y < tmp1.y +radius ) return true;
 else return false;
 }
 
 */




