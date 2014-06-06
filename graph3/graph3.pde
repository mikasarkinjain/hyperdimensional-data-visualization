//currently this does not work
//currently this does not work
//currently this does not work


String viewType = "best-fit surface";
int dimension = 3;


double w = 2;



Double data1D = new Double(2);

Double[] data2D = {new Double(2), new Double(3), new Double(20), new Double(1)};

Double[][] data3D = {{new Double(1.0), new Double(2.0), new Double(3.0)},
                     {new Double(2.0), new Double(4.0), new Double(3.0)},
                     {new Double(0.0), new Double(1.0), new Double(3.0)}};
       
                   
Double[][][] data4D = {{{new Double(1.0), new Double(2.0), new Double(3.0)},
                        {new Double(2.0), new Double(4.0), new Double(3.0)},
                        {new Double(0.0), new Double(1.0), new Double(3.0)}},
                         
                       {{new Double(2.0), new Double(3.0), new Double(4.0)},
                        {new Double(1.0), new Double(3.0), new Double(2.0)},
                        {new Double(1.0), new Double(2.0), new Double(4.0)}},
                         
                       {{new Double(3.0), new Double(4.0), new Double(5.0)},
                        {new Double(0.0), new Double(2.0), new Double(1.0)},
                        {new Double(2.0), new Double(3.0), new Double(5.0)}},
                         
                       {{new Double(4.0), new Double(5.0), new Double(6.0)},
                        {new Double(-1.0), new Double(1.0), new Double(0.0)},
                        {new Double(3.0), new Double(4.0), new Double(6.0)}} };
         
                     
Double[][][][] data7D = {{{  {new Double(1.0), new Double(1.0), new Double(1.0), new Double(3.0)},       {new Double(2.0), new Double(2.0), new Double(0.0), new Double(2.0)},       {new Double(3.0), new Double(3.0), new Double(-1.0), new Double(1.0)},
                             {new Double(2.0), new Double(2.0), new Double(1.0), new Double(3.0)},       {new Double(4.0), new Double(3.0), new Double(0.0), new Double(2.0)},       {new Double(3.0), new Double(4.0), new Double(-1.0), new Double(1.0)},
                             {new Double(0.0), new Double(3.0), new Double(1.0), new Double(3.0)},       {new Double(1.0), new Double(4.0), new Double(0.0), new Double(2.0)},       {new Double(3.0), new Double(5.0), new Double(-1.0), new Double(1.0)}  }},
                     
                         {{  {new Double(2.0), new Double(2.0), new Double(2.0), new Double(4.0)},       {new Double(3.0), new Double(3.0), new Double(1.0), new Double(3.0)},       {new Double(4.0), new Double(4.0), new Double(0.0), new Double(2.0)},
                             {new Double(1.0), new Double(3.0), new Double(2.0), new Double(4.0)},       {new Double(3.0), new Double(4.0), new Double(1.0), new Double(3.0)},       {new Double(2.0), new Double(5.0), new Double(0.0), new Double(2.0)},
                             {new Double(1.0), new Double(4.0), new Double(2.0), new Double(4.0)},       {new Double(2.0), new Double(5.0), new Double(1.0), new Double(3.0)},       {new Double(4.0), new Double(6.0), new Double(0.0), new Double(2.0)}  }},
                       
                         {{  {new Double(3.0), new Double(1.0), new Double(1.0), new Double(3.0)},       {new Double(4.0), new Double(2.0), new Double(0.0), new Double(2.0)},       {new Double(5.0), new Double(3.0), new Double(-1.0), new Double(1.0)},
                             {new Double(0.0), new Double(2.0), new Double(1.0), new Double(3.0)},       {new Double(2.0), new Double(3.0), new Double(0.0), new Double(2.0)},       {new Double(1.0), new Double(4.0), new Double(-1.0), new Double(1.0)},
                             {new Double(2.0), new Double(3.0), new Double(1.0), new Double(3.0)},       {new Double(3.0), new Double(4.0), new Double(0.0), new Double(2.0)},       {new Double(5.0), new Double(5.0), new Double(-1.0), new Double(1.0)}  }},
                     
                         {{  {new Double(4.0), new Double(2.0), new Double(2.0), new Double(4.0)},       {new Double(5.0), new Double(3.0), new Double(1.0), new Double(3.0)},       {new Double(6.0), new Double(4.0), new Double(0.0), new Double(2.0)},
                             {new Double(-1.0), new Double(3.0), new Double(2.0), new Double(4.0)},      {new Double(1.0), new Double(4.0), new Double(1.0), new Double(3.0)},       {new Double(0.0), new Double(5.0), new Double(0.0), new Double(2.0)},
                             {new Double(3.0), new Double(4.0), new Double(2.0), new Double(4.0)},       {new Double(4.0), new Double(5.0), new Double(1.0), new Double(3.0)},       {new Double(6.0), new Double(6.0), new Double(0.0), new Double(2.0)}  }}};                     
                     
 
double minX = -3;
double maxX = 10;

double minY = 5;
double maxY = 7;

double minZ = -5;
double maxZ = -1;

double minW = -7;
double maxW = 0;


double minU = 1;
double maxU = 6;
double minV = -1;
double maxV = 2;
double minT = 1;
double maxT = 4;



double maxY2D = 20;
double minY2D = 1;

double maxZ3D = 4;
double minZ3D = 0;

double maxZ4D = 6;
double minZ4D = -1;

double axisLength = 425;
double maxDimensionLength = 175;

  
float rotx = PI;
float roty = 0;

void setup() {
  size(1000, 600, P3D);
  fill(3);
}

void draw() {
  background(0);
  lights();
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  //drawAxis();
  graph();
  drawAxis();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty -= (mouseX-pmouseX) * rate;
}

void drawAxis(){
  stroke(255);
  line((float)-axisLength/2, 0, 0, (float)axisLength/2, 0, 0);
  line(0, (float)-axisLength/2, 0, 0, (float)axisLength/2, 0);
  line(0, 0, (float)-axisLength/2, 0, 0, (float)axisLength/2);
  
  //fill(255);
  //textSize(10);
  //text("x", (float)axisLength/2, 0, 0);
  //text("y", 0, 0, (float)-axisLength/2);
  //text("z", 0, (float)-axisLength/2, 0);
}

void plotPoint(double x, double y, double z){
  translate((float)-x, (float)-z, (float)-y);
  sphere(2);
  translate((float)x, (float)z, (float)y);
}


void plotLine(double x1, double y1, double z1, 
          double x2, double y2, double z2){
  line((float)x1, (float)y1, (float)z1, (float)x2, (float)y2, (float)z2);
}
       

void plotQuad(double x1, double y1, double z1, 
              double x2, double y2, double z2, 
              double x3, double y3, double z3, 
              double x4, double y4, double z4){
     beginShape();
     vertex((float)x1, (float)y1, (float)z1);
     vertex((float)x2, (float)y2, (float)z2);
     vertex((float)x3, (float)y3, (float)z3);
     vertex((float)x4, (float)y4, (float)z4);
     endShape(CLOSE);
}





void graph(){
  if (viewType.equals("best-fit mesh") || viewType.equals("best-fit surface")){
    if (dimension == 1) graph1D();
    if (dimension == 2) graph2D();
    if (dimension == 3) graph3Dfor3Dro7D(data3D, minZ3D, maxZ3D);
    if (dimension == 4) graph4Dfor4Dto7D(data4D);
    if (dimension == 5) graph4Dfor4Dto7D(data5D);
    if (dimension == 6) graph4Dfor4Dto7D(data6D);
    if (dimension == 7) graph4Dfor4Dto7D(data7D);
  }
  //add point graph stuff here
}


void graph1D(){
  noStroke(); 
  fill(255); //white for now, should be changed
  if (data1D != null){
    plotPoint(0, 0, 0); 
  }
  //label(0, 0, 0, "X "+data1D);  //sudo code
}

void graph2D(){
  stroke(255); //white for now, should be changes 
  noFill();
 
  double dialationFactorX = maxDimensionLength/(data2D.length-1);
  double dialationFactorY = maxDimensionLength/(maxY2D-minY2D);
  
  for (int i = 0; i < data2D.length-1; i++){
    try{
      plotLine(i*dialationFactorX, (data2D[i]-minY2D)*dialationFactorY, 0.0,
               (i+1)*dialationFactorX, (data2D[i+1]-minY2D)*dialationFactorY, 0.0);
    }catch(NullPointerException e) {} //not the best thing to do if there is no data point but what else?
  }
}

void graph4Dfor4Dto7D(Double[][][][] data){
  Double[][][] data3DatW = new Double[data[0].length][data[0][0].length][data[0][0][0].length]; //assumes data4D is rectangular (or rather rectangular prismic)
  
  for (int i = 0; i < data3DatW.length; i++){
    for (int j = 0; j < data3DatW[i].length; j++){
      for (int k = 0; k < data3DatW[i][j].length; k++){
        if (w == (double)(int)w){ //add another for loop to iterate through u, v, t
          data3DatW[i][j][k] = data[(int)w][i][j][k];
        }
        else{
          int flooredW = (int)w;
          data3DatW[i][j][k] = (1-(w-flooredW))*data4D[flooredW][i][j][k] + (1-(flooredW+1-w))*data4D[flooredW+1][i][j][k]; 
        }
    }
  }
  graph3Dfor3Dto7D(data3DatW, minZ4D, maxZ4D);
}

void graph3Dfor3Dto7D(Double[][][] data , double minZinData, double maxZinData){
  double dialationFactorX = maxDimensionLength/(data.length-1);
  double dialationFactorY = maxDimensionLength/(data[0].length-1);
  double dialationFactorZ = maxDimensionLength/(maxZinData-minZinData);
  

  for (int i = 0; i < data.length-1; i++){
    for (int j = 0; j < data[0].length-1; j++){ //assumes data3D is rectangular
    
    
      try{
        double plotColorR = 0;
        double plotColorG = 0;
        double plotColorB = 0;
        
        if (dimension == 3){ //gray for now, should be changed 
          plotColorR = 200;  
          plotColorG = 200;
          plotColorB = 200;
        }
        
        if (dimension >= 5){
          plotColorR = ((data[i][j][1]-minU)/(maxU-minU) * 255  +
                               (data[i+1][j][1]-minU)/(maxU-minU) * 255  +
                               (data[i+1][j+1][1]-minU)/(maxU-minU) * 255  + 
                               (data[i][j+1][1]-minU)/(maxU-minU) * 255 ) / 4;
        }
        
        if (dimension >= 6){
          plotColorG = ((data[i][j][2]-minV)/(maxV-minV) * 255  +
                               (data[i+1][j][2]-minV)/(maxV-minV) * 255  +
                               (data[i+1][j+1][2]-minV)/(maxV-minV) * 255  + 
                               (data[i][j+1][2]-minV)/(maxV-minV) * 255 ) / 4;
        }
        
        if (dimension >= 7){
          plotColorB = ((data[i][j][3]-minT)/(maxT-minT) * 255  +
                                   (data[i+1][j][3]-minT)/(maxT-minT) * 255  +
                                   (data[i+1][j+1][3]-minT)/(maxT-minT) * 255  + 
                                   (data[i][j+1][3]-minT)/(maxT-minT) * 255 ) / 4;
        }
                                   
          
        if (viewType == "best-fit mesh"){
          stroke(plotColorR, plotColorG, plotColorB); 
          noFill();
        }
        else if (viewType == "best-fit surface"){ //should this be an else if "best-fit surface"?
          noStroke();
          fillstroke(plotColorR, plotColorG, plotColorB); 
        }
      
      
        plotQuad((double)((i)*dialationFactorX), (data[i][j][0]-minZinData)*dialationFactorZ, (double)((j)*dialationFactorY), //replaced y-val with z-val to make graphing more intuitive
                 (double)((i+1)*dialationFactorX), (data[i+1][j][0]-minZinData)*dialationFactorZ-minZinData, (double)((j)*dialationFactorY), 
                 (double)((i+1)*dialationFactorX), (data[i+1][j+1][0]-minZinData)*dialationFactorZ-minZinData, (double)((j+1)*dialationFactorY),
                 (double)((i)*dialationFactorX), (data[i][j+1][0]-minZinData)*dialationFactorZ-minZinData, (double)((j+1)*dialationFactorY));
      
    }catch(NullPointerException e) {} //not the best thing to do if there is no data point but what else?
    
  
    }    
  }
}


void graphPoints(){
  for (int i = 0; i < arrayTable.length; i++){
    if (arrayTable[i].length == 1) {
      plotPoint(0, 0, arrayTable[i][0]);                
    }
    if (arrayTable[i].length == 2) {
      plotPoint(arrayTable[i][0], arrayTable[i][1], 0);
    }
    if (arrayTable[i].length == 3) {
      plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
    }
    if (arrayTable[i].length == 4) {
      plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
    }
    if (arrayTable[i].length == 5) {
      plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
    }
    if (arrayTable[i].length == 6) {
      plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
    }
    if (arrayTable[i].length == 7) {
      plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
    }
  }
}
