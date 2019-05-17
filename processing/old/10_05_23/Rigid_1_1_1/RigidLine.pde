class RigidLine extends Rigid{
  
  Line2 l;
  
  RigidLine(Line2 l){
    this.l = l;
    mass = 1;
    rotate = l.angle();
    pos = average(createPoint2List(l.p1, l.p2));
    rotating = 0;
    vel = new Point2();
    acc = new Point2();
  }
  
  void move(){
    basics();
    render();
  }
  
  void basics(){
    float length = l.length();
    l.p1.x = pos.x + 0.5*length*cos(rotate);
    l.p1.y = pos.y + 0.5*length*sin(rotate);
    l.p2.x = pos.x + -0.5*length*cos(rotate);
    l.p2.y = pos.y + -0.5*length*sin(rotate);
  }
  
  void render(){
    l.renderAuto();
  }
}
