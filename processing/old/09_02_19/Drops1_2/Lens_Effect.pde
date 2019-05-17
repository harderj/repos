class LensEffect{
  boolean is = true;
  
  int lensD;  // Lens diameter
  int[] lensArray;  // Height and width of lens

  PImage lensImage;
  PImage lensImage2;

  int xx,yy;

  LensEffect(int diameter){
    lensD = diameter;
    lensArray = new int[lensD*lensD];
    xx = 0;
    yy = 0;

    // Create buffered image for image to warp
    lensImage = createGraphics(lensD, lensD, P2D);
    lensImage2 = createGraphics(lensD, lensD, P2D);

    // Lens algorithm (transformation array)
    int magFactor = int(lensD*0.2);  // Magnification factor
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
  }

  void render(float posX, float posY) {
    xx = int(posX);
    yy = int(posY);

    lensImage = createGraphics(lensD, lensD, P2D);

    // save the backgrounlensD of lensHeight*lensWilensDth pixels rectangle at the coorlensDinates 
    // where the lens effect will be applielensD.
    lensImage2.copy(bg, xx, yy, lensD, lensD, 0, 0, lensD, lensD);

    // output into a bufferelensD image for reuse
    lensImage.loadPixels();

    // For each pixel in the destination rectangle, apply the color
    // from the appropriate pixel in the saved background. The lensArray
    // array tells the offset into the saved background.
    for (int i = 0; i < lensImage.pixels.length; i++)  {
      lensImage.pixels[i] = lensImage2.pixels[lensArray[i]]; 
    } 
    lensImage.updatePixels();
    
    // Overlay the lens square
    image(lensImage, xx, yy, lensD, lensD); 
  }
}
