void solve(){
  for(int i=0; i<1000; i++){
    picked = floor(random(cards.size()));
    
    if(((Card) cards.get(picked)).n != 1){
      int tmpR = floor(random(4));
      checkSwap(((Card) cards.get(tmpR)).x, ((Card) cards.get(tmpR)).y);
    }
  }
}

void bodilAlgorithm(){
  int counter = 0;
  Card es = new Card(((Card) cards.get(0)));
  
  if(es.x == 1){
    
  }
  else {
    Card next = new Card(((Card) cards.get(findCard(es.x-1, es.y))));
    
    if(next.n == 13){
      
    }
    else {
      Card fit = new Card(((Card) cards.get(findCard(next.n+1, next.s))));
      
      int tmpS = -1;
      for(int i=0; i<(fit.x-1); i++){
        Card tmpI = new Card(((Card) cards.get(findCard(i+1, fit.y))));
        
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
      
      if(tmpS != -1){
        counter += 1;
      }
    }
    
    /*
    next.n (1-13)
    next.s
    1 = hjerter
    2 = ruder
    3 = spar
    4 = klør
    */
    
  }
}
