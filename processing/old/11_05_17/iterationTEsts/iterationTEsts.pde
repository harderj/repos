
double t0 = 5.0;
double dt = 0.01;
double tn = 10.0;
float mil = millis();

double t=t0;
double v = 0;
double x = exp((float)t0);
while(t<tn){
  v=exp((float)t);
  x+=v*dt;
  
  t += dt;
  println("exp:" + exp((float)(t)) + " & x:" + x + " & ∆:" + x/exp((float)(t)));
}
