class Ball extends Circle2{
  boolean is = true;

  float m;
  Point2 v, a;

  Ball(Point2 position, float radius){
    p = position;
    r = radius;

    m = r*2*PI;

    v = new Point2();
    a = new Point2();
  }

  void update(){
    hitBalls();
    hitScreen();
    move();
    render();
  }
  
  void hitBalls(){
    for(int i=0; i<balls.size(); i++){
      Ball t = ((Ball) balls.get(i));
      if(intersectingCircle(t)){
        if(!p.equals(t.p)){
          Point2 d = new Point2(p.subtracted(t.p));
          float a = atan2(d.y, d.x);
          p.set(t.p.x+cos(a)*(t.r+r), t.p.y+sin(a)*(t.r+r));
          v.setRotation(2*(t.v.angle())-v.angle());
        }
      }
    }
  }

  void hitScreen(){
    if(!p.insideRect(new Point2(r,r), new Point2(width-r, height-r))){
      if(!insideInterval(p.x, r, width-r)){
        v.x *= -1;
        p.x = constrain(p.x, r, width-r);
      } 
      if(!insideInterval(p.y, r, height-r)){
        v.y *= -1;
        p.y = constrain(p.y, r, height-r);
      }
    }
  }

  void move(){
    a.add(GRAVITY);
    v.add(a);
    v.scale(DRAG);
    a.setZero();
    p.add(v);
  }

  void render(){
    renderAuto();
  }

}


