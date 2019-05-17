import processing.net.*;

boolean host = false;
boolean visit = false;
int port = 1337;
int clientMax = 10;
int clientCount = 0;
String[] ip = new String[clientMax];
Server myServer;
Client myClient;
PVector pos;
PFont font;

void setup(){
  size(500, 500);
  ellipseMode(CENTER);
  smooth();
  
  myServer = new Server(this, port);
  myClient = new Client(this, "10.0.0.4", port);
  pos = new PVector();
  font = loadFont("Arial-Black-48.vlw");
  for(int i=0; i<clientMax; i++) ip[i] = "10.0.0.0";
  for(int i=0; i<clientMax; i++) cPos[i] = new PVector(0, 0, 0);
}

void draw(){
  background(255);
  translate(width*0.5 -pos.x, height*0.5 -pos.y);
  
  if(host) host();
  display();
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
  ip[clientCount] = cli.ip();
  clientCount ++;
}

void disconnectEvent(Client cli){
  boolean tmpFlag = false;
  for(int i=0; i<clientCount; i++){
    if(tmpFlag) ip[i-1] = ip[i];
    if(ip[i] == cli.ip()) tmpFlag = true;
  }
  clientCount --;
  if(clientCount < 1) host = false;
}

void host(){
  myClient = myServer.available(); // !?
  PVector cPos = new PVector[clientMax];$$$
  if(myClient != null){
    String tmpAll = myClient.readString();
    for(int i=0; i<clientCount; i++){
      String tmp
      tmpAll = substring(tmpAll.indexOf("§") + 1, tmpAll.length());
    }
  }
  
  for(int i=0; i<clientCount; i++){
    myServer.write(cPos[i] + "§");
  }
}
