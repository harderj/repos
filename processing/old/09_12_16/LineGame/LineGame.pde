import processing.opengl.*;

float speed = 3;
float turnSpeed = TWO_PI*0.02;
String keys = "12,kl";
color[] colors = { color( 255, 0, 0 ), color( 0, 255, 0 ), color( 0, 0, 255 ), color( 255, 255, 0 ), color( 255, 0, 255 ), color( 0, 255, 255 ) };

String[] keySet = split( keys, ',' );
int dotCount = keySet.length;
int dead = 0;

ArrayList dots, buttons;
PFont font;

void setup(){
  size( 1000, 600 );
  frameRate( 25 );
  smooth( );

  dots = new ArrayList( );
  buttons = new ArrayList( );
  font = loadFont( "Arial-Black-48.vlw" );

  for( int i = 0; i < dotCount; i++ ){
    dots.add( new Dot( keySet[i], colors[i] ) );
    addButtons( keySet[i] );
  }

  restart();
}

void restart(){
  background(0);
  for( int i = 0; i < dotCount; i++ ){
    textFont( font, 15 );
    fill( ( ( Dot ) dots.get( i ) ).col );
    text( ( ( Dot ) dots.get( i ) ).points, 20, 20 +20*i );
    
    ( ( Dot ) dots.get( i ) ).pos.set( random( width ), random( height ), 0 );
    ( ( Dot ) dots.get( i ) ).ang = random( TWO_PI );
    ( ( Dot ) dots.get( i ) ).alive = true;
    
    dead = 0;
  }
}

void draw(){
  if( dead >= dotCount -1 ) restart( );
  for( int i = 0; i < dotCount; i++ ) ( ( Dot ) dots.get( i ) ).upd();
  for( int i = 0; i < buttons.size(); i++ ) ( ( Button ) buttons.get( i ) ).draw();
}

class Dot{
  String keys;
  PVector pos;
  float ang;
  boolean alive;
  color col;
  int points;

  Dot( String keys, color col ){
    this.keys = keys;
    pos = new PVector( );
    ang = 0;
    alive = true;
    this.col = col;
    points = 0;
  }

  void upd( ){
    if( alive ){
      if( getButtonBinary( keys.charAt( 0 ) ) ) ang -= turnSpeed;
      if( getButtonBinary( keys.charAt( 1 ) ) ) ang += turnSpeed;
      
      pos.x += cos( ang )*speed;
      pos.y += sin( ang )*speed;
      
      if( get( int( pos.x +cos( ang )*speed ), int( pos.y +sin( ang )*speed ) ) != color( 0 ) ){
        alive = false;
        points -= dotCount -dead -1;
        dead += 1;
      }
      
      stroke( col );
      strokeWeight( speed*2 );
      point( pos.x, pos.y );
    }
  }
}

