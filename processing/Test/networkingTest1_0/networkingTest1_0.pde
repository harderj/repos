import processing.net.*;

boolean host = false;
int port = 1337;
Server myServer;
Client myClient;
PVector pos;
PFont font;

void setup(){
  size(500, 500);
  ellipseMode(CENTER);
  smooth();
  
  myServer = new Server(this, port);
  pos = new PVector();
  font = loadFont("Arial-Black-48.vlw");
}

void draw(){
  background(255);
  translate(width*0.5 -pos.x, height*0.5 -pos.y);
  
  display();
  if(host) host();
}

void display(){
  noStroke();
  fill(0);
  ellipse(pos.x, pos.y, 20, 20);
}

void mousePressed(){
  pos.add(mouseX - width*0.5, mouseY - height*0.5, 0);
  println("Pos: (" + pos.x + ", " + pos.y + ")");
}

void serverEvent(Server ser, Client cli){
  host = true;
}

void host(){
  for(
  myServer.write(
}
