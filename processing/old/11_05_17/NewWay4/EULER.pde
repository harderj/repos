void EULER(Part state, float t, float dt){
  Part a = evaluate(state, t, 0.0f, new Part());
  
  Vect dzdt,dvdt;
  dzdt = a.z;
  dvdt = a.v;
  
  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}
