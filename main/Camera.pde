class Camera {
  Camera() {
    transX = width / 2;
    transY = height / 2;
    FOV = PI / 3;
  }

  void prepareCanvas() {
    background(BACKGROUND_SHADE);
    lights();
    translate(transX, transY, -100);
    rotateX(rotX);
    rotateY(rotY);
      
    float cameraZ = (height/2.0) / tan(FOV/2.0);
    perspective(FOV, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
  }

  void rotate(double x, double y) {
    rotX += x;
    rotY += y;
  }

  void pan(double x, double y) {
    transX += x;
    transY += y;
  }
  
  void zoom(double multiplier) {
    FOV *= multiplier;
  }
}
