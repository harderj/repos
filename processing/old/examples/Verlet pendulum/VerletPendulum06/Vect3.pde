class Vect3 {
  public float x, y, z;
  
  public Vect3() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }
  
  public Vect3( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public Vect3( Vect3 v ) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
  }
  
  public void add( Vect3 v ) {
    x += v.x;
    y += v.y;
    z += v.z;
  }
  
  public void add( float sx, float sy, float sz ) {
    x += sx;
    y += sy;
    z += sz;
  }
  
  public void subtract( Vect3 v ) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
  }
  
  public void subtract( float sx, float sy, float sz ) {
    x -= sx;
    y -= sy;
    z -= sz;
  }
  
  public void scale( float s ) {
    x *= s;
    y *= s;
    z *= s;
  }
  
  public void set( Vect3 v ) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
  }
  
  public float dot() {
    return x*x + y*y + z*z;
  }
  
    public Vect3 cross(Vect3 v) {
    float sx = y*v.z + z*v.y;
    float sy = z*v.x + x*v.z;
    float sz = x*v.y + y*v.x;
    return new Vect3(sx,sy,sz);
  }
  
  public float dot(Vect3 v) {
    return x*v.x + y*v.y + z*v.z;
  }
  
  public float magnitude() {
    return sqrt( this.dot() );
  }
  
  public void setMagnitude( float magnitude ) {
    if( this.dot() != 0 ) {
      this.scale( magnitude / this.magnitude() );
    }
  }
  
  public String toString() {
    return "Vect3: { " + x + " , " + y + " , " + z + " }";
  }
}
