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

  myAirports.add(new Airport(1400, 330, "JFK"));
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
  System.out.println(airportNames);
  System.out.println(airportNames.size());
}
