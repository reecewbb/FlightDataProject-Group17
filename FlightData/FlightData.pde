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

  myAirports.add(new Airport(1410, 335, "JFK"));
  myAirports.add(new Airport(130, 580, "LAX"));
  myAirports.add(new Airport(1330, 420, "DCA"));
  myAirports.add(new Airport(150, 50, "SEA"));
  myAirports.add(new Airport(1320, 900, "FLL"));
  myAirports.add(new Airport(450, 890, "HNL"));
  myAirports.add(new Airport(1015, 340, "ORD"));
  myAirports.add(new Airport(240, 540, "LAS"));
  myAirports.add(new Airport(990, 260, "ATW"));
  myAirports.add(new Airport(780, 700, "DAL"));
  myAirports.add(new Airport(830, 450, "MCI"));
  myAirports.add(new Airport(820, 810, "HOU"));
  myAirports.add(new Airport(1260, 890, "RSW"));
  myAirports.add(new Airport(145, 600, "LGB"));
  myAirports.add(new Airport(60, 390, "SMF"));
  myAirports.add(new Airport(600, 650, "LBB"));
  myAirports.add(new Airport(760, 710, "DFW"));
  myAirports.add(new Airport(500, 910, "OGG"));
  myAirports.add(new Airport(1395, 340, "EWR"));
  myAirports.add(new Airport(380, 260, "IDA"));
  myAirports.add(new Airport(304, 631, "PHX"));
  myAirports.add(new Airport(1276, 839, "MCO"));
  myAirports.add(new Airport(125, 134, "PDX"));
  myAirports.add(new Airport(503, 715, "ELP"));
  myAirports.add(new Airport(56, 427, "SJC"));
  myAirports.add(new Airport(1470, 253, "BOS"));
  myAirports.add(new Airport(1251, 763, "JAX"));
  myAirports.add(new Airport(754, 896, "CRP"));
  myAirports.add(new Airport(983, 598, "MEM"));
  myAirports.add(new Airport(173, 940, "ADQ"));
  myAirports.add(new Airport(190, 886, "ANC"));
  myAirports.add(new Airport(47, 422, "SFO"));
  myAirports.add(new Airport(1428, 325, "LGA"));
  myAirports.add(new Airport(156, 620, "SNA"));
  myAirports.add(new Airport(159, 22, "BLI"));
  myAirports.add(new Airport(1020, 355, "MDW"));
  myAirports.add(new Airport(156, 635, "SAN"));
  myAirports.add(new Airport(1185, 356, "CLE"));
  myAirports.add(new Airport(956, 480, "STL"));
  myAirports.add(new Airport(1260, 287, "BUF"));
  myAirports.add(new Airport(1242, 854, "TPA"));
  myAirports.add(new Airport(544, 438, "DEN"));
  myAirports.add(new Airport(1259, 694, "SAV"));
  myAirports.add(new Airport(1071, 571, "BNA"));
  myAirports.add(new Airport(100, 168, "EUG"));

}


void draw()
{
  image(mapImage, 0, 0);
  myFont=loadFont("Arial-Black-48.vlw");
  textFont(myFont);
  textSize(10);
  for (int i = 0; i < myAirports.size(); i++)
  {
    fill(0);
    rect((myAirports.get(i)).getX(), (myAirports.get(i)).getY(), 10, 10, 10);
    text((myAirports.get(i)).getAirportName(), (myAirports.get(i)).getX(), (myAirports.get(i)).getY());
  }
}

void mousePressed()  {
  System.out.println("x value: " + mouseX + "/n y value: " + mouseY);
}
