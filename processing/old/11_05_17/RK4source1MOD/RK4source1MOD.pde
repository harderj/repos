class Part {
  float x, y, vx, vy;

  Part(float _x, float _y,float _vx,float _vy) {
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
  }
}

void setup() {
  int n=2;
  Part[] particle = new Part[2];
  particle[0] = new Part(0,1,1,0);
  particle[1] = new Part(1,0,0,1);
}

float[] x = coordinates of all particles in PHASE SPACE, i.e. including velocities:
x[0] = particle[0].position.x, x[1] = particle[0].position.y, 
x[2] = particle[0].velocity.vx, x[3] = particle[0].velocity.vy, 
x[4] = particle[1].position.x, etc.

float t = current time
float h = time step

//evaluate derivatives wrt t of each variable in x array, load into dxdt (assumed pre-initialized to correct length)
void rhs_eval(float t, float[] x, float[] dxdt) {
  if (dxdt.length != x.length) { 
    return;
  } //add some error-handling code here, because array lengths must be equal
  int POSX = 0; //defined merely for clarity below
  int POSY = 1;
  int VELX = 2;
  int VELY = 3;
  for (int i=0; i<x.length; i += 4) {
    dxdt[i+POSX] = x[i+VELX]; //derivative of position is velocity
    dxdt[i+POSY] = x[i+VELY];
    float ax = 0;
    float ay = 0;
    for (int j=0; j<x.length; j += 4) {
      if(i!=j) {

        float dx = x[i+POSX]-x[j+POSX];
        float dy = x[i+POSX]-x[j+POSX];
        float dist2 = dx*dx+dy*dy;
        float idist2 = 1/dist2;
        float ang = atan2(dy, dx);//180/PI*atan( (dy/dx) );
        float sinu = sin(ang);
        float cosi = cos(ang);

        ax += -idist2*cosi*p2.m*kG;
        ay += -idist2*sinu*p2.m*kG;
      }
    }
    dxdt[i+VELX] = ax; // [x component of the acceleration for particle i/4 based on time and configuration passed (t and x)];
    dxdt[i+VELY] = ay; //[same for y component];
  }
}

//depends on rhs_eval function - Java doesn't have a simple mechanism for passing functions, so we treat it as a global function
void rk4_fixed (float t, float[] x, float h) {
  int n = x.length;

  // Declare local arrays
  float[] k1, k2, k3, k4, f, dxdt;

  k1 = new float[n];
  k2 = new float[n];
  k3 = new float[n];
  k4 = new float[n];
  f = new float[n];
  dxdt = new float[n];

  // Zeroth intermediate step 
  rhs_eval(t, x,dxdt);
  for (int j = 0; j < n; j++) {
    k1[j] = h * dxdt[j];
    f[j] = x[j] + k1[j] / 2.;
  }

  // First intermediate step 
  rhs_eval(t + h / 2., f,dxdt);
  for (int j = 0; j < n; j++) {
    k2[j] = h * dxdt[j];
    f[j] = x[j] + k2[j] / 2.;
  }

  // Second intermediate step
  rhs_eval(t + h / 2., f,dxdt);
  for (int j = 0; j < n; j++) {
    k3[j] = h * dxdt[j];
    f[j] = x[j] + k3[j];
  }

  // Third intermediate step 
  rhs_eval(x + h, f, dxdt);
  for (int j = 0; j < n; j++) {
    k4[j] = h * dxdt[j];
  }

  // Actual step 
  for (int j = 0; j < n; j++) {
    x[j] += k1[j] / 6. + k2[j] / 3. + k3[j] / 3. + k4[j] / 6.;
  }
  x += h;

  return;
}



void draw() {
}

