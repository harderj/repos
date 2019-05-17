class Constraint {
  public Particle a;
  public Particle b;
  public float restlength;
  public float restlengthSquared;
  
  public Constraint( Particle a, Particle b ) {
    this.a = a;
    this.b = b;
    restlength = sqrt(sq(a.pos.x-b.pos.x) + sq(a.pos.y-b.pos.y) + sq(a.pos.z-b.pos.z));
    restlengthSquared = sq( restlength );
  }
  
  public void satisfy() {
    Vect3 delta = new Vect3(b.pos);
    delta.subtract(a.pos);
    float deltalength = delta.magnitude();
    float diff = (deltalength-restlength) / ( deltalength * (a.inverseMass() + b.inverseMass()) );
    diff *= ( a.locked || b.locked ? 2.0f : 1.0f );
    if( !a.locked )
      a.pos.add( a.inverseMass() * delta.x * diff , a.inverseMass() * delta.y * diff , a.inverseMass() * delta.z * diff );
    if( !b.locked )
      b.pos.subtract( b.inverseMass() * delta.x * diff , b.inverseMass() * delta.y * diff , b.inverseMass() * delta.z * diff );
    
  }
  
  public void draw() {
    stroke(255,127);
    strokeWeight(2);
    strokeCap(ROUND);
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
  }
}
