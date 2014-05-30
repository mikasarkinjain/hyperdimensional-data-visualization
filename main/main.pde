Table data;

double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

int dimension;

double data1D;
double[] data2D;
double[][] data3D;
double[][][] data4D;
double[][][][] data5D;
double[][][][][] data6D;
double[][][][][][] data7D;

double maxX; 
double minX; 
double maxY; 
double minY; 
double maxZ; 
double minZ; 
double maxW; 
double minW; 
double maxU; 
double minU; 
double maxV; 
double minV; 

boolean hoverOverButton;

String filePath;

void setup() {
  size(960, 540, P3D); //this code is from the "Move Eye" example
  fill(204); //this code is from the "Move Eye" example
}

void draw() {
  update3DView();
  graph();
  drawUI(); // 2D stuff must be last
}

void drawUI() {
  hint(DISABLE_DEPTH_TEST); // draws as fixed 2D
  noLights(); // otherwise it breaks
  camera(); // center camera on origin
  updateMouse();
  
  stroke(1); // solid border
  if (hoverOverButton) // set in updateMouse()
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

void graph(){
  lights(); //this code is from the "Move Eye" example
  
  noStroke(); //this code is from the "Move Eye" example
  fill(255);
  box(90); //this code is from the "Move Eye" example
  stroke(255); //this code is from the "Move Eye" example
  line(-100, 0, 0, 100, 0, 0); //this code is from the "Move Eye" example
  line(0, -100, 0, 0, 100, 0); //this code is from the "Move Eye" example
  line(0, 0, -100, 0, 0, 100); //this code is from the "Move Eye" example
}

void update3DView(){
  background(0); //this code is from the "Move Eye" example
  
  // Change height of the camera with mouseY 
  camera(30.0, mouseY, 220.0, // eyeX, eyeY, eyeZ //this code is from the "Move Eye" example
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  }
  
void updateMouse() {
  if (mouseOverRect(5, 5, 100, 30))
    hoverOverButton = true;
  else
    hoverOverButton = false;
}

boolean mouseOverRect(int rectX, int rectY, int rectWidth, int rectHeight) {
  return rectX <= mouseX && rectX + rectWidth >= mouseX &&
         rectY <= mouseY && rectY + rectHeight >= mouseY;
}

void mousePressed() {
  if (hoverOverButton)
    loadFile(); 
}

void loadFile() {
  selectInput("Select CSV", "fileSelected");  
}

void fileSelected(File selection) {
  if (selection != null)
    filePath = selection.getAbsolutePath();
    if (filePath.indexOf("csv") != -1)
      loadData();  
}

void loadData() {
  data = loadTable(filePath, "header"); // "header" indicates that there's a header 
  println(data);  
}
