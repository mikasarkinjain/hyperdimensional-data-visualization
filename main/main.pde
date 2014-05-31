Table data;

double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

int dimension;

Double data1D;
Double[] data2D;
Double[][] data3D;
Double[][][] data4D;
Double[][][][] data5D;
Double[][][][][] data6D;
Double[][][][][][] data7D;

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

String viewType;

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
  if (viewType.equals("point"){
    for (int i = 0; i < data3D.length; i++){
      for (int j = 0; j < data3D[i].length; j++){
        if (data3D[i][j] != null){
          point(i-(minX+maxX)/2, j-(minY+maxY)/2, data3D[i][j]-(minZ+maxZ)/2); //does this method exist?
        }
      }
    }
  }
  
  if (viewType.equals("frame"){
    for (int i = 0; i < data3D.length - 1; i++){
      for (int j = 0; j < data3D[i].length - 1; j++){
        startSolid(); //does this method exist?
        if (data3D[i][j] != null){
          vertex(i-(minX+maxX)/2, j-(minY+maxY)/2, data3D[i][j]-(minZ+maxZ)/2);
        }
        if (data3D[i+1][j] != null){
          vertex(i+1-(minX+maxX)/2, j-(minY+maxY)/2, data3D[i+1][j]-(minZ+maxZ)/2);
        }
        if (data3D[i+1][j+1] != null){
          vertex(i+1-(minX+maxX)/2, j+1-(minY+maxY)/2, data3D[i+1][j+1]-(minZ+maxZ)/2);
        }
        if (data3D[i][j+1] != null){
          vertex(i-(minX+maxX)/2, j+1-(minY+maxY)/2, data3D[i][j+1]-(minZ+maxZ)/2);
        }
        endFace(); //does this method exist?
      }
    }
  }
    
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
    //if (filePath.indexOf("csv") != -1) //bad way to check
    if (filePath.substring(filePath.length()-4).equals(".csv")//should we even be checking csv extension, what if user imports txt file w. data - maybe we should use a try and except
      loadData();  
}

void loadData() {
  data = loadTable(filePath, "header"); // "header" indicates that there's a header 
  println(data);  
}
