if (viewType.equals("best-fit surface") || viewType.equals("best-fit mesh")){
  if (dimension == 1) graph1D();
  if (dimension == 2) graph2D();
  if (dimension == 3) graph3D(data3D);
  if (dimension == 4) graph4D();
  if (dimension == 5) graph4D();
  if (dimension == 6) graph4D();
  if (dimension == 7) graph4D();
  
  
  void graph1D(){
    point(0, 0, 0); //sudo code
    //label(0, 0, 0, "X "+data1D);  //sudo code
  }
  
  void graph2D(){
    for (int i = 0; i < data2D.length-1; i++){
      line(i/(data2D.length-1)*(maxX-minX)+minX, 0, data2D[i] - minY
          ((i+1)/(data2D.length-1)*(maxX-minX)+minX, 0, data2D[i+1] - minY); //sudo code
    }
  }
  
  void graph4D(){
    Double[][] data4DatW = new Double[data4D.length][data4D[0].length]; //assumes data4D is rectangular
    double wDoubleIndex = (w-minW)/(maxW-minW)*(data4D.length-1);
    
    for (int i = 0; i < data4DatW; i++){
      for (int j = 0; j < data4DatW[i]; j++){
        data4DatW[i][j] = (1 - (wIndex - (int)wIndex)) * data4D[(int)wIndex][i][j] + 
                          (1 - ((int)(wIndex+.5) - wIndex)) * data4D[(int)(wIndex+.5)][i][j]
      }
    }
    graph3D(data4DatW);
  }
}

//else if (viewType.equals("points")){
  for (int i = 0; i < dataTable.length; i++){
    if (dataTable[i].length == 1) {
      point(0, 0, 0);
    }
    else if (Table[i].length == 2) {
      
    }
    else if (Table[i].length == 3) {
      
    }
    else if (Table[i].length == 4) {
      
    }
  }
}
