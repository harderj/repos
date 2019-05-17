ArrayList<Particle>   particles   = new ArrayList<Particle>();
ArrayList<Constraint> constraints = new ArrayList<Constraint>();
ArrayList<Tracer> tracers = new ArrayList<Tracer>();
ArrayList<Bar> bars = new ArrayList<Bar>();

color[] colors = {
  color(255,0,0,100),
  color(0,255,0,100),
  color(0,0,255,100),
  color(255,255,0,100),
  color(0,255,255,100),
  color(255,0,255,100)
};

Vect3 GRAVITY = new Vect3(0, -9, 0);
int ITERATIONS = 2;
float SPEED    = 20.0f;

Particle lastParticle;

PGraphics trace;

void setup() {
  size(1024,1024);
  background(0);
  smooth();

  trace = createGraphics(width, height, P3D);
  trace.beginDraw();
  trace.smooth();
  trace.background(0);
  trace.endDraw();
  
  Particle pC = new Particle(width/2.0 , height/2.0, 0); // center point
  pC.locked = true;
  particles.add(pC);
  Particle pL = new Particle(width/2.0-200 , height/2.0, 0);
  particles.add(pL);
  Particle pR = new Particle(width/2.0+200 , height/2.0, 0);
  particles.add(pR);
  constraints.add( new Constraint(pL, pC) );
  constraints.get(constraints.size()-1).shouldDraw = true;
  constraints.add( new Constraint(pR, pC) );
  constraints.get(constraints.size()-1).shouldDraw = true;
  
  Particle pD = new Particle(width/2.0 , height/2.0 - 200, 0);
  particles.add(pD);
  constraints.add( new Constraint(pD, pC) );
  constraints.get(constraints.size()-1).shouldDraw = true;
  constraints.add( new Constraint(pD, pL) );
  constraints.add( new Constraint(pD, pR) );
  
  Particle pU = new Particle(width/2.0 , height/2.0 + 64, 0);
  particles.add(pU);
  pU.weightless = true;
  constraints.add( new Constraint(pU, pC) );
  constraints.add( new Constraint(pU, pL) );
  constraints.add( new Constraint(pU, pR) );
  
  pL.setVelocity( new Vect3(0,-40,0) );
  pR.setVelocity( new Vect3(0,40,0) );
  pD.setVelocity( new Vect3(40,0,0) );
  
  Particle p1 = new Particle( width/2.0-400 , height/2.0, 0 );
  Particle p2 = new Particle( width/2.0+200 , height/2.0-200, 0 );
  Particle p3 = new Particle( width/2.0-200 , height/2.0-200, 0 );
  particles.add(p1);
  particles.add(p2);
  particles.add(p3);
  bars.add( new Bar( pL , p1 , particles , constraints ) );
  bars.add( new Bar( pR , p2 , particles , constraints ) );
  bars.add( new Bar( pD , p3 , particles , constraints ) );
  
  tracers.add( new Tracer(p1) );
  tracers.add( new Tracer(p2) );
  tracers.add( new Tracer(p3) );
  
  lastParticle = new Particle(width/2.0 , height/2.0 , 0);
  lastParticle.locked = true;
  particles.add( lastParticle );
}

void draw() {
  for( int i = 1 ; i < particles.size() ; i++ ) {
    particles.get(i).update();
  }
  for( int i = 0 ; i < constraints.size() ; i++ ) {
    for( int j = 0 ; j < ITERATIONS ; j++ ) {
      constraints.get(i).satisfy();
    }
  }
  
  drawBackground();
  drawForeground();
}

void drawBackground() {
  trace.beginDraw();
  trace.noFill();
  trace.strokeWeight(3.0f);
  trace.strokeCap(ROUND);
  trace.smooth();
  for( int i = 0 ; i < tracers.size() ; i++ ) {
    trace.stroke(colors[i % colors.length]);
    tracers.get(i).draw(trace);
  }
  trace.endDraw();
  image(trace,0,0);
}

void drawForeground() {
  for( int i = 0 ; i < bars.size() ; i++ ) {
    bars.get(i).draw();
  }
  for( int i = 0 ; i < constraints.size() ; i++ ) {
    constraints.get(i).draw();
  }
}
