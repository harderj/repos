int num = 100;

for(int i=0; i<num; i++){
  float angle = (TWO_PI/num)*i;
  println("--- " + angle + " ---");
  println("Cos: " + cos(angle));
  println("Sin: " + sin(angle));
}

println(sin(HALF_PI));
