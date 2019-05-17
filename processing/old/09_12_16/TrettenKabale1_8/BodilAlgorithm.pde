void bodilAlgorithm(){
  boolean fussy = true;

  int counter = 0;
  for(int e=0; e<8; e++){
    if(e == 4 && counter == 0) fussy = false;
    Card es = new Card(((Card) cards.get(e%4)));
    if(fussy){
      print("fussy");
      if(es.x == 1){
        print("ex.x = 1");
        counter += 1;
        checkSwap(findId(2, es.s), e%4);
      }
      else {
        print("ex.x != 1");
        Card next = new Card(((Card) cards.get(findPos(es.x-1, es.y))));

        if(next.n == 13){
          print("next = 13");
        }
        else {
          print("next != 13");
          Card fit = new Card(((Card) cards.get(findId(next.n+1, next.s))));

          if(((Card) cards.get(findPos(fit.x-1, fit.y))).n == 13){
            counter -= 1;
          }
          else {
            int tmpS = -1;
            for(int i=0; i<(fit.x-1); i++){
              Card tmpI = new Card(((Card) cards.get(findPos(i+1, fit.y))));

              if(i==0){
                if(tmpI.n == 2){
                  tmpS = tmpI.s;
                }
              }
              else {
                if(tmpS != -1){
                  if(tmpI.s == tmpS && tmpI.n == tmpI.x){

                  }
                  else {
                    tmpS = -1;
                  }
                }
              }
            }
            if(tmpS > 0){
              counter += 1;
              checkSwap(findId(next.n+1, next.s), e%4);
            }
          }
        }
      }
    }
    else {
      print("anti fussy");
      if(es.x == 1){
        checkSwap(findId(2, es.s), e%4);
      }
      else {
        Card next = new Card(((Card) cards.get(findPos(es.x-1, es.y))));

        if(next.n == 13){

        }
        else {
          checkSwap(findId(next.n+1, next.s), e%4);
        }
      }
    }
  }
}



