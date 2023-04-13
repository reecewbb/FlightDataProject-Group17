import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;
import de.bezier.data.sql.*;
import controlP5.*;

PostgreSQL pgsql;
ControlP5 cp5;
PFont myFont, bigFont;
ArrayList<Airport> myAirports;
ArrayList<Screen> zoomScreens;
Screen mapScreen, currentScreen, topLeft, topMid, topRight, midLeft, midMid, midRight, botLeft, botMid, botRight, startScreen, chartSelectionScreen, alaskaScreen, hawaiiScreen, regionScreen;
Screen pieChartScreenArrDep, pieChartScreenCanDiv, outgoingChartScreen, incomingChartScreen, searchScreen;
int event, lastAirportSelected, previousEventScreen, amountOfOperatingAirlines, currentFrame, loading, canCount, divCount;
float percentRoundedCancelled, percentRoundedDiverted;
Filter mapFilter;
Widget backToMapButton, AKButton, LSButton, TZButton, allButton, USMapButton, backToStartButton, outgoingBarChartButton, incomingBarChartButton, alaskaMapButton, hawaiiMapButton, backToSelectionButton;
Widget backToAlaskaMapButton, backToHawaiiMapButton, pieChartButtonArrDep, pieChartButtonCanDiv, searchScreenButton, nextFlightButton, previousFlightButton, searchByNumberButton, searchByOriginButton;
Widget searchByDateButton, searchByDestButton, filterByCanButton, filterByDivButton;
Search searchBar;
BarChart outgoingFlightsChart, incomingFlightsChart;
PieChart airlinesChart, flightsChart;
String mostCommonAirline, highestOutgoingName, highestIncomingName, cityName, airportName;
boolean loadingComplete, fromAirport;
PImage[] gifFrames;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup()
{
  loadingComplete = fromAirport = false;
  bigFont = loadFont("MicrosoftJhengHeiRegular-60.vlw");
  gifFrames = new PImage[11]; 
  for (int i = 0; i < gifFrames.length; i++) {
    gifFrames[i] = loadImage("frame" + i + ".gif");
  }
  currentFrame = 0;
  loading = 0;
  new Thread(new Runnable()
  {
    public void run()
    {
      loadData();
    }
  }
  ).start();
}

void loadData()
{
  String user     = "postgres";
  String pass     = "airlineDataViewerGroup17";
  String database = "postgres";
  pgsql = new PostgreSQL( this, "db.sujqsfodzyzprozcickq.supabase.co", database, user, pass );
  if ( pgsql.connect() )
  {
    pgsql.query( "SELECT COUNT(*) FROM airlinedata" );
    if ( pgsql.next() )
    {
      println( "number of rows in table airlineData: " + pgsql.getInt(1) );
    }
  }
  cp5 = new ControlP5(this);
  background(WHITE);
  textAlign(CENTER);
  myAirports = new ArrayList<Airport>();
  zoomScreens = new ArrayList<Screen>();
  cityName = "error";
  airportName = "error";
  setScreens();
  searchBar = new Search();
  mapFilter = new Filter();
  mapFilter.addAirports(myAirports);
  ellipseMode(RADIUS);
  addAirportsToMaps();
  addDataToAirports();
  addWidgets();
  allButton.setColour();
  searchByNumberButton.setColour();
  loadingComplete = true;
}


void draw()
{
  background(WHITE);
  if (!loadingComplete)
  {
    frameRate(10);
    fill(BLACK);
    imageMode(CENTER);
    textAlign(CENTER);
    textFont(bigFont);
    textSize(70);
    text("AIRPORT DATA VIEWER", SCREENX/2, 180);
    textSize(50);
    String dots = "";
    for (int i = 0; i < loading; i++)
    {
      dots += ".";
    }
    text("Loading" + dots, SCREENX/2, 850);
    image(gifFrames[currentFrame], SCREENX/2, SCREENY/2);
    currentFrame++;
    if (currentFrame >= gifFrames.length) {
      currentFrame = 0;
      loading++;
    }
    if (loading > 3)
    {
      loading = 0;
    }
  } else
  {
    frameRate(30);
    currentScreen.draw(event, mapFilter);
  }
}

void mousePressed()
{
  if (loadingComplete)
  {
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
      fromAirport = false;
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
      if(!fromAirport) currentScreen = startScreen;
      if(fromAirport) currentScreen = chartSelectionScreen;
      searchBar.setQuery(BACK_BUTTON);
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

    case BACK_SELECTION_EVENT:
      currentScreen = chartSelectionScreen;
      break;

    case PIE_CHART_EVENT_ARR_DEP:
      currentScreen = pieChartScreenArrDep;
      break;

    case PIE_CHART_EVENT_CANC_DIV:
      currentScreen = pieChartScreenCanDiv;
      break;

    case NEXT_FLIGHT_EVENT:
      searchBar.nextAirport();
      break;

    case PREVIOUS_FLIGHT_EVENT:
      searchBar.previousAirport();
      break;
      
    case SELECT_SEARCH_EVENT:
      if(currentScreen == startScreen) //<>//
      {
        searchBar.setQuery(FL_NO_SEARCH);
        searchByNumberButton.setColour();
        searchByOriginButton.unsetColour();
        searchByDateButton.unsetColour();
        searchByDestButton.unsetColour();
        fromAirport = false;
      }
      else if(currentScreen == chartSelectionScreen)
      {
        searchBar.setQuery(ORIGIN_SEARCH, airportName);
        searchByNumberButton.unsetColour();
        searchByOriginButton.setColour();
        searchByDateButton.unsetColour();
        searchByDestButton.unsetColour();
        fromAirport = true;
      }
      currentScreen = searchScreen;
      break;

    case SEARCH_BY_FL_NO_EVENT:
      searchBar.setQuery(FL_NO_SEARCH);
      searchByNumberButton.setColour();
      searchByOriginButton.unsetColour();
      searchByDateButton.unsetColour();
      searchByDestButton.unsetColour();
      break;

    case SEARCH_BY_ORIGIN_EVENT:
      searchBar.setQuery(ORIGIN_SEARCH);
      searchByNumberButton.unsetColour();
      searchByOriginButton.setColour();
      searchByDateButton.unsetColour();
      searchByDestButton.unsetColour();
      break;

    case SEARCH_BY_DATE_EVENT:
      searchBar.setQuery(DATE_SEARCH);
      searchByNumberButton.unsetColour();
      searchByOriginButton.unsetColour();
      searchByDateButton.setColour();
      searchByDestButton.unsetColour();
      break;
      
    case SEARCH_BY_DEST_EVENT:
      searchBar.setQuery(DEST_SEARCH);
      searchByNumberButton.unsetColour();
      searchByOriginButton.unsetColour();
      searchByDateButton.unsetColour();
      searchByDestButton.setColour();
      break;
      
    case FILTER_BY_CAN_EVENT:
      searchBar.setFilterQuery(CAN_FILTER);
      filterByCanButton.changeColour();
      filterByDivButton.unsetColour();
      if(divCount % 2 == 1) divCount = 0;
      canCount++;
      break;
      
    case FILTER_BY_DIV_EVENT:
      searchBar.setFilterQuery(DIV_FILTER);
      filterByDivButton.changeColour();
      filterByCanButton.unsetColour();
      if(canCount % 2 == 1) canCount = 0;
      divCount++;
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
}

void keyPressed()
{
  if(loadingComplete && currentScreen == searchScreen)
  {
    searchBar.searchTyping();
  }
}

int calculateFlights(String airportName, int direction)
{
  String queryStr;
  if (direction == INCOMING) queryStr = "DEST";
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
  if (loadingComplete)
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
    pieChartButtonArrDep.hover();
    pieChartButtonCanDiv.hover();
    currentScreen.hover();
    nextFlightButton.hover();
    previousFlightButton.hover();
    searchByNumberButton.hover();
    searchByOriginButton.hover();
    searchByDateButton.hover();
    searchByDestButton.hover();
    filterByCanButton.hover();
    filterByDivButton.hover();
  }
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
  for (Airport currentAirport : myAirports)
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
  pieChartScreenArrDep = new Screen(PIE_CHART_SCREEN_ARR_DEP);
  pieChartScreenCanDiv = new Screen(PIE_CHART_SCREEN_CANC_DIV);
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
  backToSelectionButton = new Button(20, 20, (int) textWidth("Back"), "Back", BACK_SELECTION_EVENT);
  backToMapButton = new Button(20, 20, (int) textWidth("Back"), "Back", BACK_BUTTON_EVENT);
  backToStartButton = new Button(20, 20, (int) textWidth("Back"), "Back", BACK_TO_START_EVENT);
  outgoingBarChartButton = new Widget(DEP_X, DEP_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, OUTGOING_BAR_CHART_EVENT);
  incomingBarChartButton = new Widget(ARR_X, ARR_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, INCOMING_BAR_CHART_EVENT);
  pieChartButtonArrDep = new Widget(PIE_X, PIE_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, PIE_CHART_EVENT_ARR_DEP);
  pieChartButtonCanDiv = new Widget(PIE_2_X, PIE_2_Y, CHART_BUTTON_SIZE, CHART_BUTTON_SIZE, PIE_CHART_EVENT_CANC_DIV);
  USMapButton = new Widget(150, 250, START_MAP_WIDTH, 300, SELECT_US_EVENT);
  AKButton = new Button(FILTER_WIDGET_X, 745, FILTER_WIDGET_WIDTH, "A - K", AK_EVENT);
  LSButton = new Button(FILTER_WIDGET_X, 790, FILTER_WIDGET_WIDTH, "L - S ", LS_EVENT);
  TZButton = new Button(FILTER_WIDGET_X, 835, FILTER_WIDGET_WIDTH, "T - Z", TZ_EVENT);
  allButton = new Button(FILTER_WIDGET_X, 700, FILTER_WIDGET_WIDTH, "ALL", NO_FILTER_EVENT);
  searchScreenButton = new Button(1400, 98, FILTER_WIDGET_WIDTH + 30, "Search", color(WHITE), SELECT_SEARCH_EVENT, BLACK);
  nextFlightButton = new Button(700, 800, FILTER_WIDGET_WIDTH + 50, "Next Flight", NEXT_FLIGHT_EVENT);
  previousFlightButton = new Button(200, 800, FILTER_WIDGET_WIDTH + 50, "Previous Flight", PREVIOUS_FLIGHT_EVENT);
  searchByNumberButton = new Button(1200, 150, FILTER_WIDGET_WIDTH + 200, "Search by flight number", SEARCH_BY_FL_NO_EVENT);
  searchByOriginButton = new Button(1200, 250, FILTER_WIDGET_WIDTH + 200, "Search by origin", SEARCH_BY_ORIGIN_EVENT);
  searchByDestButton = new Button(1200, 350, FILTER_WIDGET_WIDTH + 200, "Search by destination", SEARCH_BY_DEST_EVENT);
  searchByDateButton = new Button(1200, 450, FILTER_WIDGET_WIDTH + 200, "Search by date", SEARCH_BY_DATE_EVENT);
  filterByCanButton = new Button(1200, 680, FILTER_WIDGET_WIDTH + 200, "Filter by cancelled", FILTER_BY_CAN_EVENT);
  filterByDivButton = new Button(1200, 780, FILTER_WIDGET_WIDTH + 200, "Filter by diverted", FILTER_BY_DIV_EVENT);
  searchScreen.addWidget(backToStartButton);
  searchScreen.addWidget(nextFlightButton);
  searchScreen.addWidget(previousFlightButton);
  searchScreen.addWidget(searchByNumberButton);
  searchScreen.addWidget(searchByOriginButton);
  searchScreen.addWidget(searchByDateButton);
  searchScreen.addWidget(searchByDestButton);
  searchScreen.addWidget(filterByCanButton);
  searchScreen.addWidget(filterByDivButton);
  outgoingChartScreen.addWidget(backToSelectionButton);
  incomingChartScreen.addWidget(backToSelectionButton);
  pieChartScreenArrDep.addWidget(backToSelectionButton);
  pieChartScreenCanDiv.addWidget(backToSelectionButton);
  chartSelectionScreen.addWidget(backToMapButton);
  chartSelectionScreen.addWidget(outgoingBarChartButton);
  chartSelectionScreen.addWidget(incomingBarChartButton);
  chartSelectionScreen.addWidget(pieChartButtonArrDep);
  chartSelectionScreen.addWidget(pieChartButtonCanDiv);
  chartSelectionScreen.addWidget(searchScreenButton);
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
