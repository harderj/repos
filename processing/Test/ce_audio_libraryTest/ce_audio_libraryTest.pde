import ce.audio.*;

Player[] player;

void setup(){
  size( 200, 200 );

  Audio.start( this );
  
  player = new Player[3];
  
  player[0] = Audio.newPlayer( "RScan14.aif" );
  player[1] = Audio.newPlayer( "Ping.aiff" );
  player[2] = Audio.newPlayer( "Glass.aiff" );
}

void draw(){
  
}

void keyPressed() {
  if(key == 'a') player[0].play();
  if(key == 's') player[1].play();
  if(key == 'd') player[2].play();
}
