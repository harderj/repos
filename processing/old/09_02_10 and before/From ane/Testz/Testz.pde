class V2{
  float x,y;
  
  V2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  V2(V2 v){
    x = v.x;
    y = v.y;
  }
  
  void set(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void set(V2 v){
    x = v.x;
    y = v.y;
  }
  
  void set(float a){
    x = a;
    y = a;
  }
  
  void add(float x, float y){
    this.x += x;
    this.y += y;
  }
  
  void add(V2 v){
    x += v.x;
    y += v.y;
  }
  
  void mult(float a){
    x *= a;
    y *= a;
  }
  
  void mult(V2 v){
    x *= v.x;
    y *= v.y;
  }
  
  void div(float a){
    x /= a;
    y /= a;
  }
  
  void div(V2 v){
    x /= v.x;
    y /= v.y;
  }
  
  float magnitude(){
    return dist(0,0,x,y);
  }
}

V2 v = new V2(1,1);

println(v.magnitude());
