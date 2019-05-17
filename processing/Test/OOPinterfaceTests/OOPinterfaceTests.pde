ofDrawing hey;

void setup(){
  size(200,200);
  smooth();
  
  hey = new ofDrawing();
}

void draw(){
  
  noStroke();
  ellipse(20,20,20,20);
  
}

interface oneWay{
  
  void greenIt();
  
}

interface anotherWay{
  
  void redIt();
  
}

class ofDrawing implements oneWay{
  
  ofDrawing(){
    
  }
  
  void greenIt(){
    fill(0,255,0);
  }
  
  void redIt(){
    fill(255,0,0);
  }
  
}



