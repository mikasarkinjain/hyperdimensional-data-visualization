class GUI {
  final float ROTATE_RATE = 0.01;
  final float PAN_RATE = 4;
  final float CYCLE_RATE = 1; // changing W
  
  boolean hoveringOverLoad = false;
  boolean holdingWKey = false;

  void drawUI() {
    hoveringOverLoad = false;
    holdingWKey = false;
    
    hint(DISABLE_DEPTH_TEST); // draws as fixed 2D
    noLights(); // otherwise it breaks
    camera(); // center camera on origin
    updateMouse();

    stroke(1); // solid border
    if (hoveringOverLoad) // set in updateMouse()
      fill(200);
    else
      fill(255);
    rect(5, 5, 100, 30);

    fill(0);
    stroke(0, 255, 0);
    textSize(20);
    textAlign(CENTER, CENTER); // centered horizontally & vertically
    text("Load CSV", 5, 5, 100, 30);

    hint(ENABLE_DEPTH_TEST);
  }

  void updateMouse() {
    if (mouseOverRect(5, 5, 100, 30))
      hoveringOverLoad = true;
  }

  boolean mouseOverRect(int rectX, int rectY, int rectWidth, int rectHeight) {
    return rectX <= mouseX && rectX + rectWidth >= mouseX &&
      rectY <= mouseY && rectY + rectHeight >= mouseY;
  }

  void mousePressed() {
    if (hoveringOverLoad)
      loadFile();
  }

  void mouseDragged() {
    double changeX = (pmouseY-mouseY) * ROTATE_RATE;
    double changeY = (pmouseX-mouseX) * ROTATE_RATE;

    camera.rotate(changeX, changeY);
  }

  void keyPressed() {
    double changeX = 0; double changeY = 0;
    if (key == CODED) {
      
      switch(keyCode) {
        case LEFT: changeX = -PAN_RATE; break;
        case RIGHT: changeX = PAN_RATE; break;
        case UP: changeY = -PAN_RATE; break;
        case DOWN: changeY = PAN_RATE; break;
      }
      camera.pan(changeX, changeY);
      
    }
    else {
      if (key == 'w' || key == 'W')
        holdingWKey = true;
    }
  }
  
  void keyReleased() {
    if (key == 'w' || key == 'W')
      holdingWKey = false;
  }
  
  void mouseMoved() {
    if (holdingWKey) {
      w += (pmouseY - mouseY) * CYCLE_RATE;  
    }
  }

  void loadFile() {
    selectInput("Select CSV", "fileSelected");
  }

  void fileSelected(File selection) {
    if (selection != null)
      filePath = selection.getAbsolutePath();
    if (filePath.substring(filePath.length()-4).equals(".csv"))
      dataParser.loadData();
  }
}

