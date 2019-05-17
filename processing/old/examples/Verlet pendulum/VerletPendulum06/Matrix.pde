class Matrix {
  float[][] m = new float[4][4];

  Matrix() {
    for(int i = 0 ; i < 4 ; i++) {
      for(int j = 0 ; j < 4 ; j++) {
        if(i == j) m[i][j] = 1;
        else m[i][j] = 0;
      }
    }
  }
  
  Matrix(Matrix m) {
    for(int i = 0 ; i < 4 ; i++) {
      for(int j = 0 ; j < 4 ; j++) {
        this.m[i][j] = m.m[i][j];
      }
    }
  }

  void applyTransform(Vect3 v) {
    float x, y, z;
    x = v.x * m[0][0] + v.y * m[1][0] + v.z * m[2][0] + m[3][0];
    y = v.x * m[0][1] + v.y * m[1][1] + v.z * m[2][1] + m[3][1];
    z = v.x * m[0][2] + v.y * m[1][2] + v.z * m[2][2] + m[3][2];
    v.x = x;
    v.y = y;
    v.z = z;
  }
  
  Vect3[] applyTransform(Vect3[] v) {
    float x, y, z;
    Vect3[] transformed = new Vect3[v.length];
    for(int i = 0 ; i < v.length ; i++) {
      x = v[i].x * m[0][0] + v[i].y * m[1][0] + v[i].z * m[2][0] + m[3][0];
      y = v[i].x * m[0][1] + v[i].y * m[1][1] + v[i].z * m[2][1] + m[3][1];
      z = v[i].x * m[0][2] + v[i].y * m[1][2] + v[i].z * m[2][2] + m[3][2];
      transformed[i] = new Vect3(x,y,z);
    }
    return transformed;
  }
  
  Vect3 getTransformed(Vect3 v) {
    float x, y, z;
    x = v.x * m[0][0] + v.y * m[1][0] + v.z * m[2][0] + m[3][0];
    y = v.x * m[0][1] + v.y * m[1][1] + v.z * m[2][1] + m[3][1];
    z = v.x * m[0][2] + v.y * m[1][2] + v.z * m[2][2] + m[3][2];
    return new Vect3(x,y,z);
  }
  
  Vect3 getRotated(Vect3 v) {
    float x, y, z;
    x = v.x * m[0][0] + v.y * m[1][0] + v.z * m[2][0];
    y = v.x * m[0][1] + v.y * m[1][1] + v.z * m[2][1];
    z = v.x * m[0][2] + v.y * m[1][2] + v.z * m[2][2];
    return new Vect3(x,y,z);
  }

  void rotate(float x, float y, float z) {
    Matrix n = new Matrix();
    n.m[0][0] = cos(y) * cos(z);
    n.m[0][1] = sin(z);
    n.m[0][2] = sin(y);
    n.m[1][0] = -1.0 * sin(z);
    n.m[1][1] = cos(x) * cos(z);
    n.m[1][2] = sin(x);
    n.m[2][0] = -1.0 * sin(y);
    n.m[2][1] = -1.0 * sin(x);
    n.m[2][2] = cos(x) * cos(y);
    n.m[3][0] = 0;
    n.m[3][1] = 0;
    n.m[3][2] = 0;
    
    multiply(n);
  }
  
  void multiply(Matrix n) {
    float[][] o = new float[4][4];
    for(int i = 0 ; i < 4 ; i++) {
      for(int j = 0 ; j < 4 ; j++) {
        o[i][j] = m[0][j]*n.m[i][0] + m[1][j]*n.m[i][1] + m[2][j]*n.m[i][2] + m[3][j]*n.m[i][3];
      }
    }
    m = o;
  }

  void translate(float x, float y, float z) {
    m[3][0] += x;
    m[3][1] += y;
    m[3][2] += z;
  }

  void translate(Vect3 v) {
    m[3][0] += v.x;
    m[3][1] += v.y;
    m[3][2] += v.z;
  }
}
