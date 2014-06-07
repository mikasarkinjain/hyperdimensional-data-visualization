import java.util.Arrays;

/* HELPER CLASSES */
Graph graph;
DataParser dataParser;
Camera camera;
GUI gui;


/* GRAPH VARS */
double w = 0;


/* DATA STRUCTURES */
int dimension;
String[] varLabels;
Double[][] arrayTable;

final int BEST_FIT_MESH = 0;
final int BEST_FIT_SURFACE = 1;
final int POINTS = 2;
int viewType = BEST_FIT_SURFACE;

Double data1D;
Double[] data2D;
Double[][][] data3D;
Double[][][][] data4D;
Double[][][][] data5D; 
Double[][][][] data6D;
Double[][][][] data7D;

double incrementX;
double incrementY;
double incrementW;

int lenX;
int lenY;
int lenW;

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

// nullValuesCount[0] contains number of X values that are null, etc.
// used by dataParser.calcIncrements()
int[] nullValuesCount;

/* CAMERA VARS */ 
double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

float rotX = 0;
float rotY = 0;
float transX;
float transY;
float FOV;


/* GUI VARS */
String filePath;

double maxAxisLength;
double currentWValue;

void setup() {
  size(1000, 600, P3D);
  graph = new Graph();
  dataParser = new DataParser();
  gui = new GUI();
  camera = new Camera();
}

void draw() {
  camera.prepareCanvas();
  graph.graph();
  gui.drawUI(); // 2D stuff must be last
}

void mousePressed() {
  gui.mousePressed();
}

void mouseDragged() {
  gui.mouseDragged();
}

void keyPressed() {
  gui.keyPressed(); 
}

void keyRealeased() {
  gui.keyReleased(); 
}

void mouseMoved() {
  gui.mouseMoved();
}

void mouseWheel(MouseEvent event) {
  gui.mouseWheel(event);  
}

void fileSelected(File selection) {
 gui.fileSelected(selection);
}
