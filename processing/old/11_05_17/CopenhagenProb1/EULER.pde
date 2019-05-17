void EULER(State state, float t, float dt){
  Derivative a = evaluate(state, t, 0.0f, new Derivative());
  
  Vect dzdt,dvdt;
  dzdt = a.dz;
  dvdt = a.dv;
  
  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}
