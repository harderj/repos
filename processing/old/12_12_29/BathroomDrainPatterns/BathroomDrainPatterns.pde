int ringCount = 7;
float ringDistance = 30;
float circleDistance = 20;
float circleRadius = 10;
float circleDiameter = circleRadius * 2;
float offsetX, offsetY;

void setup(){
  size(1200,500);
  smooth();
  ellipseMode(CENTER);
  fill(125);
  noStroke();
  offsetX = width*0.8;
  offsetY = height*0.5;
}

void draw(){
  background( 0 );
  update();
}

void update(){
  for( int i = 0; i < ringCount; i++ ){
    float r = i * ringDistance;
    float circumference = PI * r;
    int count = max(1, floor( circumference / circleDistance ));
    
    for( int j = 0; j < count; j++ ){
      float countInverse = 1 / float( count );
      float angle = TWO_PI * j * countInverse;
      float x = cos( angle ) * r + offsetX;
      float y = sin( angle ) * r + offsetY;
      ellipse( x, y, circleDiameter, circleDiameter );
    }
  }
}
