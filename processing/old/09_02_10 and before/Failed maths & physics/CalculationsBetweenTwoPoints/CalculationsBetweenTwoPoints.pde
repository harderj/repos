Vect pointOne, pointTwo;

float a = (y-y1)/(x-x1);
float b = y-(a*x);

float sx = -b/a;

println(" - Calculation of a straight line based on the two points - ");
println("Slope: " + a);
println("Intersept on the Y-axis: " + b);
println("Intersept on the X-axis: " + sx);
println("Function: y = x*" + a + " + " + b);
