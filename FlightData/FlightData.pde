import java.util.Scanner; //<>//
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
PImage mapImage;

void settings() {
  size(SCREENX, SCREENY);
  mapImage = loadImage("Blank_US_Map.png");
  mapImage.resize(SCREENX, SCREENY);
}

void setup() {
  background(255);

  try {
    File myFile = new File("flights2k.csv");
    Scanner input = new Scanner(myFile);
    input.useDelimiter("\n");
    int dataIdentifier = 0;
    input.next();
    while (input.hasNext())
    {
      Flight myFlight = new Flight(dataIdentifier);
      String allData = input.next();
      String[] allDataArray = allData.split("[,]", 0);
      for (int i = 0; i < NUMBER_OF_DATAPOINTS + 2; i++)
      {
        String data = allDataArray[i];
        if (i == 5 || i == 10)
        {
          data += ", " + allDataArray[i+1];
        }
        if (i == 3 || i == 8)
        {
          boolean repeat = false;
          ;
          for (int j = 0; j < airportNames.size() && !repeat; j++)
          {
            repeat = airportNames.contains(data);
          }
          if (!repeat)
          {
            airportNames.add(data);
          }
        }
        data = data.trim();
        myFlight.setData(data, i);
      }
      myFlights.add(myFlight);
      dataIdentifier++;
    }
    input.close();
  }
  catch (Exception e) {
    System.err.println(e);
  }

  System.out.println(airportNames);
  System.out.println(airportNames.size());

  ellipseMode(RADIUS);

  myAirports.add(new Airport(1410, 335, "JFK", ON_BOTTOM));
  myAirports.add(new Airport(130, 580, "LAX", ON_TOP));
  myAirports.add(new Airport(1330, 420, "DCA", ON_TOP));
  myAirports.add(new Airport(150, 50, "SEA", ON_BOTTOM));
  myAirports.add(new Airport(1320, 900, "FLL", ON_BOTTOM));
  myAirports.add(new Airport(450, 890, "HNL", ON_TOP));
  myAirports.add(new Airport(1015, 340, "ORD", ON_TOP));
  myAirports.add(new Airport(240, 540, "LAS", ON_TOP));
  myAirports.add(new Airport(990, 260, "ATW", ON_TOP));
  myAirports.add(new Airport(780, 700, "DAL", ON_SIDE));
  myAirports.add(new Airport(830, 450, "MCI", ON_TOP));
  myAirports.add(new Airport(820, 810, "HOU", ON_TOP));
  myAirports.add(new Airport(1260, 890, "RSW", ON_TOP));
  myAirports.add(new Airport(145, 600, "LGB", ON_SIDE));
  myAirports.add(new Airport(60, 390, "SMF", ON_TOP));
  myAirports.add(new Airport(600, 650, "LBB", ON_TOP));
  myAirports.add(new Airport(760, 710, "DFW", ON_TOP));
  myAirports.add(new Airport(500, 910, "OGG", ON_TOP));
  myAirports.add(new Airport(1395, 340, "EWR", ON_TOP));
  myAirports.add(new Airport(380, 260, "IDA", ON_TOP));
  myAirports.add(new Airport(304, 631, "PHX", ON_TOP));
  myAirports.add(new Airport(1276, 839, "MCO", ON_TOP));
  myAirports.add(new Airport(125, 134, "PDX", ON_TOP));
  myAirports.add(new Airport(503, 715, "ELP", ON_TOP));
  myAirports.add(new Airport(56, 427, "SJC", ON_SIDE));
  myAirports.add(new Airport(1470, 253, "BOS", ON_TOP));
  myAirports.add(new Airport(1251, 763, "JAX", ON_TOP));
  myAirports.add(new Airport(754, 896, "CRP", ON_TOP));
  myAirports.add(new Airport(983, 598, "MEM", ON_TOP));
  myAirports.add(new Airport(173, 940, "ADQ", ON_TOP));
  myAirports.add(new Airport(190, 886, "ANC", ON_TOP));
  myAirports.add(new Airport(47, 422, "SFO", ON_TOP));
  myAirports.add(new Airport(1428, 325, "LGA", ON_TOP));
  myAirports.add(new Airport(156, 620, "SNA", ON_SIDE));
  myAirports.add(new Airport(159, 22, "BLI", ON_SIDE));
  myAirports.add(new Airport(1020, 355, "MDW", ON_SIDE));
  myAirports.add(new Airport(156, 635, "SAN", ON_BOTTOM));
  myAirports.add(new Airport(1185, 356, "CLE", ON_TOP));
  myAirports.add(new Airport(956, 480, "STL", ON_TOP));
  myAirports.add(new Airport(1260, 287, "BUF", ON_TOP));
  myAirports.add(new Airport(1242, 854, "TPA", ON_TOP));
  myAirports.add(new Airport(544, 438, "DEN", ON_TOP));
  myAirports.add(new Airport(1259, 694, "SAV", ON_TOP));
  myAirports.add(new Airport(1071, 571, "BNA", ON_TOP));
  myAirports.add(new Airport(100, 168, "EUG", ON_TOP));
  myAirports.add(new Airport(873, 258, "MSP", ON_TOP));
  myAirports.add(new Airport(1159, 415, "CMH", ON_TOP));
  myAirports.add(new Airport(131, 457, "FAT", ON_TOP));
  myAirports.add(new Airport(717, 829, "SAT", ON_TOP));
  myAirports.add(new Airport(805, 577, "TUL", ON_TOP));
  myAirports.add(new Airport(1327, 922, "MIA", ON_BOTTOM));
  myAirports.add(new Airport(1239, 378, "PIT", ON_TOP));
  myAirports.add(new Airport(186, 604, "PSP", ON_SIDE));
  myAirports.add(new Airport(57, 413, "OAK", ON_TOP));
  myAirports.add(new Airport(1377, 378, "PHL", ON_TOP));
  myAirports.add(new Airport(1071, 424, "IND", ON_TOP));
  myAirports.add(new Airport(615, 730, "MAF", ON_TOP));
  myAirports.add(new Airport(1343, 415, "BWI", ON_SIDE));
  myAirports.add(new Airport(1096, 482, "SDF", ON_TOP));
  myAirports.add(new Airport(1430, 287, "BDL", ON_TOP));
  myAirports.add(new Airport(270, 81, "GEG", ON_TOP));
  myAirports.add(new Airport(439, 444, "GJT", ON_TOP));
  myAirports.add(new Airport(1081, 656, "BHM", ON_TOP));
  myAirports.add(new Airport(1148, 643, "ATL", ON_TOP));
  myAirports.add(new Airport(1217, 603, "GSP", ON_TOP));
  myAirports.add(new Airport(1371, 494, "ORF", ON_TOP));
  myAirports.add(new Airport(757, 606, "OKC", ON_TOP));
  myAirports.add(new Airport(413, 110, "GTF", ON_TOP));
  myAirports.add(new Airport(148, 584, "ONT", ON_SIDE));
  myAirports.add(new Airport(736, 954, "MFE", ON_TOP));
  myAirports.add(new Airport(1140, 332, "DTW", ON_TOP));
  myAirports.add(new Airport(1590, 970, "SJU", ON_TOP)); //Puerto Rico not on Map
  myAirports.add(new Airport(74, 138, "MFR", ON_TOP));
  myAirports.add(new Airport(745, 779, "AUS", ON_TOP));
  myAirports.add(new Airport(659, 113, "MOT", ON_TOP));
  myAirports.add(new Airport(112, 875, "BET", ON_TOP));
  myAirports.add(new Airport(473, 575, "ABQ", ON_TOP));
  myAirports.add(new Airport(976, 715, "JAN", ON_TOP));
  myAirports.add(new Airport(485, 394, "HDN", ON_TOP));
  myAirports.add(new Airport(974, 400, "PIA", ON_TOP));
  myAirports.add(new Airport(564, 466, "COS", ON_TOP));
  myAirports.add(new Airport(952, 797, "MSY", ON_TOP));
  myAirports.add(new Airport(623, 267, "RAP", ON_TOP));
  myAirports.add(new Airport(1240, 872, "SRQ", ON_BOTTOM));
  myAirports.add(new Airport(986, 346, "RFD", ON_TOP));
  myAirports.add(new Airport(192, 729, "BRW", ON_BOTTOM));
  myAirports.add(new Airport(1123, 456, "CVG", ON_BOTTOM));
  myAirports.add(new Airport(81, 419, "SCK", ON_TOP));
  myAirports.add(new Airport(1251, 579, "CLT", ON_TOP));
  myAirports.add(new Airport(870, 541, "SGF", ON_TOP));
  myAirports.add(new Airport(233, 754, "SCC", ON_TOP));
  myAirports.add(new Airport(1325, 887, "PBI", ON_SIDE));
  myAirports.add(new Airport(141, 379, "RNO", ON_TOP));
  myAirports.add(new Airport(1464, 287, "PVD", ON_TOP));
  myAirports.add(new Airport(1314, 627, "MYR", ON_TOP));
  myAirports.add(new Airport(1060, 360, "SBN", ON_BOTTOM));
  myAirports.add(new Airport(1296, 661, "CHS", ON_TOP));
  myAirports.add(new Airport(1014, 312, "MKE", ON_TOP));
  myAirports.add(new Airport(78, 532, "SMX", ON_TOP));
  myAirports.add(new Airport(528, 952, "KOA", ON_TOP));
  myAirports.add(new Airport(1291, 276, "ROC", ON_TOP));
  myAirports.add(new Airport(327, 943, "JNU", ON_TOP));
  myAirports.add(new Airport(362, 978, "KTN", ON_TOP));
  myAirports.add(new Airport(237, 906, "CDV", ON_TOP));
  myAirports.add(new Airport(273, 917, "YAK", ON_TOP));
  myAirports.add(new Airport(871, 712, "SHV", ON_TOP));
  myAirports.add(new Airport(853, 576, "XNA", ON_TOP));
  myAirports.add(new Airport(1344, 612, "SIT", ON_TOP));
  myAirports.add(new Airport(268, 236, "BOI", ON_TOP));
  myAirports.add(new Airport(406, 868, "LIH", ON_TOP));
  myAirports.add(new Airport(337, 953, "PSG", ON_TOP));
  myAirports.add(new Airport(336, 961, "WRG", ON_TOP)); // ON TOP OF ANOTHER
  myAirports.add(new Airport(350, 121, "MSO", ON_TOP));
  myAirports.add(new Airport(361, 377, "SLC", ON_TOP));
  myAirports.add(new Airport(220, 823, "FAI", ON_TOP));
  myAirports.add(new Airport(469, 199, "BIL", ON_TOP));
  myAirports.add(new Airport(673, 167, "BIS", ON_TOP));
  myAirports.add(new Airport(327, 643, "AZA", ON_SIDE));
  myAirports.add(new Airport(1313, 542, "RDU", ON_TOP));
  myAirports.add(new Airport(1388, 264, "ALB", ON_TOP));
  myAirports.add(new Airport(975, 480, "BLV", ON_SIDE));
  myAirports.add(new Airport(1408, 319, "HPN", ON_TOP));
  myAirports.add(new Airport(408, 189, "BZN", ON_TOP));
  myAirports.add(new Airport(827, 818, "IAH", ON_BOTTOM));
  myAirports.add(new Airport(557, 950, "ITO", ON_TOP));
  myAirports.add(new Airport(137, 583, "BUR", ON_SIDE));
  myAirports.add(new Airport(1090, 780, "VPS", ON_TOP));
  myAirports.add(new Airport(1332, 476, "RIC", ON_TOP));
  myAirports.add(new Airport(781, 173, "FAR", ON_TOP));
  myAirports.add(new Airport(919, 355, "CID", ON_TOP));
}


void draw()
{
  image(mapImage, 0, 0);
  myFont=loadFont("Arial-Black-48.vlw");
  textFont(myFont);
  textSize(10);
  for (int z = 0; z < myAirports.size(); z++)
  {
    myAirports.get(z).draw();
  }
}

void mousePressed()
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
}
