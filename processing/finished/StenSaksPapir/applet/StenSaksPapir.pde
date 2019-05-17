ArrayList buttons, fires;

float L1 = 0;
float L2 = 0;
int D1 = 0;
int D2 = 0;
int A1 = 2;
int A2 = 2;

PFont font;

void setup(){
  size(400,400);
  smooth();

  font = loadFont("Arial-Black-48.vlw");
  buttons = new ArrayList();
  fires = new ArrayList();

  buttons.add(new Button('q'));
  buttons.add(new Button('w'));
  buttons.add(new Button('e'));
  buttons.add(new Button('a'));
  buttons.add(new Button('s'));
  buttons.add(new Button('d'));

  buttons.add(new Button('h'));
  buttons.add(new Button('j'));
  buttons.add(new Button('k'));
  buttons.add(new Button('y'));
  buttons.add(new Button('u'));
  buttons.add(new Button('i'));
}

void draw(){
  background(0);

  for (int i=0; i<buttons.size(); i++) if(((Button) buttons.get(i)).act) ((Button) buttons.get(i)).draw(); 
  else buttons.remove(i);
  
  for (int i=0; i<fires.size(); i++) if(((Fire) fires.get(i)).act) ((Fire) fires.get(i)).draw(); 
  else fires.remove(i);

  String keys = "qweasd";
  char tmpFind;
  for(int j=0; j<keys.length(); j++){
    tmpFind = keys.charAt(j); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        if(((Button) buttons.get(i)).pressed){
          if(j<3){
            D1 = j;
          } 
          else {
            A1 = j-3;
          }
        }
      }
    }
  }

  keys = "hjkyui";
  for(int j=0; j<keys.length(); j++){
    tmpFind = keys.charAt(j); 
    for(int i=0; i<buttons.size(); i++){
      if(tmpFind == ((Button) buttons.get(i)).order){
        if(((Button) buttons.get(i)).pressed){
          if(j<3){
            D2 = j;
          } 
          else {
            A2 = j-3;
          }
        }
      }
    }
  }

  noFill();
  stroke(255);
  strokeWeight(3);
  for(int i=0; i<3; i++){
    for(int j=0; j<4; j++){
      ellipse((width/2)+i*(width/6),(height/9)+j*(height/4),50,50);
    }
  }

  //player 1
  noStroke();
  if(D1 == 0) fill(255,0,0);
  if(D1 == 1) fill(0,255,0);
  if(D1 == 2) fill(0,0,255);
  ellipse((width/2)+D1*(width/6),(height/9)+0*(height/4),40,40);

  noStroke();
  if(A1 == 0) fill(255,0,0);
  if(A1 == 1) fill(0,255,0);
  if(A1 == 2) fill(0,0,255);
  ellipse((width/2)+A1*(width/6),(height/9)+1*(height/4),40,40);

  //player 2
  noStroke();
  if(D2 == 0) fill(255,0,0);
  if(D2 == 1) fill(0,255,0);
  if(D2 == 2) fill(0,0,255);
  ellipse((width/2)+D2*(width/6),(height/9)+3*(height/4),40,40);

  noStroke();
  if(A2 == 0) fill(255,0,0);
  if(A2 == 1) fill(0,255,0);
  if(A2 == 2) fill(0,0,255);
  ellipse((width/2)+A2*(width/6),(height/9)+2*(height/4),40,40);

  if(D1 == A2){
    L1 ++;
    stroke(255,0,255);
    strokeWeight(3);
    line((width/2)+D1*(width/6),(height/9)+0*(height/4),(width/2)+A2*(width/6),(height/9)+2*(height/4));
    
    fires.add(new Fire((width/2)+D1*(width/6),(height/9)+0*(height/4), random(-2,2), random(-6,1), 40, color(255,0,255)));
  }
  
  if(D2 == A1){
    L2 ++;
    stroke(255,255,0);
    strokeWeight(3);
    line((width/2)+D2*(width/6),(height/9)+1*(height/4),(width/2)+A1*(width/6),(height/9)+3*(height/4));
    
    fires.add(new Fire((width/2)+D2*(width/6),(height/9)+3*(height/4), random(-2,2), random(-6,1), 40, color(255,255,0)));
  }
  
  fill(255);
  textFont(font, 15);
  text("L1 = " + L1, 20, height/10);
  text("L2 = " + L2, 20, height/10*9);
  
  stroke(255);
  strokeWeight(3);
  line(width/6,height/2-100,width/6,height/2+100);
  
  textFont(font, 10);
  
  if(L1 > L2){
    noStroke();
    fill(255,0,255);
    ellipse(width/6, height/2 - (100 - (L2/L1)*100),15,15);
    
    text("L1 is       " + int(100 - (L2/L1*100)) + " % better", width/13, height/2 + 5 - (100 - (L2/L1)*100));
  }
  
  if(L2 > L1){
    noStroke();
    fill(255,255,0);
    ellipse(width/6, height/2 + (100 - (L1/L2)*100),15,15);
    
    text("L2 is       " + int(100 - (L1/L2*100)) + " % better", width/13, 5 + height/2 +  (100 - (L1/L2)*100));
  }
}

void mousePressed(){
  fires.add(new Fire(mouseX, mouseY, random(-2,2), random(-1,6), 100, color(255)));
}
