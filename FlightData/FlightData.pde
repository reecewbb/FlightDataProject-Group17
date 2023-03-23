import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
PImage mapImage;
Screen mapScreen, chartScreen, currentScreen;
BarChart chart;
Filter mapFilter;
Widget backToMapButton, currF, currF2, currF3, currF4;
int event;

void settings() {
  size(SCREENX, SCREENY);
  mapImage = loadImage("Blank_US_Map.png");
  mapImage.resize(SCREENX, SCREENY);
}

void setup() {
  background(255);
  mapScreen = new Screen(MAP_SCREEN);
  chartScreen = new Screen(BAR_CHART_SCREEN);
  mapFilter = new Filter();
  currentScreen = mapScreen;
  importDataFromFile();
  System.out.println(airportNames);
  System.out.println(airportNames.size());
  mapFilter.addAirports(myAirports);
  ellipseMode(RADIUS);
  for (int i = 0; i < myAirports.size(); i++)
  {
    mapScreen.addAirport(myAirports.get(i));
    (myAirports.get(i)).setID(i);
  }
  backToMapButton = new Widget(20, 20, 80, 30, "Back to Map", color(180), myFont, myAirports.size() + 1);
  chartScreen.addWidget(backToMapButton);
  
currF= new Widget(1500,700, 65, 20, "[ A - K ]", color(180), myFont, myAirports.size()+2  );
currF2= new Widget(1500,725, 65, 20, "[ L - S ]", color(180), myFont, myAirports.size()+3  );
currF3= new Widget(1500,750, 65, 20, "[ T - Z ]", color(180), myFont, myAirports.size()+4  );
currF4= new Widget(1500,775, 65, 20, "[ NONE ]", color(180), myFont, myAirports.size()+5  );
mapScreen.addWidget(currF);
mapScreen.addWidget(currF2);
mapScreen.addWidget(currF3);
mapScreen.addWidget(currF4);
}


void draw()
{
  background(255);
  currentScreen.draw(event, myAirports, myFlights);
  
  if(mapFilter.currentFilter !=0){
  mapFilter.showAirports(myAirports);}
  
}

void mousePressed()
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
  event = currentScreen.buttonClicked();
  if (event >= 0 && event < myAirports.size()) currentScreen = chartScreen;
  if (event == myAirports.size() + 1) currentScreen = mapScreen;
  if (event == myAirports.size() + 2) mapFilter.currentFilter = 1;
  if (event == myAirports.size() + 3) mapFilter.currentFilter = 2;
  if (event == myAirports.size() + 4) mapFilter.currentFilter = 3;
  if (event == myAirports.size() + 5) mapFilter.currentFilter = 4;
}

void mouseMoved()
{
  for (int z = 0; z < myAirports.size(); z++)
  {
    myAirports.get(z).strokeAirport(mouseX, mouseY);
  }
  backToMapButton.hover(mouseX, mouseY);
  
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
