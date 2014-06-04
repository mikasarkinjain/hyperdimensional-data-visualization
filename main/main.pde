import java.util.Arrays;

Table data;

double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

int dimension;

String[] varLabels;
double[][] arrayTable;

Double data1D;
Double[] data2D;
Double[][] data3D;
Double[][][] data4D;
Double[][][][] data5D; 
Double[][][][] data6D;
Double[][][][] data7D;

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
double maxT;
double minT;

double incrementX;
double incrementY;
double incrementW;

int lenX;
int lenY;
int lenW;

boolean hoverOverButton;

String filePath;

double maxAxisLength;

double currentWValue;

void setup() {
  size(1000, 600, P3D);
  fill(3);
}

void draw() {
  prepareCanvas();
  graph();
  drawUI(); // 2D stuff must be last
}

void prepareCanvas() {
  background(0);
  lights();
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty); 
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
    if (filePath.substring(filePath.length()-4).equals(".csv"))
      loadData();  
}
