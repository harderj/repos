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

Vect3 GRAVITY = new Vect3(0, -10, 0);
int ITERATIONS = 1;
float SPEED    = 1.0f;

boolean setupMode = true;
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
  
  lastParticle = new Particle(width/2.0 , height/2.0 , 0);
  lastParticle.locked = true;
  particles.add( lastParticle );
}

void draw() {
  if( setupMode ) {
    background(0);
    drawForeground();
    return;
  }
  
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
  for( int i = 0 ; i < particles.size() ; i++ ) {
    particles.get(i).draw();
  }
  
  for( int i = 0 ; i < constraints.size() ; i++ ) {
    constraints.get(i).draw();
  }
}

void mousePressed() {
  if( !setupMode ) return;
  Particle newParticle = new Particle(mouseX, mouseY, 0);
  particles.add( newParticle );
  if( particles.size() > 2 )
    tracers.add( new Tracer( newParticle ) );

  bars.add( new Bar( lastParticle , newParticle , particles, constraints ) );
  lastParticle = newParticle;
}

void keyPressed() {
  if( setupMode && (keyCode == RETURN || keyCode == ENTER) ) {
    if( particles.size() > 2 ) {
      setupMode = false;
    }
  }
}
