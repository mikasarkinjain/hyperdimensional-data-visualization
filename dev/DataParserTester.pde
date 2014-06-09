import java.util.Arrays;

String filePath;
// had to hardcode it, relative paths are complicated
String filePathBase = ""; // HARDCODE PATH HERE


Double data1D;
Double[] data2D;
Double[][][] data3D;
Double[][][][] data4D;
Double[][][][] data5D; 
Double[][][][] data6D;
Double[][][][] data7D;

double incrementX;
double incrementY;
double incrementW;

int lenX;
int lenY;
int lenW;

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

// nullValuesCount[0] contains number of X values that are null, etc.
// used by dataParser.calcIncrements()
int[] nullValuesCount;

int dimension;
String[] varLabels;
Double[][] arrayTable;


void setup() {
  DataParser dataParser = new DataParser(); 
  filePath = filePathBase + "4D_2.csv";
  dataParser.loadData(); 
  println("done");
  dataParser.printDataHuman();
}
