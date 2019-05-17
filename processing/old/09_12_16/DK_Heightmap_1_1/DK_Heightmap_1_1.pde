PImage theMap;
int[] pixelOffset;
float[] heightMap;
boolean[] flooded;


void setup()
{       
  //theMap = loadImage("Picture 1.png");
  theMap = loadImage("copenahgen.png"");
  
  size(theMap.width, theMap.height);
  background(theMap);
  
  pixelOffset = new int[]{ -width-1, -width, -width+1, -1, 1, width-1, width, width+1 };
  flooded = new boolean[ width * height ];
  
  heightMap = new float[ width * height ];
  for( int m=0; m<heightMap.length; m++ ){
    int x = m % width;
    int y = m / width;
    heightMap[m] = brightness( theMap.get( x, y ) );
  }
}


void draw(){}


void keyPressed(){
  println( "heyS" );
  if(key == 'q'){
    background( theMap );
    flood();
  }
}



void flood()
{
  
  for( int p=0; p<heightMap.length; p++ ){
    
    if( heightMap[p] == 0 ){
      for( int o=0; o<pixelOffset.length; o++ ){
        int index = p+pixelOffset[o];
        if( index >= 0 && index <= heightMap.length ){
          if( heightMap[ index ] > 0 ){
            flooded[ index ] = true;
            
            int x = p % width;
            int y = p / width;
            //set( x, y, color(255, 0, 0) );
          }
        }
      }
    }
  }
  
  
}


/*
void drawCoastline(){
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      if(brightness(get(i, j)) == 0.0){
        for(int k=0; k<2; k++){
          for(int l=0; l<2; l++){
            if(brightness(get(abs(i+1-(k*2)), abs(j+1-(l*2)))) != 0.0 && get(abs(i+1-(k*2)), abs(j+1-(l*2))) != color(255,0,0)){
              set(i,j,color(255,0,0));
              //println(int(i-k) + " and " + int(j-l));
            }
          }
        }
      }
    }
  }
}
*/
