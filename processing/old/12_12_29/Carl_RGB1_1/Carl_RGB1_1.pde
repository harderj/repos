void setup(){
  noLoop();
  
  // create a random xyz color //
  XYZColor xyzC = new XYZColor(); 
  xyzC.x = random(1);
  xyzC.y = random(1);
  xyzC.z = random(1);
  
  // convert to rgb color space //
  RGBColor rgbC = xyz2rgb( xyzC );
  
  // convert back into xyz color space //
  XYZColor convertedXyzC = rgb2xyz( rgbC );
  
  // test //
  println( xyzC.x + ", " + xyzC.y + ", " + xyzC.z);
  println(" == ");
  println(convertedXyzC.x + ", " + convertedXyzC.y + ", " + convertedXyzC.z);
  if( xyzC.x == convertedXyzC.x && xyzC.y == convertedXyzC.y && xyzC.z == convertedXyzC.z ){
    println( "test succedded!" );
  } else {
    println( "test failed!" );
  }
}


RGBColor xyz2rgb( XYZColor xyzC )
{
  RGBColor rgbC = new RGBColor();
  rgbC.r =  3.2406f*xyzC.x - 1.5372f*xyzC.y - 0.4986f*xyzC.z;
  rgbC.g = -0.9689f*xyzC.x + 1.8758f*xyzC.y + 0.0415f*xyzC.z;
  rgbC.b =  0.0557f*xyzC.x - 0.2040f*xyzC.y + 1.0570f*xyzC.z;
  boolean clip = ( rgbC.r < 0f || rgbC.r > 1f || rgbC.g < 0f || rgbC.g > 1f || rgbC.b < 0f || rgbC.b > 1f );
  if( clip ){
    println("HEY");
//    rgbC.r = (rgbC.r<0f) ? 0f : ( (rgbC.r>1f) ? 1f : rgbC.r );
//    rgbC.g = (rgbC.g<0f) ? 0f : ( (rgbC.g>1f) ? 1f : rgbC.g );
//    rgbC.b = (rgbC.b<0f) ? 0f : ( (rgbC.b>1f) ? 1f : rgbC.b );
  }
  
  rgbC.r = correctXyz2RGB(rgbC.r);
  rgbC.g = correctXyz2RGB(rgbC.g);
  rgbC.b = correctXyz2RGB(rgbC.b);

  return rgbC;
}

float correctXyz2RGB( float cl ){
  float a = 0.055f;
  return cl <= 0.0031308f ? 12.92f*cl : (1f+a) * pow( cl, 1f/2.4f ) - a;
}

float inverseCorrectXyz2RGB( float y ){
  float a = 0.055f;
  return y/12.92f <= 0.0031308f ? y/12.92f : pow((y+a)/(1f+a),2.4f);
}


XYZColor rgb2xyz( RGBColor rgbC )
{
  float a,b,c;
  XYZColor re = new XYZColor();
  
  a = inverseCorrectXyz2RGB(rgbC.r);
  b = inverseCorrectXyz2RGB(rgbC.g);
  c = inverseCorrectXyz2RGB(rgbC.b);
  
  re.x = .4123955891f*a+.180492647f*c+.3575834306f*b;
  re.y = .7151703032f*b+.212586230f*a+.0722004986f*c;
  re.z = .9504971250f*c+.019297215f*a+.1191838645f*b;
  
  return re;
}




class RGBColor {
  float r, g, b;
}

class XYZColor {
  float x, y, z;
}
