
int a1 = 3;
int a2 = 5;

for(int i=0; i<50; i++){
  println(a1);
  ellipse(float(i+2)/54*width, height*0.5-height*0.1*a1, 10,10);
  a1 = a1 - a2;
  a2 = a1 + a2;
}
