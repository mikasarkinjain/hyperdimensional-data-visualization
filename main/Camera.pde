class Camera {
  void prepareCanvas() {
    background(0);
    lights();
    translate(width/2.0, height/2.0, -100);
    rotateX(rotx);
    rotateY(roty);
  }
}

