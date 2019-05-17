import processing.core.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; import javax.sound.midi.*; import javax.sound.midi.spi.*; import javax.sound.sampled.*; import javax.sound.sampled.spi.*; import java.util.regex.*; import javax.xml.parsers.*; import javax.xml.transform.*; import javax.xml.transform.dom.*; import javax.xml.transform.sax.*; import javax.xml.transform.stream.*; import org.xml.sax.*; import org.xml.sax.ext.*; import org.xml.sax.helpers.*; public class PointCalculations extends PApplet {public void setup(){
  Vect A = new Vect(1,2);
  Vect B = new Vect(3,4);
  int arraySize = 10;
  Vect[] vectArray = new Vect[arraySize];
  
  for(int i=0; i<arraySize; i++){
    vectArray[i] = new Vect(2);
    vectArray[i].n[0] = i*10+random(-10,10);
    vectArray[i].n[1] = i*10+random(-10,10);
    
    
  }
  
  A.directionalFunction2D(B);
  regressionFunction2D(vectArray);
}

public void draw(){

}
public void regressionFunction2D(Vect[] array){
  Vect deltaArray = new Vect(2);
  float regressionNumber = 0;
  
  for(int i=0; i<array.length-1; i++){
    deltaArray.add(array[i+1]);
    deltaArray.sub(array[i]);
  }
  
  /*
  for(int i=0; i<array.length; i++){
    regressionNumber += abs(array[i].n[1] -(array.directionalFunction2D(array[i], "slope") ))
  }
  */
  
  deltaArray.div(array.length);
  println("Delta Array: (" + deltaArray.n[0] + ", " + deltaArray.n[1] + ")");
  
  
  
  deltaArray.directionalFunction2D(new Vect(0,0));
}
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

  public void setZero(){
    for(int i = 0; i < n.length; i++){
      n[i] = 0;
    }
  }

  public void set(float value, int place) {
    n[place] = value;
  }

  public void set(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] = array[i];
    }
  }

  public void set(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] = v.n[i];
    }
  }

  //basic math

  //add
  public void add(float[] array) {
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] += array[i];
    }
  }

  public void add(Vect v) {
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] += v.n[i];
    }
  }

  //subtract
  public void sub(float[] array) {
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] -= array[i];
    }
  }

  public void sub(Vect v) {
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] -= v.n[i];
    }
  }

  //multiply
  public void mult(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] *= array[i];
    }
  }

  public void mult(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] *= v.n[i];
    }
  }

  public void mult(float a){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] *= a;
    }
  }

  //divide
  public void div(float[] array){
    int l1 = array.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] /= array[i];
    }
  }

  public void div(Vect v){
    int l1 = v.n.length;
    int l2 = n.length;
    int m = min(l1,l2);
    for(int i = 0; i < m; i++){
      n[i] /= v.n[i];
    }
  }

  public void div(float a){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] /= a;
    } 
  }

  //other functions

  public void normalize() { //NOTE: the normalize function's calculation method may only work for 2 dimensions
    float m = magnitude();
    if (m > 0) {
      div(m);
    }
  }

  public void negativize(){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] *= -1;
    } 
  }

  //random
  public void randomize(){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(-1,1);
    }
  }

  public void randomize(float magnitude){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(-1,1)*magnitude;
    }
  }

  public void randomize(float minimum, float maximum){
    int l = n.length;
    for(int i = 0; i < l; i++){
      n[i] = random(minimum, maximum);
    }
  }


  //read functions

  public float magnitude(){
    int l = n.length;
    float tmp = 0;
    for(int i = 0; i < l; i++){
      tmp += pow(n[i],2);
    }
    return (float) Math.sqrt(tmp);
  }
  
  public float directionalFunction2D(Vect a, String returnType){
    float tmp = 0;
    if(n.length == 2 && a.n.length == 2){
      Vect delta = new Vect(n);
      delta.sub(a);
      float slope = delta.n[1]/delta.n[0];
      float interseptY = a.n[1]-(slope*a.n[0]);
      float interseptX = -interseptY/slope;

      if(returnType == "slope") tmp = slope;
      if(returnType == "interseptY") tmp = interseptY;
      if(returnType == "interseptX") tmp = interseptX;
    } 
    else {
      println("DirectionalFunction() was disabled, due to dimentional unstability");
    }
    return tmp;
  }

  //print functions

  public void debug(){
    int l = n.length;
    println("-- VECT DATA --");
    for(int i = 0; i < l; i++) print(n[i] + ", ");
    println();
  }

  public void debug(String name){
    int l = n.length;
    println("-- VECT '" + name + "' DATA --");
    for(int i = 0; i < l; i++) print(n[i] + ", ");
    println();
  }

  public void directionalFunction2D(Vect a){
    if(n.length == 2 && a.n.length == 2){
      Vect delta = new Vect(n);
      delta.sub(a);
      float slope = delta.n[1]/delta.n[0];
      float interseptY = a.n[1]+slope*a.n[0];
      float interseptX = -interseptY/slope;

      println(" - Calculation of a straight line based on two points");
      println("Point 1 = (" + n[0] + "," + n[1] + ")" + ", Point 2 = (" + a.n[0] + "," + a.n[1] + ")");
      println("Function: y = x*" + slope + " + " + interseptY);
      println("Slope: " + slope);
      println("Intersept on the Y-axis: " + interseptY);
      println("Intersept on the X-axis: " + interseptX);
      println("End - ");
    } 
    else {
      println("DirectionalFunction() was disabled, due to dimentional unstability");
    }
  }
}

  static public void main(String args[]) {     PApplet.main(new String[] { "PointCalculations" });  }}