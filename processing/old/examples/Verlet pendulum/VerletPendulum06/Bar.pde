class Bar {
  Particle a;
  Particle b;
  
  public Bar( Particle A , Particle B , ArrayList<Particle> particles , ArrayList<Constraint> constraint ) {
    a = A;
    b = B;
    Vect3 delta = new Vect3(B.pos);
    delta.subtract(A.pos);
    delta.scale(0.5f);
    
    Vect3 offset = new Vect3(delta);
    offset.scale(1.0f/5.0f);
    delta.add(A.pos);
    
    Matrix r = new Matrix();
    r.rotate(0,0,PI/2);
    r.translate(delta);
    
    Vect3 temp = new Vect3(delta);
    temp.add(r.getTransformed(offset));
    Particle left  = new Particle( r.getTransformed(offset) ); 
    
    offset.scale(-1.0f);
    Particle right = new Particle( r.getTransformed(offset) );
    
    constraints.add(new Constraint(left, right));
    constraints.add(new Constraint(left, A));
    constraints.add(new Constraint(left, B));
    constraints.add(new Constraint(right, A));
    constraints.add(new Constraint(right, B));
    
    particles.add(left);
    particles.add(right);
  }
  
  void draw() {
    /*
    ellipseMode(CENTER);
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse( a.pos.x , a.pos.y , 10 , 10 );
    ellipse( b.pos.x , b.pos.y , 10 , 10 );
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
    */
  }
}
