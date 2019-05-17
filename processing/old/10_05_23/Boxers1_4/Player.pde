class Player{
  
  Ball body, hand1, hand2;
  float rotation;
  
  float angle1, angle2, dist1, dist2;
  
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
    angle1 = atan2(body.p.y-hand1.p.y, body.p.x-hand1.p.x);
    angle2 = atan2(body.p.y-hand2.p.y, body.p.x-hand2.p.x);
    dist1 = dist(body.p.x, body.p.y, hand1.p.x, hand1.p.y);
    dist2 = dist(body.p.x, body.p.y, hand2.p.x, hand2.p.y);
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
    float radius = 10;
    float factorAttract = 0.0001;
    float factorDetract = sqrt(radius*radius-dist1*dist1)*0.1;
    float factorHand = 0.80;
    float factorBody = 0.20;
    float factor2 = -10;
    // attract
    hand1.a.x += cos(angle1)*(dist1)*factorAttract*factorHand;
    hand1.a.y += sin(angle1)*(dist1)*factorAttract*factorHand;
    body.a.x -= cos(angle1)*(dist1)*factorAttract*factorBody;
    body.a.y -= sin(angle1)*(dist1)*factorAttract*factorBody;
    // detract
    if(dist1<radius){
    hand1.a.x -= cos(angle1)*factorDetract*factorHand;
    hand1.a.y -= sin(angle1)*factorDetract*factorHand;
    body.a.x += cos(angle1)*factorDetract*factorBody;
    body.a.y += sin(angle1)*factorDetract*factorBody;
    }
  }
  
  void render(){
    
    strokeWeight(2);
    stroke(255,0,0);
    line(body.p.x, body.p.y, hand1.p.x, hand1.p.y);
    stroke(0,255,0);
    line(body.p.x, body.p.y, hand2.p.x, hand2.p.y);
    
  }
  
}
