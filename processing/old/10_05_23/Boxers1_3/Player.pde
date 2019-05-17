class Player{
  
  Ball body, hand1, hand2;
  float rotation;
  
  float angle1, angle2;
  
  Player(){
    body = new Ball(random(width), random(height));
    hand1 = new Ball(random(width), random(height));
    hand2 = new Ball(random(width), random(height));
    
    rotation = 0;
    
    body.hittingFrame = true;
    hand1.hittingFrame = true;
    hand2.hittingFrame = true;
    body.rendering = true;
    hand1.rendering = true;
    hand2.rendering = true;
  }
  
  void variables(){
    angle1 = atan2(ball.p.y-hand1.p.y, ball.p.x-hand1.p.x);
    angle2 = atan2(ball.p.y-hand2.p.y, ball.p.x-hand2.p.x);
  }
  
  void update(){
    
    variables();
    
    body.update();
    hand1.update();
    hand2.update();
    
    keepLimbsClose();
    
    render();
    
  }
  
  void keepLimbsClose(){
    a
  }
  
  void render(){
    
    strokeWeight(2);
    stroke(0);
    line(body.p.x, body.p.y, hand1.p.x, hand1.p.y);
    line(body.p.x, body.p.y, hand2.p.x, hand2.p.y);
    
  }
  
}
