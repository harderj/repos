/*
int lensD = 250;  // Lens diameter
int[] lensArray = new int[lensD*lensD];  // Height and width of lens

PGraphics lensEffect;
PImage lensImage;
PImage lensImage2;

int xx = 0;
int yy = 0; 
int dx = 1;
int dy = 1;
*/

ArrayList lenses;

void setup() {

  size(640, 360);
  
  lenses = new ArrayList();
  
  lenses.add(new LensEffect(100));
  
  lenses.add(new LensEffect(10));
  /* Create buffered image for lens effect
  lensEffect = createGraphics(width, height, P2D);

  // Load background image 
  lensEffect.beginDraw();
  lensEffect.image(loadImage("red_smoke.jpg"), 0, 0, 
                   lensEffect.width, lensEffect.height);
  lensEffect.endDraw();

  // Create buffered image for image to warp
  lensImage = createGraphics(lensD, lensD, P2D);
  lensImage2 = createGraphics(lensD, lensD, P2D);

  // Lens algorithm (transformation array)
  int magFactor = int(lensD*0.1);  // Magnification factor
  int m, a, b;

  int r = lensD / 2;
  float s = sqrt(r*r - magFactor*magFactor);

  for (int y = -r; y < r; y++) {
    for (int x = -r ;x < r; x++) {
      if(x*x + y*y >= s*s) {
        a = x;
        b = y;
      }
      else {
        float z = sqrt(r*r - x*x - y*y);
        a = int(x * magFactor / z + 0.5);
        b = int(y * magFactor / z + 0.5);
      }
      lensArray[(y + r)*lensD + (x + r)] = (b + r) * lensD + (a + r);
    }
  }
  */
}

void draw() {
  
  updateArrayLists();
  /* Bounce lens around the screen
  if((xx+dx+lensD > lensEffect.width) || (xx+dx < 0)) {
    dx =- dx;
  } 
  if((yy+dy+lensD > lensEffect.height) || (yy+dy < 0)) {
    dy =- dy;
  }
  xx += dx;
  yy += dy;

  lensImage = createGraphics(lensD, lensD, P2D);

  // save the backgrounlensD of lensHeight*lensWilensDth pixels rectangle at the coorlensDinates 
  // where the lens effect will be applielensD.
  lensImage2.copy(lensEffect, xx, yy, lensD, lensD, 0, 0, lensD, lensD);

  // output into a bufferelensD image for reuse
  lensImage.loadPixels();

  // For each pixel in the destination rectangle, apply the color
  // from the appropriate pixel in the saved background. The lensArray
  // array tells the offset into the saved background.
  for (int i = 0; i < lensImage.pixels.length; i++)  {
    lensImage.pixels[i] = lensImage2.pixels[lensArray[i]]; 
  } 
  lensImage.updatePixels();

  // Restore the original picture
  image(lensEffect, 0, 0, width, height); 

  // Overlay the lens square
  image(lensImage, xx, yy, lensD, lensD); 
  */
}

void updateArrayLists(){
  for(int i=0; i<lenses.size(); i++) if(((LensEffect) lenses.get(i)).is) ((LensEffect) lenses.get(i)).draw();
  else remove(i);
}

