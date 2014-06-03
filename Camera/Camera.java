boolean holdingW = false;
boolean holdingShift = false;
// set to false every draw()

void mouseWheel(MouseWheelEvent e) {
    // zoom
}

void mouseDragged() {
  double WRate = 0.01;
  double XYRate = 0.01;

  if (holdingW && dimension >= 4) {
    currentW *= (pmouseY - mouseY) * WRate;
  }

  else if (holdingShift) {
    // translate
  }

  else {
    rotx += (pmouseY-mouseY) * rate;
    roty += (mouseX-pmouseX) * rate;
  }
}

void keyPressed() {
  if (key == CODED && keyCode == SHIFT)
    holdingShift = true;

  else if (key == "w" || key == "W")
    holdingW = true;
}

void keyReleased() {
  if (key == CODED && keyCode == SHIFT)
    holdingShift = false;

  else if (key == "w" || key == "W")
    holdingW = false;
}
