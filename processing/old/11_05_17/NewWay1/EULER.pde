void EULER(State state, float t, float dt){
  Derivative a = evaluate(state, t, 0.0f, new Derivative());
  
  float dxdt = a.dx;
  float dvdt = a.dv;
  
  state.x = state.x + dxdt * dt;
  state.v = state.v + dvdt * dt;
}
