int num = 100;
int tmp = 0;

void setup(){
  size(num, num);

  for(int j = 0; j<num; j++){
    int i = (j+1)%num;
    while(i != j){
      render(i, j);
      i = (i+1)%num;
    }
  }
}

void render(int a, int b){
  tmp = (tmp+1)%(num-1);
  stroke(a*(255/num));
  point(tmp,b);
  if(num*num<tmp) tmp = 0;
}
