import processing.net.*;

boolean host = false;
int port = 1337;
String hostIp = "169.254.164.142";
Server myServer;
Client myClient;
PVector pos;
PFont font;

void setup(){
  size(500, 500);
  frameRate(20);
  ellipseMode(CENTER);
  smooth();

  if(host) myServer = new Server(this, port);
  else myClient = new Client(this, hostIp, port);
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
  fill(255, 0, 0, 100);
  ellipse(0, 0, 50, 50);
}

void mousePressed(){
  pos.add(mouseX - width*0.5, mouseY - height*0.5, 0);
}

void host(){
  if(frameCount%5 == 0){
    Client cli = myServer.available();
    if(cli != null){
      String input = cli.readString();
      println(input);
      myServer.write(input + vector2String(pos) + "\n");
    }
  }
}

void clientEvent(Client cli){
  println(myClient.readString());
  //myClient.write(vector2String(pos) + "\n");
}

void serverEvent(Server ser, Client cli){
}

void disconnectEvent(Client cli){
}

