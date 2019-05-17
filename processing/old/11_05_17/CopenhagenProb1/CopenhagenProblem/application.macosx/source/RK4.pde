

Derivative evaluate(State initial, float t, float dt, Derivative d) {
  State state = new State();
  state.z.x = initial.z.x + d.dz.x*dt;
  state.z.y = initial.z.y + d.dz.y*dt;
  state.v.x = initial.v.x + d.dv.x*dt;
  state.v.y = initial.v.y + d.dv.y*dt;

  Derivative output = new Derivative();
  output.dz.x = state.v.x;
  output.dz.y = state.v.y;
  output.dv = acceleration(state, t+dt);
  return output;
}


void RK4(State state, float t, float dt){
  Derivative a = evaluate(state, t, 0.0f, new Derivative());
  Derivative b = evaluate(state, t+dt*0.5f, dt*0.5f, a);
  Derivative c = evaluate(state, t+dt*0.5f, dt*0.5f, b);
  Derivative d = evaluate(state, t+dt, dt, c);
  
  Vect dzdt = new Vect();
  Vect dvdt = new Vect();
  dzdt.x = 1.0f/6.0f * (a.dz.x + 2.0f*(b.dz.x + c.dz.x) + d.dz.x);
  dzdt.y = 1.0f/6.0f * (a.dz.y + 2.0f*(b.dz.y + c.dz.y) + d.dz.y);
  dvdt.x = 1.0f/6.0f * (a.dv.x + 2.0f*(b.dv.x + c.dv.x) + d.dv.x);
  dvdt.y = 1.0f/6.0f * (a.dv.y + 2.0f*(b.dv.y + c.dv.y) + d.dv.y);

  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}
