import ddf.minim.*;
import ddf.minim.effects.*;

Animation animation1;
float xpos, ypos;
float drag = 30.0;

Minim minim;
AudioInput in;
BandPass bpf;

int lastFrame;

void setup() {
  size(500, 350);
  background(255, 204, 0);
  frameRate(30);
  animation1 = new Animation("Skarmbillede", 10);
  
  minim = new Minim(this);
  bpf = new BandPass( 200, 100, 44000 );
  in = minim.getLineIn( Minim.MONO, 512 );
  in.addEffect( bpf );
}

float max = 0;
void draw()
{
  float avgVolume = 0;
  for( int i=0; i<512; i++ ) avgVolume += abs( in.left.get(i) );
  avgVolume /= 512.0;
  
  background(0);
  
  int hey = mouseX/(width/10);
  
  int frame = (int) ( avgVolume * 500 );
  if( frame > 9 ) frame = 9;
  if( frame < lastFrame && frame != 0 ) frame--;
  
  animation1.display(0, 0, frame );
  
  lastFrame = frame;
}
