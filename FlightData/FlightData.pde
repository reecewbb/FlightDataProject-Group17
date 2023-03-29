import java.util.Scanner;    
import java.io.File;
import java.util.ArrayList;

PFont myFont;
ArrayList<Flight> myFlights = new ArrayList<Flight>();
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
ArrayList<Screen> zoomScreens = new ArrayList<Screen>();
PImage mapImage, alaskaMapImage, hawaiiMapImage;
PImage[] US, Alaska, Hawaii, Departures, Arrivals;
Screen mapScreen, chartScreen, currentScreen, topLeft, topMid, topRight, midLeft, midMid, midRight, botLeft, botMid, botRight, startScreen, chartSelectionScreen, alaskaScreen, hawaiiScreen;
BarChart chart;
int event, lastAirportSelected;
int previousEvent;
Filter mapFilter;
Widget backToMapButton, AKButton, LSButton, TZButton, allButton, USMapButton, backToStartButton, outgoingBarChartButton, incomingBarChartButton, alaskaMapButton, hawaiiMapButton, backToSelectionButton;
boolean drawingGraph;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  background(WHITE);
  textAlign(CENTER);
  importDataFromFile();
  setScreens();
  mapFilter = new Filter();
  mapFilter.addAirports(myAirports);
  System.out.println(airportNames);
  System.out.println(airportNames.size());
  ellipseMode(RADIUS);
  addAirportsToMaps();
  addWidgets();
  addDataToAirports();
  drawingGraph = false;
}


void draw()
{
  background(WHITE);
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
    AKButton.setColour();
    LSButton.unsetColour();
    TZButton.unsetColour();
    allButton.unsetColour();
  } 
  else if (event == LS_EVENT)
  {
    mapFilter.currentFilter = LS_FILTER;
    AKButton.unsetColour();
    LSButton.setColour();
    TZButton.unsetColour();
    allButton.unsetColour();
  } 
  else if (event == TZ_EVENT)
  {
    mapFilter.currentFilter = TZ_FILTER;
    AKButton.unsetColour();
    LSButton.unsetColour();
    TZButton.setColour();
    allButton.unsetColour();
  } 
  else if (event == NO_FILTER_EVENT)
  {
    mapFilter.currentFilter = NO_FILTER;
    AKButton.unsetColour();
    LSButton.unsetColour();
    TZButton.unsetColour();
    allButton.setColour();
  } 
  else if (event >= TOP_LEFT_EVENT && event <= BOT_RIGHT_EVENT)
  {
    currentScreen = zoomScreens.get(event - TOP_LEFT_EVENT);
  } 
  else if (event == SELECT_US_EVENT)
  {
    currentScreen = mapScreen;
  } 
  else if (event == BACK_TO_START_EVENT)
  {
    currentScreen = startScreen;
  } 
  else if (event == OUTGOING_BAR_CHART_EVENT || event == INCOMING_BAR_CHART_EVENT)
  {
    if (event == OUTGOING_BAR_CHART_EVENT) chartScreen.setQuery(OUTGOING);
    if (event == INCOMING_BAR_CHART_EVENT) chartScreen.setQuery(INCOMING);
    event = lastAirportSelected;
    currentScreen = chartScreen;
  }
  else if (event == SELECT_ALASKA_EVENT)
  {
    currentScreen = alaskaScreen;
  }
  else if (event == SELECT_HAWAII_EVENT)
  {
    currentScreen = hawaiiScreen;
  }
  else if (event == BACK_SELECTION_EVENT)
  {
    currentScreen = chartSelectionScreen;
  }
  else if (event >= NUMBER_OF_EVENTS && event < myAirports.size() + NUMBER_OF_EVENTS)
  {
    currentScreen = chartSelectionScreen;
    Airport currentAirport = myAirports.get(event - NUMBER_OF_EVENTS);
    int outgoingFlights = currentAirport.getAmountOfOutgoingFlights(myFlights);
    chartSelectionScreen.setOutgoingFlights(outgoingFlights);
    lastAirportSelected = event;
  }
}

void mouseMoved()
{
  if (currentScreen != mapScreen)
  {
    for (int i = 0; i < myAirports.size(); i++)
    {
      myAirports.get(i).strokeAirport();
    }
  }
  backToMapButton.hover();
  AKButton.hover();
  LSButton.hover();
  TZButton.hover();
  allButton.hover();
  backToStartButton.hover();
  backToSelectionButton.hover();
  outgoingBarChartButton.hover();
  incomingBarChartButton.hover();
  currentScreen.hover();
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
  }
}

void addDataToAirports()
{
  for (int i = 0; i < myAirports.size(); i++)
  {
    Airport currentAirport = (Airport) myAirports.get(i);
    currentAirport.setID(i);
    String airportName = currentAirport.getAirportName();
    boolean hasStateName = false;
    int  j = 0;
    while(!hasStateName && j < myFlights.size())
    {
      Flight currentFlight = (Flight) myFlights.get(j);
      String origin = currentFlight.getOrigin();
      if(airportName.equals(origin))
      {
        String currentCityName = currentFlight.getCityName();
        currentAirport.setCityName(currentCityName);
        hasStateName = true;
      }
      j++;
    }
  }
}

void setScreens() {
  alaskaScreen = new Screen(ALASKA_SCREEN);
  hawaiiScreen = new Screen(HAWAII_SCREEN);
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
  startScreen = new Screen(START_SCREEN);
  chartSelectionScreen = new Screen(CHART_SELECT_SCREEN);
  currentScreen = startScreen;
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
        data = data.replaceAll("\"", "");
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
  alaskaMapButton = new Widget(ALASKA_X_START, TOP_ROW_Y_START, START_MAP_WIDTH, 300, SELECT_ALASKA_EVENT);
  hawaiiMapButton = new Widget(HAWAII_X_START, HAWAII_Y_START, START_MAP_WIDTH, 300, SELECT_HAWAII_EVENT);
  backToSelectionButton = new Widget(20, 20, (int) textWidth("BACK") + 50, 30, "<- Back", color(WIDGET_COLOUR), myFont, BACK_SELECTION_EVENT, WHITE);
  backToMapButton = new Widget(20, 20, (int) textWidth("BACK") + 50, 30, "<- Back", color(WIDGET_COLOUR), myFont, BACK_BUTTON_EVENT, WHITE);
  backToStartButton = new Widget(20, 20, (int) textWidth("BACK") + 50, 30, "<- Back", color(WIDGET_COLOUR), myFont, BACK_TO_START_EVENT, WHITE);
  outgoingBarChartButton = new Widget(DEP_X, DEP_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, OUTGOING_BAR_CHART_EVENT);
  incomingBarChartButton = new Widget(ARR_X, ARR_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, INCOMING_BAR_CHART_EVENT);
  USMapButton = new Widget(150, 250, START_MAP_WIDTH, 300, SELECT_US_EVENT);
  AKButton= new Widget(1500, 700, 65, 20, "[ A - K ]", color(WIDGET_COLOUR), myFont, AK_EVENT, WHITE);
  LSButton= new Widget(1500, 725, 65, 20, "[ L - S ]", color(WIDGET_COLOUR), myFont, LS_EVENT, WHITE);
  TZButton= new Widget(1500, 750, 65, 20, "[ T - Z ]", color(WIDGET_COLOUR), myFont, TZ_EVENT, WHITE);
  allButton= new Widget(1500, 775, 65, 20, "[ ALL ]", color(WIDGET_COLOUR), myFont, NO_FILTER_EVENT, WHITE);
  chartScreen.addWidget(backToSelectionButton);
  chartSelectionScreen.addWidget(backToMapButton);
  chartSelectionScreen.addWidget(outgoingBarChartButton);
  chartSelectionScreen.addWidget(incomingBarChartButton);
  startScreen.addWidget(USMapButton);
  startScreen.addWidget(alaskaMapButton);
  startScreen.addWidget(hawaiiMapButton);
  mapScreen.addWidget(backToStartButton);
  alaskaScreen.addWidget(backToStartButton);
  hawaiiScreen.addWidget(backToStartButton);
  for (int i = 0; i < zoomScreens.size(); i++)
  {
    Screen currentZoom = zoomScreens.get(i);
    currentZoom.addWidget(backToMapButton);
  }
  mapScreen.addWidget(AKButton);
  mapScreen.addWidget(LSButton);
  mapScreen.addWidget(TZButton);
  mapScreen.addWidget(allButton);
}
