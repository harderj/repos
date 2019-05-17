class Vect{
  float[] n;
  
  //constructors
  
  Vect() {
    n = new float[2];
    for(int i = 0; i < 2; i++){
      n[i] = 0;
    }
  }
  
  Vect(int count) {
    n = new float[count];
    for(int i = 0; i < count; i++){
      n[i] = 0;
    }
  }
  
  Vect(float n0, float n1) {
    n = new float[2];
    n[0] = n0;
    n[1] = n1;
  }
  
  Vect(float n0, float n1, float n2) {
    n = new float[3];
    n[0] = n0;
    n[1] = n1;
    n[2] = n2;
  }
  
  Vect(float n0, float n1, float n2, float n3) {
    n = new float[4];
    n[0] = n0;
    n[1] = n1;
    n[2] = n2;
    n[3] = n3;
  }
  
  Vect(float n0, float n1, float n2, float n3, float n4) {
    n = new float[5];
    n[0] = n0;
    n[1] = n1;
    n[2] = n2;
    n[3] = n3;
    n[4] = n4;
  }
  
  Vect(Vect v) {
    int l = v.n.length;
    n = new float[l];
    for(int i = 0; i < l; i++){
      n[i] = v.n[i];
    }
  }
  
  Vect(float[] array){
    int l = array.length;
    n = new float[l];
    for(int i = 0; i < l; i++){
      n[i] = array[i];
    }
  }
  
  //sets
  void setZero(){
    for(int i = 0; i < n.length; i++){
      n[i] = 0;
    }
  }
  
  void set(float value, int place) {
    n[place] = value;
  }
  
  void set(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] = array[i];
    }
  }
  
  void set(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] = v.n[i];
    }
  }
  
  //random
  void randomize(){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(-1,1);
    }
  }
  
  void randomize(float magnitude){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(-1,1)*magnitude;
    }
  }
  
  void randomize(float minimum, float maximum){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(minimum, maximum);
    }
  }
  
  //add
  void add(float[] array) {
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] += array[i];
    }
  }
  
  void add(Vect v) {
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] += v.n[i];
    }
  }
  
  //subtract
  void sub(float[] array) {
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] -= array[i];
    }
  }
  
  void sub(Vect v) {
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] -= v.n[i];
    }
  }
  
  //multiply
  void mult(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] *= array[i];
    }
  }
  
  void mult(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] *= v.n[i];
    }
  }
  
  void mult(float a){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] *= a;
    }
  }
  
  //divide
  void div(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] /= array[i];
    }
  }
  
  void div(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] /= v.n[i];
    }
  }
  
  void div(float a){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] /= a;
    } 
  }
  
  //other functions
  
  void normalize() { //NOTE: the normalize function's calculation method may only work for 2 dimensions
    float m = magnitude();
    if (m > 0) {
      div(m);
    }
  }
  
  void negativize(){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] *= -1;
    } 
  }
  
  void debug(){
    int l = n.length;
    println("-- VECT DATA --");
    for(int i = 0; i < l; i++) print(n[i] + ", ");
    println();
  }
  
  void debug(String name){
    int l = n.length;
    println("-- VECT '" + name + "' DATA --");
    for(int i = 0; i < l; i++) print(n[i] + ", ");
    println();
  }
  
  //read functions
  
  float magnitude(){
    int l = n.length;
    float tmp = 0;
    for(int i = 0; i < l; i++){
      tmp += pow(n[i],2);
    }
    return (float) Math.sqrt(tmp);
  }
}
