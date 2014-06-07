class DataParser {
  void loadData() {
    loadAsTable(); // arrayTable
    getMinMax(); // minX, maxX, etc.
    loadAsArray(); // data1D, data2D, etc.
    //printData();
  }

  // Loads file into `arrayTable` 
  void loadAsTable() {
    // don't use "header" argument: we have to load headers manually, because "header" assumes that we know what headers are
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

    // fill arrayTable
    arrayTable = new double[table.getRowCount()][dimension];
    for (int row = 0; row < table.getRowCount (); row++)
      for (int col = 0; col < dimension; col++) {
        // there's no table.getDouble, so we do table.getString and parse it as Double
        arrayTable[row][col] = Double.parseDouble(table.getString(row, col));
      }
  }

  // finds min and max
  void getMinMax() {
    double min, max;
    // "col" is the column and hence the dimension
    for (int col = 0; col < dimension; col++) {
      min = arrayTable[0][col];
      max = min;
      for (int row = 1; row < arrayTable.length; row++) {
        if (arrayTable[row][col] < min)
          min =  arrayTable[row][col];
        else if (arrayTable[row][col] > max)
          max =  arrayTable[row][col];
      }

      // puts min and max in correct variables
      switch(col) {
      case 0: 
        minX = min;
        maxX = max; 
        break;
      case 1: 
        minY = min;
        maxY = max; 
        break;
      case 2: 
        minZ = min;
        maxZ = max; 
        break;
      case 3: 
        minW = min;
        maxW = max; 
        break;
      case 4: 
        minU = min;
        maxU = max; 
        break;
      case 5: 
        minV = min;
        maxV = max; 
        break;
      case 6: 
        minT = min;
        maxT = max; 
        break;
      }
    }
  }

  // Loads `arrayTable` into array
  void loadAsArray() {
    calcIncrements();
    switch(dimension) {
    case 1: 
      load1D(); 
      break;
    case 2: 
      load2D(); 
      break;
    case 3: 
      load3D(); 
      break;
    case 4: 
      load4D(); 
      break;
    case 5: 
      load5D(); 
      break;
    case 6: 
      load6D(); 
      break;
    case 7: 
      load7D(); 
      break;
    }
  }

  void calcIncrements() {
    int[] dimensionsToUse = {
      0, 1, 3
    }; // X, Y, W
    for (int dim : dimensionsToUse) {
      // skip Y or W if dimension isn't big enough 
      if ((dim >= 1 && dimension < 3) || (dim >= 3 && dimension < 4))
        continue;
      // all values from an axis (say, X)
      double[] values = new double[arrayTable.length];

      // fill `values` with relevant column 
      for (int row = 0; row < arrayTable.length; row++)
        values[row] = arrayTable[row][dim];

      // sort  
      Arrays.sort(values);


      // add up the increments of the points  
      double sum = 0.0;
      int uniqueValuesCount = 1; // we need to remove duplicates 

      for (int i = 1; i < values.length; i++) {
        // skip duplicates
        if (values[i] != values[i - 1]) {
          sum += values[i] - values[i - 1];
          uniqueValuesCount++;
        }
      }

      double increment = sum / uniqueValuesCount;
      // given an increment and a min and max, we can say that there are 1 + (max - min) / increment 
      // elements in the resulting array. 
      int arrayLen = (int) (1 + (values[values.length - 1] - values[0]) / increment);
      if (uniqueValuesCount == 1) {
        increment = 0;
        arrayLen = 1;
      }

      // set `increment` and `len` to relevant instance variables
      switch(dim) {
      case 0: 
        incrementX = increment; 
        lenX = arrayLen; 
        break;
      case 1: 
        incrementY = increment; 
        lenY = arrayLen; 
        break;
      case 3: 
        incrementW = increment; 
        lenW = arrayLen; 
        break;
      }
    }
  }


  /* HELPER METHODS FOR loadAsArray() */

  // rounds raw data value to uniform value
  double roundValue(double value, double min, double increment) {
    return min + Math.round((value - min) / increment) * increment;
  }

  // converts uniform value to array index
  int calcArrayIndex(double value, double min, double increment) {
    return (int) ((value - min) / increment);
  }

  // converts array index to uniform value
  int valAtIndex(int index, double min, double increment) {
    return (int) (index * increment + min);
  }

  double weightedAverage(double currentAverage, double numItems, double newItem) {
    return (newItem + currentAverage * numItems)  / (currentAverage + 1);
  }   

  /* END OF HELPER FUNCTIONS */

  void load1D() {
    // use average of points

    double sum = 0.0;
    for (double[] point : arrayTable) {
      sum += point[0];
    }

    data1D = sum / arrayTable.length;
  }

  void load2D() {
    data2D = new Double[lenX];

    // When two points have the same X, we average their Ys. (this data structure is best-fit)
    // `averageTally` is a duplicate of `data2D` except that we store # number of times averaged
    // instead of Y for a given X.
    double[] averageTally = new double[lenX];

    for (double[] point : arrayTable) {
      double roundedX = roundValue(point[0], minX, incrementX);
      int indexX = calcArrayIndex(roundedX, minX, incrementX);

      averageTally[indexX]++;

      // If there already is a Z for this X...
      // ... We compute  the weighted average of the points, using `averageTally`.
      // If there is no value yet for thisX, we don't need to do averaging.
      if (averageTally[indexX] >= 2)
        data2D[indexX] = weightedAverage(data2D[indexX], averageTally[indexX], point[1]);
      else
        data2D[indexX] = point[1];
    }

    estimateDataGaps2D();
  }

  void estimateDataGaps2D() {
    // don't check values at extremes

    for (int x = 1; x < data2D.length - 1; x++)
      if (data2D[x] == null && data2D[x - 1] != null && data2D[x + 1] != null)
        data2D[x] = (data2D[x - 1] + data2D[x + 1]) / 2;
  }


  void load3D() {
    data3D = new Double[lenX][lenY][1];

    // When two points have the same (X, Y), we average their Zs. (this data structure is best-fit)
    // `averageTally` is a duplicate of `data3D` except that we store # number of times averaged
    // instead of Z for a given (X, Y).
    double[][] averageTally = new double[lenX][lenY]; // lowercase-"d" double

    for (double[] point : arrayTable) {
      double roundedX = roundValue(point[0], minX, incrementX);
      int indexX = calcArrayIndex(roundedX, minX, incrementX);

      double roundedY = roundValue(point[1], minY, incrementY);
      int indexY = calcArrayIndex(roundedY, minY, incrementY);

      averageTally[indexX][indexY]++;

      // If there already is a Z for this (X, Y)...
      // ... We compute  the weighted average of the points, using `averageTally`.
      // If there is no value yet for this (X, Y), we don't need to do averaging.
      if (averageTally[indexX][indexY] >= 2)
        data3D[indexX][indexY][0] = weightedAverage(data3D[indexX][indexY][0], averageTally[indexX][indexY], point[2]);
      else
        data3D[indexX][indexY][0] = point[2];
    }
  }

  void estimateDataGaps3D() {
    // don't check values at extremes

    for (int x = 1; x < data3D.length - 1; x++)
      for (int y = 1; y < data3D[0].length - 1; y++)
        if (data3D[x][y][0] == null && data3D[x - 1][y][0] != null && data3D[x + 1][y][0] != null && data3D[x][y - 1][0] != null && data3D[x][y + 1][0] != null)
          data3D[x][y][0] = (data3D[x - 1][y][0] + data3D[x + 1][y][0] + data3D[x][y - 1][0] + data3D[x][y + 1][0])  / 4;
  }

  void load4D() {
    data4D = loadHyperDimension();
  }

  void load5D() {
    data5D = loadHyperDimension();
  }

  void load6D() {
    data6D = loadHyperDimension();
  }

  void load7D() {
    data7D = loadHyperDimension();
  }

  // 4D-7D are very similar, so we use this generic method.
  // See the block comment at the top for the special structure of 5D to 7D.
  Double[][][][] loadHyperDimension() {
    Double[][][][] matrix = new Double[lenW][lenX][lenY][dimension - 3];

    // When two points have the same (W, X, Y), we average their Zs, Us, Vs, and Ts (if they exist). (this data structure is best-fit)
    // `averageTally` is a duplicate of `matrix` except that we store # number of times averaged
    // instead of (Z, U, V, T) for a given (W, X, Y).
    double[][][] averageTally = new double[lenW][lenX][lenY]; // lowercase-"d" double

    for (double[] point : arrayTable) {
      // double[] point is of form [x, y, z, w, u, v, t]

      double roundedW = roundValue(point[3], minW, incrementW);
      int indexW = calcArrayIndex(roundedW, minW, incrementW);

      double roundedX = roundValue(point[0], minX, incrementX);
      int indexX = calcArrayIndex(roundedX, minX, incrementX);

      double roundedY = roundValue(point[1], minY, incrementY);
      int indexY = calcArrayIndex(roundedY, minY, incrementY);


      averageTally[indexW][indexX][indexY]++;

      // If there already is a (Z, U, V, T) for this (W, X, Y)...
      // ... We compute  the weighted average of the points, using `averageTally`.
      if (averageTally[indexW][indexX][indexY] >= 2) {
        matrix[indexW][indexX][indexY][0] = weightedAverage(matrix[indexW][indexX][indexY][0], averageTally[indexW][indexX][indexY], point[2]); 
        if (dimension >= 5)
          matrix[indexW][indexX][indexY][1] = weightedAverage(matrix[indexW][indexX][indexY][1], averageTally[indexW][indexX][indexY], point[4]);
        if (dimension >= 6)
          matrix[indexW][indexX][indexY][2] = weightedAverage(matrix[indexW][indexX][indexY][2], averageTally[indexW][indexX][indexY], point[5]);
        if (dimension >= 7)
          matrix[indexW][indexX][indexY][3] = weightedAverage(matrix[indexW][indexX][indexY][3], averageTally[indexW][indexX][indexY], point[6]);
      } 

      // If there is no value yet for this (W, X, Y), we don't need to do averaging.
      else {
        matrix[indexW][indexX][indexY][0] = point[2];
        if (dimension >= 5)
          matrix[indexW][indexX][indexY][1] = point[4];          
        if (dimension >= 6)
          matrix[indexW][indexX][indexY][2] = point[5];
        if (dimension >= 7)
          matrix[indexW][indexX][indexY][3] = point[6];
      }
    } 

    estimateDataGaps4DTo7D(matrix);
    return matrix;
  }


  void estimateDataGaps4DTo7D(Double[][][][] data) {
    // don't check values at extremes

    for (int _w = 0; _w < data.length; _w++)
      for (int x = 1; x < data[0].length - 1; x++)
        for (int y = 1; y < data[0][0].length - 1; y++)

          if (data[_w][x][y][0] == null && data[_w][x - 1][y][0] != null && data[_w][x + 1][y][0] != null && data[_w][x][y - 1][0] != null && data[_w][x][y + 1][0] != null)
            for (int i = 0; i < data[0][0][0].length; i++)
                data[_w][x][y][i] = (data[_w][x - 1][y][i] + data[_w][x + 1][y][i] + data[_w][x][y - 1][i] + data[_w][x][y + 1][i]) / 4;
  }


  void printData() {
    println();
    for (String label : varLabels) {
      print(label + "\t");
    }

    if (dimension >= 5) {
      Double[][][][] matrix;
      switch(dimension) {
      case 4: 
        matrix = data4D; 
        break;
      case 5: 
        matrix = data5D; 
        break;
      case 6: 
        matrix = data6D; 
        break;
      case 7: 
        matrix = data7D; 
        break;
      default: 
        matrix = data5D; 
        break;
      }

      for (int w = 0; w < matrix.length; w++) {
        for (int x = 0; x < matrix[w].length; x++) {
          for (int y = 0; y < matrix[w][x].length; y++) {

            print(valAtIndex(x, minX, incrementX) + " " + 
              valAtIndex(y, minY, incrementY) + " " +
              valAtIndex(w, minW, incrementW) + " " +
              matrix[w][x][y][0] + " ");

            if (dimension >= 6)
              print(matrix[w][x][y][1] + " ");
            if (dimension >= 7)
              print(matrix[w][x][y][2] + " ");
            print("\n");
          }
        }
      }
    }
  }
}

