Table data;

double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

int dimension;

String[] varLabels;
double[][] dataTable;

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

boolean hoverOverButton;

String viewType;

String filePath;

double maxAxisLength;

double currentWValue;

void setup() {
  size(960, 540, P3D); //this code is from the "Move Eye" example
  fill(204); //this code is from the "Move Eye" example
}

void draw() {
  update3DView();
  //graph3D();
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

//void graph3D(){
//  if (viewType.equals("point")){
//    noStroke(); 
//    fill(0, 0, 255); //blue for now, should be changed
//    
//    double xcor, ycor, zcor;
//    
//    for (int i = 0; i < data3D.length; i++){
//      for (int j = 0; j < data3D[i].length; j++){
//        if (data3D[i][j] != null){
//          
//          xcor = (i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
//          ycor = (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
//          zcor = (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
//          
//          translate(-xcor, -ycor, -zcor);
//          sphere(2);
//          translate(xcor, ycor, zcor);
//        
//        }
//      }
//    }
//  }
//  else{
//  
//    if (viewType.equals("frame")){
//      stroke(255); //white for now, should be changed
//      noFill();
//    }
//    else if (viewType.equals("surface")){
//      noStroke();
//      fill(255, 0, 0); //red for now, should be changed
//    }
//    else{
//      return;
//    }
//    
//    for (int i = 0; i < data3D.length - 1; i++){
//      for (int j = 0; j < data3D[i].length - 1; j++){
//        startShape(); 
//        if (data3D[i][j] != null){
//          vertex((i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (data3D[i][j]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
//        }
//        if (data3D[i+1][j] != null){
//          vertex((i+1-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (data3D[i+1][j]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
//        }
//        if (data3D[i+1][j+1] != null){
//          vertex((i+1-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (j+1-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (data3D[i+1][j+1]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
//        }
//        if (data3D[i][j+1] != null){
//          vertex((i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (j+1-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
//                 (data3D[i][j+1]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
//        }
//        endShape(CLOSE); 
//      }
//    }
//
//  }
//
//}

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
    if (filePath.substring(filePath.length()-4).equals(".csv"))
      loadData();  
}

void loadData() {
  loadAsTable();
  getDataBoundaries();
  loadAsArray();
}

// Loads file into `dataTable` 
void loadAsTable() {
  // don't use "header" argument: we have to load headers manually, because "header" assumes that we know what they are
  Table table = loadTable(filePath); 
  
  table.trim(); // removes whitespace
 
  // Put the headers, which should be in the first row, (eg "population") into String[] varLabels
  dimension = table.getColumnCount();
  varLabels = new String[dimension];
  TableRow labelsRow = table.getRow(0);
  for (int i = 0; i < dimension; i++) {
    varLabels[i] = labelsRow.getString(i);
  }
  table.removeRow(0);
  
  // fill dataTable
  dataTable = new double[table.getRowCount()][dimension];
  for (int row = 0; row < table.getRowCount(); row++)
    for (int col = 0; col < dimension; col++)
      dataTable[row][col] = Double.parseDouble(table.getString(row, col)); // there's no table.getDouble, so we have to do this
}

// finds min and max
void getDataBoundaries() {
  double min, max;
  // "col" is the column and hence the dimension
  for (int col = 0; col < dimension; col++) {
    min = dataTable[0][col];
    max = min;
    for (int row = 1; row < dataTable.length; row++) {
      println(row);
       if (dataTable[row][col] < min)
         min =  dataTable[row][col];
       else if (dataTable[row][col] > max)
         max =  dataTable[row][col];
    }
    
    // puts min and max in correct variables
    switch(col) {
     case 0: minX = min;
             maxX = max; break;
     case 1: minY = min;
             maxY = max; break;
     case 2: minZ = min;
             maxZ = max; break;
     case 3: minW = min;
             maxW = max; break;
     case 4: minU = min;
             maxU = max; break;
     case 5: minV = min;
             maxV = max; break;
     case 6: minT = min;
             maxT = max; break;
    }
  }  
}

// Loads `dataTable` into array
void loadAsArray() {
  switch(dimension) {
    case 1: load1D(); break;
    case 2: load2D(); break;
    case 3: load3D(); break;
    case 4: load4D(); break;
    case 5: load5D(); break;
    case 6: load6D(); break;
    case 7: load7D(); break;
  }   
}

void load1D() {
  data1D = dataTable[0][0]; // truncate data
}

void load2D() {
  data2D = new Double[dataTable.length];
  double[] averageTally = new double[dataTable.length]; // lowercase-"d" double
  
  double incrementX = dataTable.length > 1 ? (maxX - minX) / (dataTable.length - 1) : 0;
  double uniformX;
  int indexX;
  for (double[] point : dataTable) {
    uniformX = minX + Math.round((point[0] - minX) / incrementX) * incrementX;
    indexX = (int) ((uniformX - minX) / incrementX);
    
    averageTally[indexX]++;
    if (averageTally[indexX] >= 2)
      data2D[indexX] = (point[1] + data2D[indexX] * averageTally[indexX]) / (averageTally[indexX] + 1);
    else
      data2D[indexX] = point[1];
  }
}


void load3D() {
  data3D = new Double[dataTable.length][dataTable.length];
  double[][] averageTally = new double[dataTable.length][dataTable.length]; // lowercase-"d" double
  
  double incrementX = dataTable.length > 1 ? (maxX - minX) / (dataTable.length - 1) : 0;
  double uniformX; int indexX;
  double incrementY = dataTable.length > 1 ? (maxY - minY) / (dataTable.length - 1) : 0;
  double uniformY; int indexY;
  
  for (double[] point : dataTable) {
    uniformX = minX + Math.round((point[0] - minX) / incrementX) * incrementX;
    indexX = (int) ((uniformX - minX) / incrementX);
    
    uniformY = minY + Math.round((point[1] - minY) / incrementY) * incrementY;
    indexY = (int) ((uniformY - minY) /incrementY);
    
    
    averageTally[indexX][indexY]++;
    if (averageTally[indexX][indexY] >= 2)
      data3D[indexX][indexY] = (point[2] + data3D[indexX][indexY] * averageTally[indexX][indexY]) / (averageTally[indexX][indexY] + 1);
    else
      data3D[indexX][indexY] = point[2];
  }
}
  
void load4D() {
  data4D = new Double[dataTable.length][dataTable.length][dataTable.length];
  double[][][] averageTally = new double[dataTable.length][dataTable.length][dataTable.length]; // lowercase-"d" double
  
  double incrementX = dataTable.length > 1 ? (maxX - minX) / (dataTable.length - 1) : 0;
  double uniformX; int indexX;
  double incrementY = dataTable.length > 1 ? (maxY - minY) / (dataTable.length - 1) : 0;
  double uniformY; int indexY;
  double incrementW = dataTable.length > 1 ? (maxW - minW) / (dataTable.length - 1) : 0;
  double uniformW; int indexW;
  
  for (double[] point : dataTable) {
    uniformX = minX + Math.round((point[0] - minX) / incrementX) * incrementX;
    indexX = (int) ((uniformX - minX) / incrementX);
    
    uniformY = minY + Math.round((point[1] - minY) / incrementY) * incrementY;
    indexY = (int) ((uniformY - minY) /incrementY);
    
    uniformW = minW + Math.round((point[3] - minW) / incrementW) * incrementW;
    indexW = (int) ((uniformW - minW) / incrementW);
    
    averageTally[indexW][indexX][indexY]++;
    if (averageTally[indexW][indexX][indexY] >= 2)
      data4D[indexW][indexX][indexY] = (point[2] + data4D[indexW][indexX][indexY] * averageTally[indexW][indexX][indexY]) / (averageTally[indexW][indexX][indexY] + 1);
    else
      data4D[indexW][indexX][indexY] = point[2];
  }
}


void load5D() {
  loadHighDimension(data5D);
}

void load6D() {
  loadHighDimension(data6D);
}

void load7D() {
  loadHighDimension(data7D);
}

// 5D-7D are very similar
void loadHighDimension(Double[][][][] matrix) {
  matrix = new Double[dataTable.length][dataTable.length][dataTable.length][dimension - 3];
  double[][][] averageTally = new double[dataTable.length][dataTable.length][dataTable.length]; // lowercase-"d" double
  
  double incrementX = dataTable.length > 1 ? (maxX - minX) / (dataTable.length - 1) : 0;
  double uniformX; int indexX;
  double incrementY = dataTable.length > 1 ? (maxY - minY) / (dataTable.length - 1) : 0;
  double uniformY; int indexY;
  double incrementW = dataTable.length > 1 ? (maxW - minW) / (dataTable.length - 1) : 0;
  double uniformW; int indexW;
  
  for (double[] point : dataTable) {
    uniformX = minX + Math.round((point[0] - minX) / incrementX) * incrementX;
    indexX = (int) ((uniformX - minX) / incrementX);
        
    uniformY = minY + Math.round((point[1] - minY) / incrementY) * incrementY;
    indexY = (int) ((uniformY - minY) /incrementY);
        
    uniformW = minW + Math.round((point[3] - minW) / incrementW) * incrementW;
    indexW = (int) ((uniformW - minW) / incrementW);

        
    averageTally[indexW][indexX][indexY]++;
    if (averageTally[indexW][indexX][indexY] >= 2) {
      matrix[indexW][indexX][indexY][0] = (point[2] + matrix[indexW][indexX][indexY][0] * averageTally[indexW][indexX][indexY]) / (averageTally[indexW][indexX][indexY] + 1);
      if (dimension >= 6)
        matrix[indexW][indexX][indexY][1] = (point[4] + matrix[indexW][indexX][indexY][1] * averageTally[indexW][indexX][indexY]) / (averageTally[indexW][indexX][indexY] + 1);
      if (dimension >= 7)
      matrix[indexW][indexX][indexY][2] = (point[4] + matrix[indexW][indexX][indexY][1] * averageTally[indexW][indexX][indexY]) / (averageTally[indexW][indexX][indexY] + 1);

    } 
    else { 
      matrix[indexW][indexX][indexY][0] = point[2];
      if (dimension >= 6)
        matrix[indexW][indexX][indexY][1] = point[4];
      if (dimension >= 7)
        matrix[indexW][indexX][indexY][1] = point[5];
    }
  } 

}
