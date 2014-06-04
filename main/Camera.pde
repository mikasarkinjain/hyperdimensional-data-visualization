class Camera {
  Camera() {
    transX = width / 2.;
    transY = height / 2.;
    FOV = PI / 3;
  }

  void prepareCanvas() {
    background(0);
    lights();
    translate(transX, transY, -100);
    rotateX(rotX);
    rotateY(rotY);
      
    float cameraY = height/2.0;
    float cameraZ = cameraY / tan(FOV / 2.0);
    perspective(FOV, width/height, cameraZ / 10.0, cameraZ * 10.0);
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

