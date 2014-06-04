class Graph {
    String viewType = "best-fit surface";

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
        if (dimension == 3) graph3D(data3D, minZ3D, maxZ3D);
        if (dimension == 4) graph4D();
        if (dimension == 5) graph4D();
        if (dimension == 6) graph4D();
        if (dimension == 7) graph4D();
      }
      //add point graph stuff here
      
      drawAxis();
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
        
        
    //    double xCenteringTranslation = -1*(maxX+minX)/2;
    //    double yCenteringTranslation = -1*(maxY+minY)/2;
    //    
    //    double dialationFactor = maxDimensionLength/max((float)(maxX-minX), (float)(maxY-minY));
    //    
    //    plotLine(   (i/(data2D.length-1)*(maxX-minX)+minX + xCenteringTranslation) * dialationFactor,    0.0,    (data2D[i] + yCenteringTranslation) * dialationFactor,
    //                ((i+1)/(data2D.length-1)*(maxX-minX)+minX + xCenteringTranslation) * dialationFactor,    0.0,    (data2D[i+1] + yCenteringTranslation) * dialationFactor); //sudo code
      }
    }

    void graph3D(Double[][] data, double minZinData, double maxZinData){
      if (viewType == "best-fit mesh"){
        stroke(255); //white for now, should be changed 
        noFill();
      }
      else { //should this be an else if "best-fit surface"?
        noStroke();
        fill(255, 0, 0); //red for now, should be changed
      }
      
      double dialationFactorX = maxDimensionLength/(data.length-1);
      double dialationFactorY = maxDimensionLength/(data[0].length-1);
      double dialationFactorZ = maxDimensionLength/(maxZinData-minZinData);
      

      for (int i = 0; i < data.length-1; i++){
        for (int j = 0; j < data[0].length-1; j++){ //assumes data3D is rectangular
          try{
            plotQuad((double)((i)*dialationFactorX), (data[i][j]-minZinData)*dialationFactorZ, (double)((j)*dialationFactorY), //replaced y-val with z-val to make graphing more intuitive
                     (double)((i+1)*dialationFactorX), (data[i+1][j]-minZinData)*dialationFactorZ-minZinData, (double)((j)*dialationFactorY), 
                     (double)((i+1)*dialationFactorX), (data[i+1][j+1]-minZinData)*dialationFactorZ-minZinData, (double)((j+1)*dialationFactorY),
                     (double)((i)*dialationFactorX), (data[i][j+1]-minZinData)*dialationFactorZ-minZinData, (double)((j+1)*dialationFactorY));
          }catch(NullPointerException e) {} //not the best thing to do if there is no data point but what else?
        }    
      }
    }


    void graph4D(){
      println(data4D.length);
      Double[][] data3DatW = new Double[data4D[0].length][data4D[0][0].length]; //assumes data4D is rectangular
      
      println("1");
      for (int i = 0; i < data3DatW.length; i++){
        for (int j = 0; j < data3DatW[0].length; j++){
          if (w == (double)(int)w){
            println("2");
            data3DatW[i][j] = data4D[(int)w][i][j];
            println("here");
          }
          else{
            println("3");
            int flooredW = (int)w;
            data3DatW[i][j] = (1-(w-flooredW))*data4D[flooredW][i][j] + (1-(flooredW+1-w))*data4D[flooredW+1][i][j];
          }
        }
      }
      graph3D(data3DatW, minZ4D, maxZ4D);
    }


    //void graph4D(){
    //  Double[][] data4DatW = new Double[data4D.length][data4D[0].length]; //assumes data4D is rectangular
    //  double wDoubleIndex = (w-minW)/(maxW-minW)*(data4D.length-1);
    //  
    //  for (int i = 0; i < data4DatW.length; i++){
    //    for (int j = 0; j < data4DatW[i].length; j++){
    //      data4DatW[i][j] = (1 - (wDoubleIndex - (int)wDoubleIndex)) * data4D[(int)wDoubleIndex][i][j] + 
    //                        (1 - ((int)(wDoubleIndex+.5) - wDoubleIndex)) * data4D[(int)(wDoubleIndex+.5)][i][j];
    //    }
    //  }
    //  graph3D(data4DatW);
    //}





















    //void graph3D(Double[][] data){
    //  double xIncrement = (maxX-minX)/(data.length-1);
    //  double yIncrement = (maxY-minY)/(data[0].length-1);
    //
    //  double scaleFactor = maxDimensionLength/max((float)(maxX-minX), (float)(maxY-minY), (float)(maxZ-minZ));
    //
    //  if (viewType.equals("point")){
    //    noStroke(); 
    //    fill(0, 0, 255); //blue for now, should be changed
    //    
    //    double xcor, ycor, zcor;
    //    
    //    for (int i = 0; i < data.length; i++){
    //      for (int j = 0; j < data[i].length; j++){
    //        if (data[i][j] != null){
    //          
    //          xcor = (i-(data.length-1)/2.0)*xIncrement*scaleFactor;
    //          ycor = (j-(data[0].length-1)/2.0)*yIncrement*scaleFactor;
    //          zcor = (data[i][j]-(maxZ-minZ)/2)*scaleFactor;
    //          
    //          translate((float)-xcor, (float)-zcor, (float)-ycor);
    //          sphere(2);
    //          translate((float)xcor, (float)zcor, (float)ycor);
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
    //    for (int i = 0; i < data.length - 1; i++){
    //      for (int j = 0; j < data[i].length - 1; j++){
    //        beginShape(); 
    //        if (data[i][j] != null){
    //          vertex((float)((i-(data.length-1)/2.0)*xIncrement*scaleFactor*-1),
    //                 (float)((data[i][j]-(maxZ-minZ)/2)*scaleFactor*-1), 
    //                 (float)((j-(data[0].length-1)/2.0)*yIncrement*scaleFactor*-1));
    //        }
    //        if (data[i+1][j] != null){
    //          vertex((float)((i+1-(data.length-1)/2.0)*xIncrement*scaleFactor*-1), 
    //                 (float)((data[i+1][j]-(maxZ-minZ)/2)*scaleFactor*-1),
    //                 (float)((j-(data[0].length-1)/2.0)*yIncrement*scaleFactor*-1));
    //        }
    //        if (data[i+1][j+1] != null){
    //          vertex((float)((i+1-(data.length-1)/2.0)*xIncrement*scaleFactor*-1),
    //                 (float)((data[i+1][j+1]-(maxZ-minZ)/2)*scaleFactor*-1), 
    //                 (float)((j+1-(data[0].length-1)/2.0)*yIncrement*scaleFactor*-1));
    //        }
    //        if (data[i][j+1] != null){
    //          vertex((float)((i-(data.length-1)/2.0)*xIncrement*scaleFactor*-1), 
    //                 (float)((data[i][j+1]-(maxZ-minZ)/2)*scaleFactor*-1),
    //                 (float)((j+1-(data[0].length-1)/2.0)*yIncrement*scaleFactor*-1));
    //        }
    //        endShape(CLOSE); 
    //      }
    //    }
    //
    //  }
    //
    //}
}
