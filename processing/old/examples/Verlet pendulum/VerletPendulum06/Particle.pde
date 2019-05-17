class Particle {
  public Vect3 pos;
  public Vect3 pos_;
  public Vect3 acc;
  float mass    = 1.0;
  float invMass = 1.0;
  boolean locked = false;
  
  public Particle(float x, float y, float z) {
    pos  = new Vect3( x, y, z );
    pos_ = new Vect3(pos);
    acc  = new Vect3();
  }
  
  public Particle( Vect3 v ) {
    pos  = new Vect3( v.x, v.y, v.z );
    pos_ = new Vect3(pos);
    acc  = new Vect3();
  }

  public void updateAndDraw() {
    update();
    draw();
  }

  public void update() {
    if( locked ) return;
    accumulateForces();
    verlet();
  }
  
  public float inverseMass() {
    return invMass;
  }
  
  void setMass( float mass ) {
    this.mass = mass;
    invMass = 1.0f / mass;
  }
  
  public float mass() {
    return mass;
  }

  public void accumulateForces() {
    Vect3 f = new Vect3(GRAVITY);
    f.scale(mass);
    acc.add(f);
  }

  public void verlet() {
    Vect3 temp = new Vect3(pos);
    Vect3 newPos = new Vect3(pos);
    float timeStep = 1.0f / frameRate;
    acc.scale( timeStep * timeStep * SPEED );
    pos_.add(acc);
    newPos.subtract(pos_);
    pos.add(newPos);
    pos_ = new Vect3(temp);
  }

  public void draw() {
    ellipseMode(CENTER);
    stroke(255,127);
    strokeWeight(2);
    noFill();
    ellipse(pos.x, pos.y, 5, 5);
  }
}
