//By Jacob Harder, 2:3:2010
//found equations at: source: http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/fibFormula.html

//(pow(((1+sqrt(5))/2), n)-pow(((1-sqrt(5))/2), n))*(1/sqrt(5));

int start=-30;
int end=30;

background(255);
size(500,500);

float xScale=((float)width/float((end)-start));
float yScale=width/pow(end-start, 2);

line(float(-start)*xScale,0,float(-start)*xScale,height);
line(0,height*0.5,width,height*0.5);

strokeWeight(2);
noFill();

float sqrt5 = sqrt(5);
float asqrt5 = 1/sqrt5;
float Phi = (1+sqrt5)/2;
float negphi = (1-sqrt5)/2;

int i=start;
stroke(0);
beginShape();
while(i<end+1){
  int a = round((pow(Phi, i)-pow(negphi, i))*asqrt5); //round((pow(((1+sqrt(5))/2), i)-pow(((1-sqrt(5))/2), i))*(1/sqrt(5)))
  println(a);
  vertex(float(i-start)*xScale, 0.5*height-a*yScale);
  //vertex(float(i-start)*xScale, 0.5*height-log(a)*10);
  i++;
}
endShape();

float n=1.5;
println((pow(((1+sqrt(5))/2), n)-pow(((1-sqrt(5))/2), n))*(1/sqrt(5)));

