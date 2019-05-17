int num = 4;
for(int i=0; i<num; i++){
  int j = i+1;
  int debugger = 0;
  print("i=" + i + ": ");
  while(j%num != i && debugger < 1000){
    j = j%num;
    debugger ++;
    print("j=" + j + " ");
    j++;
  }
  println();
}
