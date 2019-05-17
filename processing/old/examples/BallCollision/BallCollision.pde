// st33d's ball bashing demo 
// Use cursor keys to smack the red ball into the others 
BallParticle [] balls; 
void setup(){ 
  size(500, 500); 
  initBalls(); 
  ellipseMode(CENTER); 
  smooth(); 
  noStroke(); 
} 
void draw(){ 
  background(240, 200, 30); 
  updateBalls(); 
} 
void initBalls(){ 
  balls = new BallParticle[20]; 
  for(int i=0; i<balls.length; i++) 
    balls[i] = new BallParticle(50+(i%5)*100, 100+(i/5)*100, 25); 
    balls[0].col = balls[0].init_col = color(255, 20, 20); 
} 
// Manage the balls here 
void updateBalls(){ 
  for(int i=0; i<balls.length; i++){ 
    balls[i].verlet(0,0,0.97); 
    balls[i].col=lerpColor(balls[i].col, balls[i].init_col, 0.1); 
  } 
  for(int i=1; i<balls.length; i++){ 
    for(int j=0; j<i; j++){ 
 if(balls[i].intersects(balls[j])){ 
   balls[i].col = balls[j].col = color(0); 
   resolveBallCollision(balls[i], balls[j]); 
 } 
    } 
  } 
  for(int i=0; i<balls.length; i++){ 
    fill(balls[i].col); 
    ellipse(balls[i].x, balls[i].y, balls[i].radius*2, balls[i].radius*2); 
  } 
  if(keyPressed){ 
    switch(keyCode){ 
 case LEFT: balls[0].px += 1; break; 
 case RIGHT: balls[0].px -= 1;  break; 
 case UP: balls[0].py += 1; break; 
 case DOWN: balls[0].py -= 1; break; 
    } 
    if(key == ' ') initBalls(); 
  } 
} 
// Our ball particle 
class BallParticle extends Point{ 
  int init_col, col; 
  float px,py,ix,iy,temp_x,temp_y; 
  float radius, elasticity = 1.0; 
  BallParticle(float x, float y, float radius){ 
    super(x, y); 
    this.ix = px = temp_x = x; 
    this.iy = py = temp_y = y; 
    this.radius = radius; 
    elasticity = 0.3; 
    col = init_col = color(255); 
  } 
  // Movement by verlet integration - a personal preference 
  void verlet(float gravity_x, float gravity_y, float damping){ 
    temp_x = x; 
    temp_y = y; 
    x += damping * (x - px) + gravity_x; 
    y += damping * (y - py) + gravity_y; 
    px = temp_x; 
    py = temp_y; 
  } 
  // Fast test for intersection - no sqrts here chum 
  boolean intersects(BallParticle o){ 
    return (o.x-x)*(o.x-x)+(o.y-y)*(o.y-y) <= (radius+o.radius)*(radius+o.radius); 
  } 
} 
// A quick point class to make measuring lines easier 
static class Point{ 
  float x,y; 
  Point(float x, float y){ 
    this.x = x;  
    this.y = y; 
  } 
} 
// Reusable line class I use for vector math 
static class Line{ 
  Point a, b; 
  float vx, vy, len, dx, dy, rx, ry, lx, ly; 
  Line(Point a, Point b){ 
    this.a = a; 
    this.b = b; 
    updateLine(); 
  } 
  void updateLine(){ 
    vx = b.x - a.x; 
    vy = b.y - a.y; 
    // length of vector 
    len = sqrt(vx * vx + vy * vy); 
    // normalized unit-sized components 
    if (len > 0) { 
 dx = vx / len; 
 dy = vy / len; 
    } else { 
 dx = 0.0; 
 dy = 0.0; 
    } 
    // right hand normal 
    rx = -dy; 
    ry = dx; 
    // left hand normal 
    lx = dy; 
    ly = -dx; 
  } 
} 
