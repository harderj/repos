
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
SineWave sine;
AudioInput in;

void setup()
{
  size(512, 200, P2D);

  minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 512);
}

void draw()
{
  background(0);
  stroke(255);
  
  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 100 + in.right.get(int(float(i)/40))*50, i+1, 100 + in.left.get(int(float(i)/40)+1)*50);
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  
  super.stop();
}

//_______________________

/*

void setup()
{
  size(512, 200, P2D);
  
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
  // create a sine wave Oscillator, set to 440 Hz, at 0.5 amplitude, sample rate from line out
  sine = new SineWave(440, 0.5, out.sampleRate());
  // set the portamento speed on the oscillator to 200 milliseconds
  sine.portamento(200);
  // add the oscillator to the line out
  out.addSignal(sine);
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
}

void mouseMoved()
{
  // with portamento on the frequency will change smoothly
  float freq = map(mouseY, 0, height, 1500, 60);
  sine.setFreq(freq);
  // pan always changes smoothly to avoid crackles getting into the signal
  // note that we could call setPan on out, instead of on sine
  // this would sound the same, but the waveforms in out would not reflect the panning
  float pan = map(mouseX, 0, width, -1, 1);
  sine.setPan(pan);
}

void stop()
{
  out.close();
  minim.stop();
  
  super.stop();
}

*/
