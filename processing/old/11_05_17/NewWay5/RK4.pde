

Part evaluate(Part initial, float t, float dt, Part d) {
  Part state = new Part();
  state.z.x = initial.z.x + d.z.x*dt;
  state.z.y = initial.z.y + d.z.y*dt;
  state.v.x = initial.v.x + d.v.x*dt;
  state.v.y = initial.v.y + d.v.y*dt;

  Part output = new Part();
  output.z.x = state.v.x;
  output.z.y = state.v.y;
  output.v = acceleration(state, t+dt);
  return output;
}


void RK4(Part state, float t, float dt){
  Part a = evaluate(state, t, 0.0f, new Part());
  Part b = evaluate(state, t+dt*0.5f, dt*0.5f, a);
  Part c = evaluate(state, t+dt*0.5f, dt*0.5f, b);
  Part d = evaluate(state, t+dt, dt, c);
  
  Vect dzdt = new Vect();
  Vect dvdt = new Vect();
  dzdt.x = 1.0f/6.0f * (a.z.x + 2.0f*(b.z.x + c.z.x) + d.z.x);
  dzdt.y = 1.0f/6.0f * (a.z.y + 2.0f*(b.z.y + c.z.y) + d.z.y);
  dvdt.x = 1.0f/6.0f * (a.v.x + 2.0f*(b.v.x + c.v.x) + d.v.x);
  dvdt.y = 1.0f/6.0f * (a.v.y + 2.0f*(b.v.y + c.v.y) + d.v.y);

  state.z.x += dzdt.x * dt;
  state.z.y += dzdt.y * dt;
  
  state.v.x += dvdt.x * dt;
  state.v.y += dvdt.y * dt;
}
