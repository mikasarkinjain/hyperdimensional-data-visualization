import java.util.Arrays;

/* HELPER CLASSES */
Graph graph;
DataParser dataParser;
Camera camera;
GUI gui;


/* DATA STRUCTURES */
int dimension;
String[] varLabels;
double[][] arrayTable;

String viewType = "best-fit surface";

Double data1D;
Double[] data2D;
Double[][] data3D;
Double[][][] data4D;
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


/* CAMERA VARS */ 
double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

float rotX = PI;
float rotY = 0;
float transX;
float transY;


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
