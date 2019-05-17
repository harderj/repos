import processing.net.*;

boolean host = false;
int port = 1337;
int clientMax = 10;
int clientCount = 0;
String[] ip = new String[clientMax];
PVector[] cPos = new PVector[clientMax];
Server myServer;
Client myClient;
PVector pos;
PFont font;

void setup(){
  size(500, 500);
  ellipseMode(CENTER);
  smooth();
  
  if(host) myServer = new Server(this, port);
  else myClient = new Client(this, "10.0.0.4", port);
  pos = new PVector();
  font = loadFont("Arial-Black-48.vlw");
  for(int i=0; i<clientMax; i++) ip[i] = "10.0.0.0";
  for(int i=0; i<clientMax; i++) cPos[i] = new PVector();
}

void draw(){
  background(255);
  translate(width*0.5 -pos.x, height*0.5 -pos.y);
  
  if(host) host();
  else visit();
  display();
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
  if(myClient != null){
    String[] tmpAll = split(myClient.readString(), "§");
    for(int i=0; i<tmpAll.length; i++) cPos[i] = string2Vector(tmpAll[i]);
    /*
    for(int i=0; i<clientCount; i++){
      String tmp
      tmpAll = substring(tmpAll.indexOf("§") + 1, tmpAll.length());
    }
    */
  }
  
  myServer.write(vector2String(pos) + "§");
  for(int i=0; i<clientCount; i++){
    myServer.write(vector2String(cPos[i]) + "§");
  }
  myServer.write(clientCount);
}

void visit(){
  String tmp = myClient.readString();
  println(tmp);
  myClient.write(vector2String(pos) + "§");
}

/*
void clientEvent(Client someClient) {
  print("Server Says:  ");
  int dataIn = myClient.read();
  println(dataIn);
}
*/
