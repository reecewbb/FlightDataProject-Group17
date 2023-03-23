import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
PImage mapImage;
Screen mapScreen, chartScreen, currentScreen, topLeft;
BarChart chart;
int event;
Filter mapFilter;
Widget backToMapButton, currF1, currF2, currF3;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  background(255);
  mapScreen = new Screen(MAP_SCREEN);
  chartScreen = new Screen(BAR_CHART_SCREEN);
  mapFilter = new Filter();
  mapFilter.addAirports(myAirports);
  currentScreen = mapScreen;
  importDataFromFile();
  System.out.println(airportNames);
  System.out.println(airportNames.size());
  ellipseMode(RADIUS);
  for (int i = 0; i < myAirports.size(); i++)
  {
    mapScreen.addAirport(myAirports.get(i));
    (myAirports.get(i)).setID(i);
  }
  backToMapButton = new Widget(20, 20, 80, 30, "Back to Map", color(180), myFont, myAirports.size() + 1);
  currF1= new Widget(1500,700, 50, 20, "A-K", color(180), myFont, myAirports.size()+2);
  currF2= new Widget(1500,775, 50, 20, "L-V", color(180), myFont, myAirports.size()+3);
  currF3= new Widget(1500,850, 50, 20, "W-Z", color(180), myFont, myAirports.size()+4);
  chartScreen.addWidget(backToMapButton);
  mapScreen.addWidget(currF1);
  mapScreen.addWidget(currF2);
  mapScreen.addWidget(currF3);
}


void draw()
{
  background(255);
  currentScreen.draw(event, myAirports, myFlights); //<>//
}

void mousePressed()
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
  event = currentScreen.buttonClicked();
  if(event >= 0 && event < myAirports.size()) 
  {
    currentScreen = chartScreen;
  }
  if(event == myAirports.size() + 1)          // if back to map button is clicked
  {
    currentScreen = mapScreen;
  }
  if(event == myAirports.size() + 2)          // if A-K button is clicked 
  {
    
  }
  if(event == myAirports.size() + 3)          // if L-V button is pressed 
  {
    
  }
  if(event == myAirports.size() + 4)          // if W-Z button is pressed 
  {
    
  }
}

void mouseMoved()
{
  for (int i = 0; i < myAirports.size(); i++)
  {
    myAirports.get(i).strokeAirport(mouseX, mouseY);
  }
   backToMapButton.hover(mouseX, mouseY);
   currF1.hover(mouseX, mouseY);
   currF2.hover(mouseX, mouseY);
   currF3.hover(mouseX, mouseY);
}

void importDataFromFile()  {
  try {
    File myFile = new File("flights100k.csv");
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
}
