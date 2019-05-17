class Player{
  
  Ball body, hand1, hand2;
  
  Player(){
    body = new Ball(random(width), random(height));
    hand1 = new Ball(random(width), random(height));
    hand2 = new Ball(random(width), random(height));
    
    body.hitFrame = true;
    hand1.hitFrame = true;
    hand2.hitFrame = true;
  }
  
  void update(){
    body.update();
    hand1.update();
    hand2.update();
    
    render();
    
  }
  
  void render(){
    
    body.render();
    hand1.render();
    hand2.render();
    
    strokeWeight(2);
    stroke(0);
    line(body.p.x, body.p.y, hand1.p.x, hand1.p.y);
    line(body.p.x, body.p.y, hand2.p.x, hand2.p.y);
    
  }
  
}
