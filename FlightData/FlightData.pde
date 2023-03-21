import java.util.Scanner; //<>// //<>// //<>//
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
PImage mapImage;
Screen currentScreen = new Screen();
Screen mapScreen = new Screen();
Screen chartScreen = new Screen();

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
  
  currentScreen = mapScreen;

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

  for(int i = 0; i < myAirports.size(); i++)
  {
    mapScreen.addAirport(myAirports.get(i));
  }
}


void draw()
{
  currentScreen.draw();
} //<>// //<>//

void mousePressed()  
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
}

void mouseMoved()
{
  for(int z = 0; z < myAirports.size(); z++)
  {
    myAirports.get(z).strokeAirport(mouseX, mouseY);
  }
}
