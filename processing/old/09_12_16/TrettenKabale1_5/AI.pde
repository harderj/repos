void solve(){
  for(int i=0; i<1000; i++){
    picked = floor(random(cards.size()));
    
    if(((Card) cards.get(picked)).n != 1){
      int tmpR = floor(random(4));
      checkSwap(((Card) cards.get(tmpR)).x, ((Card) cards.get(tmpR)).y);
    }
  }
}
