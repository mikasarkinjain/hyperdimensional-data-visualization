if (dimension == 1D) 
if (dimension == 2D) 
if (dimension == 3D) graph3D(data3D);
if (dimension == 4D) graph4D(w);
if (dimension == 5D) 
if (dimension == 6D) 
if (dimension == 7D) 


void graph4D(w){
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

