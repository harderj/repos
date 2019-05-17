class Goal{
  int x,y;
  
  Goal(int x, int y){
    this.x=x;
    this.y=y;
  }
  
  Goal(float x, float y){
    
    this.x=int(x);
    this.y=int(y);
  }
  
}
