int randomGene() {
  return round(random(3))%3;
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
