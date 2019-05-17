class Vector2{
  float x, y;
  
  //constructors
  Vector2() {
    x = 0;
    y = 0;
  }
  
  Vector2( Vector2 v) {
    this.x = v.x;
    this.y = v.y;
  }

  Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //sets
  void set() {
    x = 0;
    y = 0;
  }
  
  void setX(float x) {
    this.x = x;
  }
  
  void setY(float y) {
    this.y = y;
  }
  
  void set(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void set(Vector2 tmp) {
    x = tmp.x;
    y = tmp.y;
  }
  
  void setRandom(){
    float tmp = random(PI,-PI);
    x = cos(tmp);
    y = sin(tmp);
  }
  
  void setRandom(float m){
    float tmp = random(PI,-PI);
    x = cos(tmp)*m;
    y = sin(tmp)*m;
  }
  
  //add
  void addX(float x) {
    this.x += x;
  }
  
  void addY(float y) {
    this.y += y;
  }
  
  void add(float x, float y) {
    this.x += x;
    this.y += y;
  }
  
  void add(Vector2 tmp) {
    x += tmp.x;
    y += tmp.y;
  }
  
  //subtract
  void subX(float x) {
    this.x -= x;
  }
  
  void subY(float y) {
    this.y -= y;
  }
  
  void sub(float x, float y) {
    this.x -= x;
    this.y -= y;
  }
  
  void sub(Vector2 tmp) {
    x -= tmp.x;
    y -= tmp.y;
  }
  
  //multiply
  void multX(float x) {
    this.x *= x;
  }
  
  void multY(float y) {
    this.y *= y;
  }
  
  void mult(float a) {
    this.x *= a;
    this.y *= a;
  }
  
  void mult(float x, float y) {
    this.x *= x;
    this.y *= y;
  }
  
  void mult(Vector2 tmp) {
    x *= tmp.x;
    y *= tmp.y;
  }
  
  //divide
  void divX(float x) {
    this.x /= x;
  }
  
  void divY(float y) {
    this.y /= y;
  }
  
  void div(float a) {
    this.x /= a;
    this.y /= a;
  }
  
  void div(float x, float y) {
    this.x /= x;
    this.y /= y;
  }
  
  void div(Vector2 tmp) {
    x /= tmp.x;
    y /= tmp.y;
  }
  
  //other functions
  void normalize() {
    float m = magnitude();
    if (m > 0) {
      div(m);
    }
  }
  
  void negativize(){
    x *= -1;
    y *= -1;
  }
  
  void variate(Vector2 v){
    float m = 0.1;
    float tmpD = dist(x,y,v.x,v.y);
    float tmpA = atan2(y-v.y,x-v.x)+random(PI*m,-PI*m);
    x = cos(tmpA)*tmpD;
    y = sin(tmpA)*tmpD;
  }
  
  void variate(Vector2 v, float m){
    float tmpD = dist(x,y,v.x,v.y);
    float tmpA = atan2(y-v.y,x-v.x)+random(PI*m,-PI*m);
    x = cos(tmpA)*tmpD;
    y = sin(tmpA)*tmpD;
  }
  
  //read functions
  float magnitude() {
     return (float) Math.sqrt(x*x + y*y);
  }
}
