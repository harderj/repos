
#include <GL/glut.h>//Drawing functions
void draw(void)
{
  //Background color
  glClearColor(0,1,0,1);
  glClear(CL_COLOR_BUFFER_BIT);
  //Draw order
  glFlush();
}

//Main program
int main(int argc, char **argv)
{
  glutInit(&argc, argv);
  //Simple Buffer
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
  glutInitWindowPosition(50,25);
  glutInitWindowSize(500,250);
  glutCreateWindow("Green Window");
  //Call to the drawing function
  glutDisplayFunc(draw);
  glutMainLoop();
  return 0;
}
