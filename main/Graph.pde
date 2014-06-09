class Graph {

  double maxY2D = 20;
  double minY2D = 1;

  double maxZ3D = 4;
  double minZ3D = 0;

  double maxZ4D = 6;
  double minZ4D = -1;

  double axisLength = 425;
  double maxDimensionLength = 175;
  
 void graph(){
    translate((float)-axisLength/4, (float)-axisLength/4, (float)-axisLength/4);
    drawAxis();
    if (arrayTable != null && (viewType == BEST_FIT_MESH || viewType == BEST_FIT_SURFACE)){
      if (dimension == 1) graph1D();
      if (dimension == 2) graph2D();
      if (dimension == 3) graph3Dfor3Dto7D(data3D);
      if (dimension == 4) graph4Dfor4Dto7D(data4D);
      if (dimension == 5) graph4Dfor4Dto7D(data5D);
      if (dimension == 6) graph4Dfor4Dto7D(data6D);
      if (dimension == 7) graph4Dfor4Dto7D(data7D);
    }
    
    else if (arrayTable != null && viewType == 2 ){
      graphPoints();
    }
    translate(0,0,0);
  }

  void drawAxis(){
    stroke(255);
    line(0, 0, 0, (float)axisLength/2, 0, 0);
    if (dimension >= 2){
      line(0, 0, 0, 0, 0, (float)axisLength/2);
    }
    if (dimension >= 3){
      line(0, 0, 0, 0, (float)axisLength/2, 0);
    }
    
    fill(255);
    textSize(10);
    scale(1, -1);
    try{
      textAlign(LEFT);
      text(varLabels[0]+" "+maxX, (float)axisLength/2, 0, 0);
      
      textAlign(RIGHT);
      if (dimension >= 2) 
        text(varLabels[1]+" "+maxY, 0, 0, (float)axisLength/2);
      if (dimension >= 3)
        text(varLabels[2]+" "+maxZ, 0, (float)-axisLength/2, 0);
    
      textAlign(LEFT);        
      text(varLabels[0]+" "+minX, (float)axisLength/32, 0, 0);
      
      textAlign(RIGHT);
      if (dimension >= 2)
        text(varLabels[1]+" "+minY, 0, 0, (float)axisLength/32);
      if (dimension >= 3)
        text(varLabels[2]+" "+minZ, 0, (float)-axisLength/32, 0);
        
    } catch(NullPointerException e) {
      textAlign(LEFT);        
      text("X", (float)axisLength/2, 0, 0);
      textAlign(RIGHT);
      text("Y", 0, 0, (float)axisLength/2);
      text("Z", 0, (float)-axisLength/2, 0);
    }
  }

  void plotPoint(double x, double y, double z) {
    translate((float)-x, (float)-z, (float)-y);
    sphere(2);
    translate((float)x, (float)z, (float)y);
  }


  void plotLine(double x1, double y1, double z1, 
  double x2, double y2, double z2) {
    line((float)x1, (float)y1, (float)z1, (float)x2, (float)y2, (float)z2);
  }


  void plotQuad(double x1, double y1, double z1, 
  double x2, double y2, double z2, 
  double x3, double y3, double z3, 
  double x4, double y4, double z4) {
    beginShape();
    vertex((float)x1, (float)y1, (float)z1);
    vertex((float)x2, (float)y2, (float)z2);
    vertex((float)x3, (float)y3, (float)z3);
    vertex((float)x4, (float)y4, (float)z4);
    endShape(CLOSE);
  }
  
  void graph1D() {
    noStroke(); 
    fill(255, 0, 0); 
    if (data1D != null) {
      plotPoint(-(data1D-minX)/(maxX-minX)*maxDimensionLength, 0, 0);
    }
  }

  void graph2D() {
    stroke(175, 200, 230);  
    noFill();

    double dialationFactorX = maxDimensionLength/(data2D.length-1);
    //double dialationFactorY = maxDimensionLength/(maxY2D-minY);
    double dialationFactorY = maxDimensionLength/(maxY - minY);

    for (int i = 0; i < data2D.length-1; i++) {
      try {
        plotLine(i*dialationFactorX, 0.0, (data2D[i]-minY)*dialationFactorY, 
        (i+1)*dialationFactorX, 0.0, (data2D[i+1]-minY)*dialationFactorY);
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
        try {
          if (w == (double)(int)w) { //add another for loop to iterate through u, v, t
            try{
              data3DatW[i][j][k] = data[(int)w][i][j][k];
            } catch (Exception e){}
        } else {
            try{
              int flooredW = (int)w;
              data3DatW[i][j][k] = (1-(w-flooredW))*data4D[flooredW][i][j][k] + (1-(flooredW+1-w))*data4D[flooredW+1][i][j][k];
            } catch (Exception e){}
          }
        }
        catch (Exception e) {}
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
          float plotColorR = 175;
          float plotColorG = 200;
          float plotColorB = 230;

          if (dimension == 3) { //gray for now, should be changed 
            plotColorR = 175;  
            plotColorG = 200;
            plotColorB = 230;
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


          plotQuad((double)((i)*dialationFactorX), -(data[i][j][0]-minZ)*dialationFactorZ, (double)((j)*dialationFactorY), //replaced y-val with z-val to make graphing more intuitive
          (double)((i+1)*dialationFactorX), -(data[i+1][j][0]-minZ)*dialationFactorZ-minZ, (double)((j)*dialationFactorY), 
          (double)((i+1)*dialationFactorX), -(data[i+1][j+1][0]-minZ)*dialationFactorZ-minZ, (double)((j+1)*dialationFactorY), 
          (double)((i)*dialationFactorX), -(data[i][j+1][0]-minZ)*dialationFactorZ-minZ, (double)((j+1)*dialationFactorY));
        }
        catch(NullPointerException e) {
        } //not the best thing to do if there is no data point but what else?
      }
    }
  }


  void graphPoints() {
    
    // Formula for dilation is (value - min) / (max-min) * maxDimensionLength
    // We precompute part of this here
    double dilationFactorX = 1 / (maxX - minX) * maxDimensionLength;
    // if minX = maxX, dilationFactorX = 0, and the calculated x will equal NaN
    if (maxX <= minX)
      dilationFactorX = 1;
    
    double dilationFactorY = 1; double dilationFactorZ = 1;
    if (dimension >= 2 && maxY > minY)
      dilationFactorY = 1 / (maxY - minY) * maxDimensionLength;

    if (dimension >= 3 && maxZ > minZ)
      dilationFactorZ = 1 / (maxZ - minZ) * maxDimensionLength;
      
    double roundedW = 0;
      
    if (dimension >= 4){
      roundedW = wValues[roundedWIndex];
    }
    
    for (int i = 0; i < arrayTable.length; i++) {
      try {
        if (arrayTable[i].length == 1) {
          fill(255, 0, 0);
          noStroke();
          
          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          plotPoint(-x, 0, 0);
        }

        if (arrayTable[i].length == 2) {
          fill(255, 0, 0);
          noStroke();

          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          plotPoint(-x, -y, 0);
        }

        if (arrayTable[i].length == 3) {
          fill(255, 0, 0);
          noStroke();

          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          double z = (arrayTable[i][2] - minZ) * dilationFactorZ;;

          plotPoint(-x, -y, z);
        }
        if (arrayTable[i].length == 4 && arrayTable[i][3] == roundedW) {
          fill(255, 0, 0);
          noStroke();
          
          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          double z = (arrayTable[i][2] - minZ) * dilationFactorZ;

          plotPoint(-x, -y, z);
        }

        if (arrayTable[i].length == 5 && arrayTable[i][3] == roundedW) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          fill(R, 0, 0);
          noStroke();

          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          double z = (arrayTable[i][2] - minZ) * dilationFactorZ;

          plotPoint(-x, -y, z);
        }

        if (arrayTable[i].length == 6 && arrayTable[i][3] == roundedW) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          float G = (float) ((arrayTable[i][5] - minV)*255/(maxV-minV));
          fill(R, G, 0);
          noStroke();

          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          double z = (arrayTable[i][2] - minZ) * dilationFactorZ;

          plotPoint(-x, -y, z);
        }

         if (arrayTable[i].length == 7 && arrayTable[i][3] == roundedW) {
          float R = (float) ((arrayTable[i][4] - minU)*255/(maxU-minU));
          float G = (float) ((arrayTable[i][5] - minV)*255/(maxV-minV));
          float B = (float) ((arrayTable[i][6] - minT)*255/(maxT-minT));
          fill(R, G, B);
          noStroke();

          double x = (arrayTable[i][0] - minX) * dilationFactorX;
          double y = (arrayTable[i][1] - minY) * dilationFactorY;
          double z = (arrayTable[i][2] - minZ) * dilationFactorZ;

          plotPoint(-x, -y, z);
        }
      }
      catch (NullPointerException e) {
        println("exception");
      }
    }
  }
}
