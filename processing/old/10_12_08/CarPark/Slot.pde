class Slot {
  
  int occ;
  int timer;
    
  Slot(){
    
    timer = 0;
    occ = 0;
    
  }
  
  void draw(float x, float y, float s){
    
    render(x, y, s);
    
    if(timer != 0){
      timer --;
      if(timer == 0){
        occ = 0;
      }
    }
        
  }
  
  void set(int o){
    switch(o){
      
      case 1:
        occ = o;
        timer = 4;
        break;
       
      case 2:
        occ = o;
        timer = 2;
        break;
      
      case 3:
        occ = o;
        timer = 1;
        break;
      
      default:
        occ = o;
    }
  }
  
  void render(float x, float y, float s){
    rectMode(CENTER);
    switch(occ){
      case 1:
        fill(255,0,0);
        yield += holipay;
        break;
        
      case 2:
        fill(0,255,0);
        yield += busipay;
        break;
        
      case 3:
        fill(0,0,255);
        break;
        
      default:
        noFill();
        break;
    }
    stroke(0);
    strokeWeight(2);
    rect(x,y,s,s);
  }
  
}
