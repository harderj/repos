/**
  * This sketch demonstrates how to use the <code>trigger</code> method of an <code>AudioSample</code>. <br />
  * <code>AudioSample</code>s can only be triggered, not cue'd and looped
  * or anything else you might do with an <code>Playable</code> object. The advantage, however, is that 
  * an <code>AudioSample</code> can be retriggered while it is still playing, which will cause the sample to 
  * overlap with itself.
  * <p>
  * Use 'k' and 's' to trigger a kick drum sample and a snare sample, respectively. You will see their waveforms
  * drawn when they are played back.
  */

import ddf.minim.*;

Minim minim;
AudioSample kick;
AudioSample snare;

void setup()
{
  size(512, 200, P3D);
  minim = new Minim(this);
  // load BD.wav from the data folder
  kick = minim.loadSample("BD.wav", 2048);
  if ( kick == null ) println("Didn't get kick!");
  // load SD.wav from the data folder
  snare = minim.loadSample("SD.wav", 2048);
  if ( snare == null ) println("Didn't get snare!");
}

void draw()
{
  background(0);
  stroke(255);
  // use the mix buffer to draw the waveforms.
  for (int i = 0; i < kick.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, kick.bufferSize(), 0, width);
    float x2 = map(i+1, 0, kick.bufferSize(), 0, width);
    line(x1, 50 - kick.mix.get(i)*50, x2, 50 - kick.mix.get(i+1)*50);
    line(x1, 150 - snare.mix.get(i)*50, x2, 150 - snare.mix.get(i+1)*50);
  }
}

void keyPressed()
{
  if ( key == 's' ) snare.trigger();
  if ( key == 'k' ) kick.trigger();
}

void stop()
{
  // always close Minim audio classes when you are done with them
  kick.close();
  snare.close();
  minim.stop();
  
  super.stop();
}
