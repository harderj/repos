// documentation

String for1, in1, for2, in2, for3, in3;
boolean hit1, hit2, hit3;

void setup(){
  size(200,300);
  for1 = "abe";
  in1 = "dejlig abemad";

  for2 = "snot";
  in2 = "nisse";

  for3 = "enormelars";
  in3 = "lilleper";

  hit1 = searchString(for1, in1);
  hit2 = searchString(for2, in2);
  hit3 = searchString(for3, in3);

  println(hit1);
  println(hit2);
  println(hit3);
}

void draw(){
  background(0);
}

