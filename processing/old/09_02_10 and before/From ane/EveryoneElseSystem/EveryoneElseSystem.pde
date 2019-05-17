int num = 10;
int tmp = 0;

void setup(){
  size(num, num);

  for(int i=0; i<num; i++){
    int j = i+1;
    print("i=" + i + ": ");
    while(j%num != i){
      j = j%num;
      print("j=" + j + " ");
      render(j, i);
      j++;
    }
    println();
  }
}

void render(int a, int b){
  tmp++;
  tmp = tmp%num;
  stroke(a*(255/num));
  point(tmp,b);
  if(num*num<tmp) tmp = 0;
}

/*
void render(int a, int b){
  tmp++;
  tmp = tmp%num;
  stroke(a*(255/num));
  point(tmp,b);
  if(num*num<tmp) tmp = 0;
}

*/
