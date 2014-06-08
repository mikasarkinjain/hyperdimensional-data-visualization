class Graph {
  double w = 2;


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
  
 void graph(){
    translate((float)-axisLength/4, (float)-axisLength/4, (float)-axisLength/4);
    drawAxis();
    if (viewType == BEST_FIT_MESH || viewType == BEST_FIT_SURFACE){
      if (dimension == 1) graph1D();
      if (dimension == 2) graph2D();
      if (dimension == 3) graph3Dfor3Dto7D(data3D);
      if (dimension == 4) graph4Dfor4Dto7D(data4D);
      if (dimension == 5) graph4Dfor4Dto7D(data5D);
      if (dimension == 6) graph4Dfor4Dto7D(data6D);
      if (dimension == 7) graph4Dfor4Dto7D(data7D);
    }
    else if (viewType == 2){
      //graphPoints();
    }
    translate(0,0,0);
  }

  void drawAxis(){
    stroke(255);
    line(0, 0, 0, (float)axisLength/2, 0, 0);
    line(0, 0, 0, 0, (float)axisLength/2, 0);
    line(0, 0, 0, 0, 0, (float)axisLength/2);
    
    fill(255);
    textSize(10);
    scale(1, -1);
    try{
      textAlign(LEFT);
      text(varLabels[0]+" "+maxX, (float)axisLength/2, 0, 0);
      textAlign(RIGHT);
      text(varLabels[1]+" "+maxY, 0, 0, (float)axisLength/2);
      text(varLabels[2]+" "+maxZ, 0, (float)-axisLength/2, 0);
    
      textAlign(LEFT);        
      text(varLabels[0]+" "+minX, (float)axisLength/32, 0, 0);
      textAlign(RIGHT);
      text(varLabels[1]+" "+minY, 0, 0, (float)axisLength/32);
      text(varLabels[2]+" "+minZ, 0, (float)-axisLength/32, 0);
    }catch(NullPointerException e) {
      textAlign(LEFT);        
      text("X", (float)axisLength/2, 0, 0);
      textAlign(RIGHT);
      text("Y", 0, 0, (float)axisLength/2);
      text("Z", 0, (float)-axisLength/2, 0);
    }
  }


  void plotLine(double x1, double y1, double z1, 
  double x2, double y2, double z2) {
    line((float)x1, (float)y1, (float)z1, (float)x2, (float)y2, (float)z2);
  }


  void plotQuad(double x1, double y1, double z1, 
  double x2, double y2, double z2, 
  double x3, double y3, double z3, 
  double x4, double y4, double z4) {
    println("plotQuad");
    beginShape();
    vertex((float)x1, (float)y1, (float)z1);
    vertex((float)x2, (float)y2, (float)z2);
    vertex((float)x3, (float)y3, (float)z3);
    vertex((float)x4, (float)y4, (float)z4);
    endShape(CLOSE);
  }
  
  void graph1D() {
    noStroke(); 
    fill(255); //white for now, should be changed
    if (data1D != null) {
      plotPoint(0, 0, 0);
    }
    //label(0, 0, 0, "X "+data1D);  //sudo code
  }

  void graph2D() {
    stroke(255); //white for now, should be changes 
    noFill();

    double dialationFactorX = maxDimensionLength/(data2D.length-1);
    //double dialationFactorY = maxDimensionLength/(maxY2D-minY);
    double dialationFactorY = maxDimensionLength/(maxY - minY);

    for (int i = 0; i < data2D.length-1; i++) {
      try {
        plotLine(i*dialationFactorX, (data2D[i]-minY)*dialationFactorY, 0.0, 
        (i+1)*dialationFactorX, (data2D[i+1]-minY)*dialationFactorY, 0.0);
      }
      catch(NullPointerException e) {
      } //not the best thing to do if there is no data point but what else?
    }
  }

  void graph4Dfor4Dto7D(Double[][][][] data) {
    Double[][][] data3DatW = new Double[data[0].length][data[0][0].length][data[0][0][0].length]; //assumes data4D is rectangular (or rather rectangular prismic)

    for (int i = 0; i < data3DatW.length; i++) {
      for (int j = 0; j < data3DatW[i].length; j++) {
        for (int k = 0; k < data3DatW[i][j].length; k++) {
          if (w == (double)(int)w) { //add another for loop to iterate through u, v, t
            data3DatW[i][j][k] = data[(int)w][i][j][k];
          } else {
            int flooredW = (int)w;
            data3DatW[i][j][k] = (1-(w-flooredW))*data4D[flooredW][i][j][k] + (1-(flooredW+1-w))*data4D[flooredW+1][i][j][k];
          }
        }
      }
    }
    graph3Dfor3Dto7D(data3DatW);
  }

  void graph3Dfor3Dto7D(Double[][][] data) { 
    double dialationFactorX = maxDimensionLength/(data.length-1);
    double dialationFactorY = maxDimensionLength/(data[0].length-1);
    double dialationFactorZ = maxDimensionLength/(maxZ-minZ);

    for (int i = 0; i < data.length-1; i++) {
      for (int j = 0; j < data[0].length-1; j++) { //assumes data3D is rectangular

        try {
          float plotColorR = 0;
          float plotColorG = 0;
          float plotColorB = 0;

          if (dimension == 3) { //gray for now, should be changed 
            plotColorR = 200;  
            plotColorG = 200;
            plotColorB = 200;
          }

          if (dimension >= 5) {
            plotColorR = (float) (((data[i][j][1]-minU)/(maxU-minU) * 255  +
              (data[i+1][j][1]-minU)/(maxU-minU) * 255  +
              (data[i+1][j+1][1]-minU)/(maxU-minU) * 255  + 
              (data[i][j+1][1]-minU)/(maxU-minU) * 255 ) / 4);
          }

          if (dimension >= 6) {
            plotColorG = (float) (((data[i][j][2]-minV)/(maxV-minV) * 255  +
              (data[i+1][j][2]-minV)/(maxV-minV) * 255  +
              (data[i+1][j+1][2]-minV)/(maxV-minV) * 255  + 
              (data[i][j+1][2]-minV)/(maxV-minV) * 255 ) / 4);
          }

          if (dimension >= 7) {
            plotColorB = (float) (((data[i][j][3]-minT)/(maxT-minT) * 255  +
              (data[i+1][j][3]-minT)/(maxT-minT) * 255  +
              (data[i+1][j+1][3]-minT)/(maxT-minT) * 255  + 
              (data[i][j+1][3]-minT)/(maxT-minT) * 255 ) / 4);
          }

          if (viewType == BEST_FIT_MESH) {
            stroke(plotColorR, plotColorG, plotColorB); 
            noFill();
          } else if (viewType == BEST_FIT_SURFACE) {
            noStroke();
            fill(plotColorR, plotColorG, plotColorB);
          }


          plotQuad((double)((i)*dialationFactorX), (data[i][j][0]-minZ)*dialationFactorZ, (double)((j)*dialationFactorY), //replaced y-val with z-val to make graphing more intuitive
          (double)((i+1)*dialationFactorX), (data[i+1][j][0]-minZ)*dialationFactorZ-minZ, (double)((j)*dialationFactorY), 
          (double)((i+1)*dialationFactorX), (data[i+1][j+1][0]-minZ)*dialationFactorZ-minZ, (double)((j+1)*dialationFactorY), 
          (double)((i)*dialationFactorX), (data[i][j+1][0]-minZ)*dialationFactorZ-minZ, (double)((j+1)*dialationFactorY));
        }
        catch(NullPointerException e) {
        } //not the best thing to do if there is no data point but what else?
      }
    }
  }


  void graphPoints() {
    for (int i = 0; i < arrayTable.length; i++) {
      try {
        if (arrayTable[i].length == 1) {
          fill(255, 0, 0);
          noStroke();
          plotPoint(0, 0, arrayTable[i][0]);
        }
        //(x - min ) / (max-min) * axis

        if (arrayTable[i].length == 2) {
          fill(255, 0, 0);
          noStroke();
          plotPoint(arrayTable[i][0], arrayTable[i][1], 0);
        }

        if (arrayTable[i].length == 3) {
          fill(255, 0, 0);
          noStroke();
          double dilationX = maxDimensionLength / maxX;
          double dilationY = farCuttingPlaneZ / maxY;
          double dilationZ = maxDimensionLength / maxZ;
          //println(farCuttingPlaneZ);
          //plotPoint(arrayTable[i][0] * dilationX, arrayTable[i][2] * dilationY, arrayTable[i][1]);
          plotPoint(arrayTable[i][0] * dilationX, arrayTable[i][2] * dilationZ, arrayTable[i][1] * dilationY);
        }

        if (arrayTable[i].length == 4) {
          fill(255, 0, 0);
          noStroke();
          plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
        }

        if (arrayTable[i].length == 5) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          fill(R, 0, 0);
          noStroke();
          if (arrayTable[i][3] == w) { 
            plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
          }
        }

        if (arrayTable[i].length == 6) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          float G = (float) ((arrayTable[i][5] - minV)*255/(maxV-minV));
          fill(R, G, 0);
          noStroke();
          if (arrayTable[i][3] == w) { 
            plotPoint(arrayTable[i][0  ], arrayTable[i][2], arrayTable[i][1]);
          }
        }

        if (arrayTable[i].length == 7) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          float G = (float) ((arrayTable[i][5] - minV)*255/(maxV-minV));
          float B = (float) ((arrayTable[i][6] - minT)*255/(maxT-minT));
          fill(R, G, B);
          noStroke();
          if (arrayTable[i][3] == w) { 
            plotPoint(arrayTable[i][0], arrayTable[i][2], arrayTable[i][1]);
          }
        }
      }
      catch (NullPointerException e) {
        println("exception");
      }
    }
  }
}
