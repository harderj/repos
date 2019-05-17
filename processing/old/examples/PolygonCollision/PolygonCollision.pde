/*
Point [] p; 
void setup(){ 
  size(400, 400, P3D); 
  p = new Point[4]; 
  p[0] = new Point(200, 100); 
  p[1] = new Point(200,200); 
  p[2] = new Point(80,180); 
  p[3] = new Point(50,100); 
} 
void draw(){ 
  background(255); 
  quad(p[0].x, p[0].y, p[1].x, p[1].y, p[2].x, p[2].y, p[3].x, p[3].y); 
  ellipse(mouseX, mouseY, 50, 50); 
  if(circlePolyCollision(mouseX, mouseY, 25, p)){ 
    fill(0); 
  }  
  else { 
    fill(255); 
  } 
} 
boolean circlePolyCollision(float xc, float yc, float r, Point [] p){ 
  Point c = new Point(xc,yc); 
  for(int i = 1; i < p.length+1; i++){ 
    Point a = p[i-1]; 
    Point b = p[(i%p.length)]; 
    Line segment = new Line(a, b); 
    Line to_circle = new Line(a, c); 
    // vertex region check 
    float len = Line.dot(segment, segment); 
    float dp = Line.dot(to_circle, segment); 
    if(dp < 0){ 
 // a is the closest vertex 
 if(proximity(a.x, a.y, c.x, c.y, r)) return true; 
    } else if(dp > len){ 
 // b is the closest vertex 
 if(proximity(b.x, b.y, c.x, c.y, r)) return true; 
    } else if(dp >=0 && dp <=len){ 
 // segment region check - check distance to line 
 float np = (to_circle.vx*-segment.lx)+(to_circle.vy*-segment.ly);
 line(c.x, c.y, c.x+np*segment.lx, c.y+np*segment.ly); 
 float vx = np*segment.lx; 
 float vy = np*segment.ly; 
 float d = vx*vx+vy*vy; 
 if((r*r)-d >= 0){ 
   return true; 
 } 
    } 
 
  } 
  return false; 
} 
boolean proximity(float x0, float y0, float x1, float y1, float len){ 
  return (x1-x0)*(x1-x0)+(y1-y0)*(y1-y0) <= len*len; 
} 
static class Point{ 
  float x,y; 
  Point(float x, float y){ 
    this.x = x; 
    this.y = y; 
  } 
} 
static class Line{ 
  Point a, b; 
  float vx,vy,dx,dy,len,rx,ry,lx,ly; 
  Line(Point a, Point b){ 
    this.a = a; 
    this.b = b; 
    updateLine(); 
  } 
  void updateLine(){ 
    vx = b.x-a.x; 
    vy = b.y-a.y; 
    len = sqrt(vx*vx+vy*vy); 
    // normalized unti-sized components 
    if (len>0) { 
 dx = vx/len; 
 dy = vy/len; 
    }  
    else { 
 dx = 0; 
 dy = 0; 
    } 
    rx = -dy; 
    ry = dx; 
    lx = dy; 
    ly = -dx; 
  } 
  static float dot(Line a, Line b){ 
    return a.vx*b.vx+a.vy*b.vy; 
  } 
} 
*/
