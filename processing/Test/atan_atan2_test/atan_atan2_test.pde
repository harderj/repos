

PVector a = new PVector(2,3);

float tmp1=2*atan(a.y/(sqrt(a.x*a.x+a.y*a.y)+a.x));
float tmp2=atan2(a.y, a.x);

println(tmp1 + " : " + tmp2);

/*
int num = 10;
for(int i=0; i<num; i++){
  float tmp = TWO_PI/num*i;
  println(atan(tmp) + " : " + atan2(-sin(tmp), -cos(tmp)));
}
*/
