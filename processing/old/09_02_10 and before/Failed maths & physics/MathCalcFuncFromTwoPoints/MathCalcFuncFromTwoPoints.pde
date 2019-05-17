float x = -1;
float y = 2;
float x1 = 5;
float y1 = 12;

float a = (y-y1)/(x-x1);
float b = y-(a*x);

float sx = -b/a;

println("a: " + a);
println("b: " + b);
println("sx: " + sx);
