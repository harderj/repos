class Tracer {
  Particle target;
  ArrayList<Vect3> history = new ArrayList<Vect3>();
  
  public Tracer( Particle target ) {
    this.target = target;
  }
  
  void draw( PGraphics context ) {
    history.add( new Vect3(target.pos) );
    if( history.size() > 2 ) history.remove(0);
    
    
    /*
    if( history.size() < 2 ) return;
    context.beginShape();
    for( int i = 0 ; i < history.size() ; i++ ) {
      Vect3 v = history.get(i);
      context.curveVertex( v.x , v.y );
    }
    context.endShape();
    */
    for( int i = 0 ; i < history.size()-1 ; i++ ) {
      Vect3 v1 = history.get(i);
      Vect3 v2 = history.get(i+1);
      context.line( v1.x , v1.y , v2.x , v2.y);
    }
  }
}
