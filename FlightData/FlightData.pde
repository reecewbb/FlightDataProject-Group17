import java.util.Scanner; //<>//
import java.io.File;
import java.util.ArrayList;
import de.bezier.data.sql.*;

PostgreSQL pgsql;
PFont myFont;
ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> myAirports = new ArrayList<Airport>();
ArrayList<Screen> zoomScreens = new ArrayList<Screen>();
PImage mapImage, alaskaMapImage, hawaiiMapImage;
PImage[] US, Alaska, Hawaii, Departures, Arrivals, Airlines;
Screen mapScreen, currentScreen, topLeft, topMid, topRight, midLeft, midMid, midRight, botLeft, botMid, botRight, startScreen, chartSelectionScreen, alaskaScreen, hawaiiScreen, regionScreen;
Screen pieChartScreen, outgoingChartScreen, incomingChartScreen, searchScreen;
BarChart chart;
int event, lastAirportSelected, previousEvent, previousEventScreen;
Filter mapFilter;
Widget backToMapButton, AKButton, LSButton, TZButton, allButton, USMapButton, backToStartButton, outgoingBarChartButton, incomingBarChartButton, alaskaMapButton, hawaiiMapButton, backToSelectionButton;
Widget backToAlaskaMapButton, backToHawaiiMapButton, pieChartButton, searchScreenButton;
Search searchBar;
boolean drawingGraph;
BarChart outgoingFlightsChart, incomingFlightsChart;
PieChart airlinesChart;
String text1 = "";
String mostCommonAirline, highestOutgoingName, highestIncomingName, cityName, airportName;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  String user     = "postgres";
  String pass     = "group17";
  String database = "AirlineData";
  pgsql = new PostgreSQL( this, "localhost", database, user, pass );
  if ( pgsql.connect() )
  {
    pgsql.query( "SELECT COUNT(*) FROM airlinedata" );
    if ( pgsql.next() )
    {
      println( "number of rows in table airlineData: " + pgsql.getInt(1) );
    }
  }
  background(WHITE);
  textAlign(CENTER);
  cityName = "error";
  airportName = "error";
  setScreens();
  searchBar = new Search();
  mapFilter = new Filter();
  mapFilter.addAirports(myAirports);
  System.out.println(airportNames);
  System.out.println(airportNames.size());
  ellipseMode(RADIUS);
  addAirportsToMaps();
  addDataToAirports();
  addWidgets();
  drawingGraph = false;
  allButton.setColour();
}


void draw()
{
  background(WHITE);
  currentScreen.draw(event, mapFilter);
}

void mousePressed()
{
  System.out.println("x value: " + mouseX + "\ny value: " + mouseY);
  event = currentScreen.buttonClicked();
  int eventNo = event;
  if (event >= CHART_SELECTION_EVENT && event < myAirports.size() + CHART_SELECTION_EVENT)
  {
    eventNo = CHART_SELECTION_EVENT;
  }
  switch(eventNo)
  {
  case BACK_BUTTON_EVENT:
    currentScreen = regionScreen;
    break;

  case AK_EVENT:
    mapFilter.currentFilter = AK_FILTER;
    AKButton.setColour();
    LSButton.unsetColour();
    TZButton.unsetColour();
    allButton.unsetColour();
    break;

  case LS_EVENT:
    mapFilter.currentFilter = LS_FILTER;
    AKButton.unsetColour();
    LSButton.setColour();
    TZButton.unsetColour();
    allButton.unsetColour();
    break;

  case TZ_EVENT:
    mapFilter.currentFilter = TZ_FILTER;
    AKButton.unsetColour();
    LSButton.unsetColour();
    TZButton.setColour();
    allButton.unsetColour();
    break;

  case NO_FILTER_EVENT:
    mapFilter.currentFilter = NO_FILTER;
    AKButton.unsetColour();
    LSButton.unsetColour();
    TZButton.unsetColour();
    allButton.setColour();
    break;

  case TOP_LEFT_EVENT:
  case TOP_MID_EVENT:
  case TOP_RIGHT_EVENT:
  case MID_LEFT_EVENT:
  case MID_MID_EVENT:
  case MID_RIGHT_EVENT:
  case BOT_LEFT_EVENT:
  case BOT_MID_EVENT:
  case BOT_RIGHT_EVENT:
    currentScreen = zoomScreens.get(event - TOP_LEFT_EVENT);
    break;

  case SELECT_US_EVENT:
    currentScreen = mapScreen;
    regionScreen = currentScreen;
    break;

  case BACK_TO_START_EVENT:
    currentScreen = startScreen;
    break;

  case OUTGOING_BAR_CHART_EVENT:
    event = lastAirportSelected;
    currentScreen = outgoingChartScreen;
    break;

  case INCOMING_BAR_CHART_EVENT:
    event = lastAirportSelected;
    currentScreen = incomingChartScreen;
    break;

  case SELECT_ALASKA_EVENT:
    currentScreen = alaskaScreen;
    regionScreen = currentScreen;
    break;

  case SELECT_HAWAII_EVENT:
    currentScreen = hawaiiScreen;
    regionScreen = currentScreen;
    break;

  case BACK_SELECTION_EVENT: //<>//
    currentScreen = chartSelectionScreen;
    break;

  case PIE_CHART_EVENT:
    currentScreen = pieChartScreen;
    break;

  case SELECT_SEARCH_EVENT:
    currentScreen = searchScreen;
    break;

  case CHART_SELECTION_EVENT:
    currentScreen = chartSelectionScreen;
    Airport currentAirport = myAirports.get(event - CHART_SELECTION_EVENT);
    String airportName = currentAirport.getAirportName();
    chartSelectionScreen.setOutgoingFlights(calculateFlights(airportName, OUTGOING));
    chartSelectionScreen.setIncomingFlights(calculateFlights(airportName, INCOMING));
    lastAirportSelected = event;
    break;
  }
}

int calculateFlights(String airportName, int direction)
{
    String queryStr;
    if(direction == INCOMING) queryStr = "DEST";
    else queryStr = "ORIGIN";
    int total = 0;
    pgsql.query( "SELECT COUNT(*) FROM airlinedata WHERE " + queryStr + " = '" + airportName + "'");
    if ( pgsql.next() )
    {
      total = pgsql.getInt(1);
    }
    return total;
}

void mouseMoved()
{
  if (currentScreen != mapScreen)
  {
    for (Airport currentAirport : myAirports)
    {
      currentAirport.strokeAirport();
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
  searchScreenButton.hover();
  pieChartButton.hover();
  currentScreen.hover();
}

void addAirportsToMaps()
{
  for (Airport currentAirport : myAirports)
  {
    switch(currentAirport.getRegion())
    {
    case US_REGION:
      mapScreen.addAirport(currentAirport);
      topLeft.addAirport(currentAirport);
      topMid.addAirport(currentAirport);
      topRight.addAirport(currentAirport);
      midLeft.addAirport(currentAirport);
      midMid.addAirport(currentAirport);
      midRight.addAirport(currentAirport);
      botLeft.addAirport(currentAirport);
      botMid.addAirport(currentAirport);
      botRight.addAirport(currentAirport);
      break;

    case ALASKA_REGION:
      alaskaScreen.addAirport(currentAirport);
      break;

    case HAWAII_REGION:
      hawaiiScreen.addAirport(currentAirport);
      break;
    }
  }
}

void addDataToAirports()
{
  int i = 0;
  for (Airport currentAirport : myAirports) //<>//
  {
    currentAirport.setID(i);
    i++;
  }
}

void setScreens()
{
  alaskaScreen = new Screen(ALASKA_SCREEN);
  hawaiiScreen = new Screen(HAWAII_SCREEN);
  mapScreen = new Screen(MAP_SCREEN);
  outgoingChartScreen = new Screen(OUTGOING_BAR_CHART_SCREEN);
  incomingChartScreen = new Screen(INCOMING_BAR_CHART_SCREEN);
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
  pieChartScreen = new Screen(PIE_CHART_SCREEN);
  searchScreen = new Screen(SEARCH_SCREEN);
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


void addWidgets()
{
  alaskaMapButton = new Widget(ALASKA_X_START, TOP_ROW_Y_START, START_MAP_WIDTH, 300, SELECT_ALASKA_EVENT);
  hawaiiMapButton = new Widget(HAWAII_X_START, HAWAII_Y_START, START_MAP_WIDTH, 300, SELECT_HAWAII_EVENT);
  backToSelectionButton = new Widget(20, 20, (int) textWidth("Back") + 100, 40, "Back", color(WIDGET_COLOUR), myFont, BACK_SELECTION_EVENT, WHITE);
  backToMapButton = new Widget(20, 20, (int) textWidth("Back") + 100, 40, "Back", color(WIDGET_COLOUR), myFont, BACK_BUTTON_EVENT, WHITE);
  backToStartButton = new Widget(20, 20, (int) textWidth("Back") + 100, 40, "Back", color(WIDGET_COLOUR), myFont, BACK_TO_START_EVENT, WHITE);
  outgoingBarChartButton = new Widget(DEP_X, DEP_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, OUTGOING_BAR_CHART_EVENT);
  incomingBarChartButton = new Widget(ARR_X, ARR_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, INCOMING_BAR_CHART_EVENT);
  pieChartButton = new Widget(PIE_X, PIE_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, PIE_CHART_EVENT);
  USMapButton = new Widget(150, 250, START_MAP_WIDTH, 300, SELECT_US_EVENT);
  AKButton= new Widget(FILTER_WIDGET_X, 745, FILTER_WIDGET_WIDTH, FILTER_WIDGET_HEIGHT, "A - K", color(WIDGET_COLOUR), myFont, AK_EVENT, WHITE);
  LSButton= new Widget(FILTER_WIDGET_X, 790, FILTER_WIDGET_WIDTH, FILTER_WIDGET_HEIGHT, "L - S ", color(WIDGET_COLOUR), myFont, LS_EVENT, WHITE);
  TZButton= new Widget(FILTER_WIDGET_X, 835, FILTER_WIDGET_WIDTH, FILTER_WIDGET_HEIGHT, "T - Z", color(WIDGET_COLOUR), myFont, TZ_EVENT, WHITE);
  allButton= new Widget(FILTER_WIDGET_X, 700, FILTER_WIDGET_WIDTH, FILTER_WIDGET_HEIGHT, "ALL", color(WIDGET_COLOUR), myFont, NO_FILTER_EVENT, WHITE);
  searchScreenButton = new Widget(1400, 98, FILTER_WIDGET_WIDTH+30, FILTER_WIDGET_HEIGHT, "Search", color(WHITE), myFont, SELECT_SEARCH_EVENT, BLACK);
  searchScreen.addWidget(backToStartButton);
  outgoingChartScreen.addWidget(backToSelectionButton);
  incomingChartScreen.addWidget(backToSelectionButton);
  pieChartScreen.addWidget(backToSelectionButton);
  chartSelectionScreen.addWidget(backToMapButton);
  chartSelectionScreen.addWidget(outgoingBarChartButton);
  chartSelectionScreen.addWidget(incomingBarChartButton);
  chartSelectionScreen.addWidget(pieChartButton);
  startScreen.addWidget(USMapButton);
  startScreen.addWidget(alaskaMapButton);
  startScreen.addWidget(hawaiiMapButton);
  startScreen.addWidget(searchScreenButton);
  mapScreen.addWidget(backToStartButton);
  alaskaScreen.addWidget(backToStartButton);
  hawaiiScreen.addWidget(backToStartButton);
  for (Screen currentZoom : zoomScreens)
  {
    currentZoom.addWidget(backToMapButton);
    currentZoom.addWidget(AKButton);
    currentZoom.addWidget(LSButton);
    currentZoom.addWidget(TZButton);
    currentZoom.addWidget(allButton);
  }
  mapScreen.addWidget(AKButton);
  mapScreen.addWidget(LSButton);
  mapScreen.addWidget(TZButton);
  mapScreen.addWidget(allButton);
}
