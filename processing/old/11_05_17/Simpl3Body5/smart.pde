String simplify(String s){
  char[] c = new char[s.length()];
  int[] v = new int[s.length()];
  for(int i=0; i<s.length(); i++){
    c[i]=0;
    v[i]=0;
    int j=0;
    while(j<i && c[i] != c[j]) j++;
    c[j] = s.charAt(i);
    v[j] +=1;
    println(j);
  }
  String r = "";
  for(int i=0; i<s.length(); i++){
    r+=c[i];
    if(v[i] > 1) r+="^"+v[i];
  }
  return r;
}
