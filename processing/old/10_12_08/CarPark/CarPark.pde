int slotStartNumber = 500;
int business = 20;
int holiday = 10;
float holipay = 6.0;
float busipay = 10.0;

float yield;

ArrayList slots;
PFont font;
int time;
String weekDay;
String[] wd;

void setup(){

  size(600,700);
  smooth();

  slots = new ArrayList();
  font = loadFont("Serif-48.vlw");
  time = 0;
  weekDay = "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday";
  wd = split(weekDay, ',');


  for(int i=0; i<slotStartNumber; i++){

    slots.add(new Slot());

    //((Slot) slots.get(i)).set((int) random(4));

  }

}


void draw(){
  //cycle();
}

void cycle(){
  
  background(255);

  /*
  for(int i=0; i<business+random(5); i++) addOne(1);
   for(int i=0; i<holiday+random(5); i++) addOne(2);
   

  int[] holi = { int(0.08*200),int(0.09*200),int(0.09*200),int(0.12*200),int(0.22*200),int(0.28*200),int(0.12*200)     };
  int[] busi = { int(0.09*500),int(0.19*500),int(0.17*500),int(0.16*500),int(0.15*500),int(0.16*500),int(0.08*500)     };

  addMult(1, holi[time%7]);
  addMult(2, busi[time%7]);
  
  */
  
  for(int i=0; i<int(500.0/7.0); i++) addOne(2);

  int num = 2;
  int slotNum = slots.size();
  int sqrtSlotNum = (int)sqrt(slotNum);
  float siz = (float)width/(float)(sqrtSlotNum + num);
  for(int i=0; i<slotNum; i++){
    float x = (i%sqrtSlotNum)*siz + siz;
    float y = (i/sqrtSlotNum)*siz + siz;
    ((Slot) slots.get(i)).draw(x, y, siz*0.5);
  }

  fill(0);
  textFont(font, 20);
  text("Time: " + time, width*0.5, height-height*0.02);
  text("Day: " + wd[time%7], width*0.5, height-height*0.05);
  text("Yield: " + yield, width*0.5, height-height*0.09);

  time ++;
}

void mousePressed(){
  cycle();
}

void addOne(int k){
  int n = 0;
  while(((Slot) slots.get(n)).occ != 0 && n < 500) n++;
  ((Slot) slots.get(n)).set(k);
}

void addMult(int k, int c){
  for(int i=0; i<c; i++) addOne(k);
}



