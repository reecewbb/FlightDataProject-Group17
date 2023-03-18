import java.util.Scanner; //<>//
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> myAirports = new ArrayList<String>();
PImage mapImage;

void settings() {
  size(SCREENX, SCREENY);
  mapImage = loadImage("US-Blank-map.jpg");
  mapImage.resize(SCREENX, SCREENY);
}

void setup() {
  background(0);

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
          for (int j = 0; j < myAirports.size() && !repeat; j++)
          {
            repeat = myAirports.contains(data);
          }
          if (!repeat)
          {
            myAirports.add(data);
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
}

void draw()
{
  
  System.out.println(myAirports);
  System.out.println(myAirports.size());
}
