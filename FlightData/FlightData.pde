import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
ArrayList<Screen> zoomScreens = new ArrayList<Screen>();
PImage mapImage;
Screen mapScreen, chartScreen, currentScreen, topLeft, topMid, topRight, midLeft, midMid, midRight, botLeft, botMid, botRight;
BarChart chart;
int event, backButtonEvent, AKEvent, LVEvent, WZEvent, NoFilterEvent, startZoomEvent, endZoomEvent;
int previousEvent;
Filter mapFilter;
Widget backToMapButton, currF1, currF2, currF3, currF4;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  background(255);
  importDataFromFile();
  setScreens();
  mapFilter = new Filter();
  mapFilter.addAirports(myAirports);
  currentScreen = mapScreen;
  System.out.println(airportNames);
  System.out.println(airportNames.size());
  ellipseMode(RADIUS);
  addAirportsToMaps();
  addWidgets();
}


void draw()
{
  background(255);
  currentScreen.draw(event, myAirports, myFlights, mapFilter);
}

void mousePressed()
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
  event = currentScreen.buttonClicked();
  if (event == BACK_BUTTON_EVENT)          
  {
    currentScreen = mapScreen;
  } 
  else if (event == AK_EVENT)          
  {
    mapFilter.currentFilter = AK_FILTER;
  } 
  else if (event == LS_EVENT)          
  {
    mapFilter.currentFilter = LS_FILTER;
  } 
  else if (event == TZ_EVENT)          
  {
    mapFilter.currentFilter = TZ_FILTER;
  } 
  else if (event == NO_FILTER_EVENT)
  {
    mapFilter.currentFilter = NO_FILTER;
  }
  else if (event >= TOP_LEFT_EVENT && event <= BOT_RIGHT_EVENT)
  {
    currentScreen = zoomScreens.get(event - TOP_LEFT_EVENT);
  }
  if (event > NUMBER_OF_EVENTS && event < myAirports.size() + NUMBER_OF_EVENTS)
  {
    currentScreen = chartScreen;
  } 
}

void mouseMoved()
{
  if(currentScreen != mapScreen)
  {
    for (int i = 0; i < myAirports.size(); i++)
    {
      myAirports.get(i).strokeAirport(mouseX, mouseY);
    }
  }
  backToMapButton.hover(mouseX, mouseY);
  currF1.hover(mouseX, mouseY);
  currF2.hover(mouseX, mouseY);
  currF3.hover(mouseX, mouseY);
  currF4.hover(mouseX, mouseY);
}

void addAirportsToMaps()
{
  for (int i = 0; i < myAirports.size(); i++)
  {
    mapScreen.addAirport(myAirports.get(i));
    topLeft.addAirport(myAirports.get(i));
    topMid.addAirport(myAirports.get(i));
    topRight.addAirport(myAirports.get(i));
    midLeft.addAirport(myAirports.get(i));
    midMid.addAirport(myAirports.get(i));
    midRight.addAirport(myAirports.get(i));
    botLeft.addAirport(myAirports.get(i));
    botMid.addAirport(myAirports.get(i));
    botRight.addAirport(myAirports.get(i));
    (myAirports.get(i)).setID(i);
  }
}

void setScreens(){
  mapScreen = new Screen(MAP_SCREEN);
  chartScreen = new Screen(BAR_CHART_SCREEN);
  topLeft = new Screen(TOP_LEFT_SCREEN);
  topMid = new Screen(TOP_MID_SCREEN);
  topRight = new Screen(TOP_RIGHT_SCREEN);
  midLeft = new Screen(MID_LEFT_SCREEN);
  midMid = new Screen(MID_MID_SCREEN);
  midRight = new Screen(MID_RIGHT_SCREEN);
  botLeft = new Screen(BOT_LEFT_SCREEN);
  botMid = new Screen(BOT_MID_SCREEN);
  botRight = new Screen(BOT_RIGHT_SCREEN);
  zoomScreens.add(topLeft);
  zoomScreens.add(topMid);
  zoomScreens.add(topRight);
  zoomScreens.add(midLeft);
  zoomScreens.add(midMid);
  zoomScreens.add(midRight);
  zoomScreens.add(botLeft);
  zoomScreens.add(botMid);
  zoomScreens.add(botRight);
}

void importDataFromFile()
{
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

void addWidgets()
{
  backToMapButton = new Widget(20, 20, 80, 30, "Back to Map", color(180), myFont, BACK_BUTTON_EVENT);
  currF1= new Widget(1500, 700, 65, 20, "[ A - K ]", color(180), myFont, AK_EVENT);
  currF2= new Widget(1500, 725, 65, 20, "[ L - S ]", color(180), myFont, LS_EVENT);
  currF3= new Widget(1500, 750, 65, 20, "[ T - Z ]", color(180), myFont, TZ_EVENT);
  currF4= new Widget(1500, 775, 65, 20, " [ ALL ] ", color(180), myFont, NO_FILTER_EVENT);
  chartScreen.addWidget(backToMapButton);
  for (int i = 0; i < zoomScreens.size(); i++)
  {
    Screen currentZoom = zoomScreens.get(i);
    currentZoom.addWidget(backToMapButton);
  }
  mapScreen.addWidget(currF1);
  mapScreen.addWidget(currF2);
  mapScreen.addWidget(currF3);
  mapScreen.addWidget(currF4);
}
