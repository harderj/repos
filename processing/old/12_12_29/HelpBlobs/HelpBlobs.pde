int def; // for definition
int c; // for counter

Blob[] blobs;

int blobControlled;
float keyMovementSpeed;
boolean HSBColors;
boolean showTheRest;
boolean showCutLine;
color cutLineColor;

void setup() {
  size( 1000, 500 );
  smooth();

  def = width * height;
  c = 0;

  blobs = new Blob[2];
  blobs[0] = new Blob(500, 250, 120, 10);
  blobs[1] = new Blob(750, 300, 70, 40);

  blobControlled = 0;
  keyMovementSpeed = 2;
  HSBColors = false;
  showCutLine = true;
  showTheRest = true;
  cutLineColor = color(255,0,255);
}

void draw() {
  keyCommands();
  updateScreen();
}

void keyCommands() {
  if ( keyPressed ) {
    if ( key == 'a' ) blobs[blobControlled].x -= keyMovementSpeed;
    if ( key == 'd' ) blobs[blobControlled].x += keyMovementSpeed;
    if ( key == 'w' ) blobs[blobControlled].y -= keyMovementSpeed;
    if ( key == 's' ) blobs[blobControlled].y += keyMovementSpeed;
    if ( key == 'f' ) blobs[blobControlled].r -= keyMovementSpeed;
    if ( key == 'g' ) blobs[blobControlled].r += keyMovementSpeed;
    if ( key == 'r' ) blobs[blobControlled].a += keyMovementSpeed;
    if ( key == 't' ) blobs[blobControlled].a -= keyMovementSpeed;
  }
}

void keyPressed() {
  if ( key == 'c' ) HSBColors = !HSBColors;
  if ( key == 'q' ) showCutLine = !showCutLine;
  if ( key == 'e' ) showTheRest = !showTheRest;
}

void updateScreen() {
  float mils = millis();
  loadPixels();
  if (HSBColors) colorMode(HSB);
  else colorMode(RGB);
  while( millis () - mils < 10 ) {
    float f = intensity( c );
    if( showTheRest ) {
      if( HSBColors ) pixels[c] = color( 255 * f, 255, 255 * f );
      else pixels[c] = color( 255 * f );
    }
    else pixels[c] = color(0);
    if( showCutLine && f > 0.49 && f < 0.51 ) pixels[c] = cutLineColor;
    c = ( c + 1 ) % def;
  }
  updatePixels();
}

float intensity(int n) {
  int x, y;
  x = n % width;
  y = n / width;

  float r = 0;
  for ( int i=0; i<blobs.length; i++ ) r += blobs[i].intensity( x, y );
  return r;
}

class Blob {
  int x, y;
  float r, a;

  Blob( int positionX, int positionY, float radius, float radiance ) {
    x = positionX;
    y = positionY;
    r = radius;
    a = radiance;
  }

  float intensity( int px, int py ) {
    float sqDist = sq( px - x ) + sq( py - y );
    if ( sq( a * 0.5 + r ) > sqDist ) {
      return formular( ( sqrt( sqDist ) - ( r - a * 0.5 ) ) / a );
    }
    else return 0;
  }
}

float formular(float x){
  if( x < 0 ) return 1;
  if( x < 1 ) return (1-sqrt(x));
  else return 0;
}

