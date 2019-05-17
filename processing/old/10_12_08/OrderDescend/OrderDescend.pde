int num = 10;

void setup(){

  int[] pushList = new int[num];

  for(int i=0; i<num; i++) pushList[i] = (int)random(10);

  int[] pushRes = pushIntoArray(-1, pushList, 2);

  println("==== PushIntoArray function results: ====");
  println("Before:----------------------------------");
  println(pushList);
  println("After:-----------------------------------");
  println(pushRes);

  float[] orderList = new float[num];

  for(int i=0; i<num; i++) orderList[i] = random(1);

  int[] order = orderDescend(orderList);

  float[] orderRes = changeOrder(orderList, order);

  println("==== OrderDescend function results: ====");
  println("Before:---------------------------------");
  println(orderList);
  println("Order:----------------------------------");
  println(order);
  println("After:----------------------------------");
  println(orderRes);
}

int[] pushIntoArray(int a, int[] l, int s){ // a = number l = list | s = startpoint of push
  int lth = l.length; // lth = length of list
  if(lth<s) return null;
  int[] tmp = new int[lth];
  for(int i=lth-1; i>=0; i--){ // important that the 'if(i==s)' statement is last, as 'a' would be copied
    if(i>s) tmp[i] = l[i-1];
    if(i==s) tmp[i] = a;
    if(i<s) tmp[i] = l[i];
  }
  return tmp;
}

void draw(){

}

int[] orderDescend(float[] l){
  int lth = l.length; // lth = length of list
  int[] tmp = new int[lth];
  for(int i=0; i<lth; i++) tmp[i] = 0;

  for(int i=0; i<lth; i++){
    int n = 0;
    while(n<i){
      //println("i: " + i + " | n: " + n + " | l[i]: " + l[i] + " | tmp[n]: " + tmp[n] + " | l[tmp[n]]: " + l[tmp[n]]);
      //println(tmp);
      if(l[i]<l[tmp[n]]) n++;
      else break;
    }
    tmp = pushIntoArray(i, tmp, n);
  }

  return tmp;
}

float[] changeOrder(float[] l, int[] o){
  int lth = l.length;
  if(lth != o.length) return null;
  float[] tmp = new float[lth];
  for(int i=0; i<lth; i++){
    tmp[i] = l[o[i]];
  }
  return tmp;
}

