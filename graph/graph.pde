if (dimension == 1D) graph1D();
if (dimension == 2D) graph2D();
if (dimension == 3D) graph3D(data3D);
if (dimension == 4D) graph4D();
if (dimension == 5D) graph4D();
if (dimension == 6D) graph4D();
if (dimension == 7D) graph4D();


void graph1D(){
  point(0, 0, data1D); //sudo code
}



void graph4D(){
  Double[][] data4DatW = new Double[data4D.length][data4D[0].length]; //assumes data4D is rectangular
  double wIndex = (w-minW)/(maxW-minW)*data4D.length-1;
  
  for (int i = 0; i < data4DatW; i++){
    for (int j = 0; j < data4DatW[i]; j++){
      data4DatW[i][j] = (1 - (wIndex - (int)wIndex)) * data4D[(int)wIndex][i][j] + 
                        (1 - ((int)(wIndex+.5) - wIndex)) * data4D[(int)(wIndex+.5)][i][j]
    }
  }

  graph3D(data4DatW);
}

