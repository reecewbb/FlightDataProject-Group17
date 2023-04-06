class BarChart  //<>// //<>//
{
  int barChartYAxisLength, barChartXAxisLength, airportID;
  String airportName, chartName;
  int[] flightCount;
  String[][] infoArray;
  ArrayList<Airport> airportList;
  int number, maxValue, amountOfYValues, valueOnY, differenceInValue, positionOnY, xPosition, point, airportCounter, airportCounter2, query, highestOutgoing, highestIncoming;
  float differenceInPosition, yIncrement, difference, widthOfBar;
  boolean firstTime;

  BarChart(int airportID, ArrayList airportList, int query)
  {
    this.barChartYAxisLength = BAR_CHART_Y_AXIS_LENGTH;
    this.barChartXAxisLength = BAR_CHART_X_AXIS_LENGTH;
    this.airportID = airportID;
    this.airportList = airportList;
    this.query = query;
    Airport currentAirport = (Airport) airportList.get(airportID);
    airportName = currentAirport.getAirportName();
    createDestinationArray();
    maxValue = findMaxValue();
  }


  public int findMaxValue()
  {
    int maxValue = 0;
    for(int i = 0; i < flightCount.length; i++)
    {
      if (flightCount[i] > maxValue)
      {
        maxValue = flightCount[i];
        if (query == INCOMING) highestIncomingName = infoArray[i][1];
        if (query == OUTGOING) highestOutgoingName = infoArray[i][1];
      }
    }
    return maxValue;
  }

  public void createDestinationArray()
  {
    infoArray = new String[airportList.size()][2];
    flightCount = new int[airportList.size()];
    String from;
    String to;
    if(query == OUTGOING) 
    {
      from = "origin";
      to = "dest";
    }
    else
    {
      from = "dest";
      to = "origin";
    }
    String sql = "SELECT COUNT(*) AS num_flights, " + to + ", " + to + "_city_name " +
      "FROM airlinedata " +
      "WHERE " + from + " = '" + airportName + "' " +
      "GROUP BY " + to + ", " + to + "_city_name " +
      "ORDER BY num_flights DESC";
    pgsql.query(sql);
    int j = 0;
    while (pgsql.next()) {
      int numFlights = pgsql.getInt(1);
      String dest = pgsql.getString(2);
      String dest_city_name = pgsql.getString(3);
      flightCount[j] = numFlights;
      infoArray[j][0] = dest;
      infoArray[j][1] = dest_city_name;
      j++;
    }
  }

  public String getHighestIncomingName()
  {
    return highestIncomingName;
  }

  public String getHighestOutgoingName()
  {
    return highestOutgoingName;
  }

  void draw()
  {
    drawBarChartForOutgoingFlights(); //<>// //<>//
  }

  void drawBarChartForOutgoingFlights()
  {
    setBarChart(); //<>// //<>//
    queryCalculation();
    textSize(20);
    text(chartName, SCREENX/2, TOP_TEXT_BUFFER);
    textSize(10);
    if (maxValue != 0)
    {
      strokeWeight(1);
      for (int i = 0; i < amountOfYValues; i++)
      {
        positionOnY -= differenceInPosition;
        String valueOnYAxis = Integer.toString((int)valueOnY);
        valueOnY += differenceInValue;
        text(valueOnYAxis, xPosition, positionOnY);
        rect(xPosition + 20, positionOnY, barChartXAxisLength, 0.5);
      }
      fill(#2FBEE8);
      int i = 0;
      strokeWeight(2);
      airportCounter2 = 0;
      while (airportCounter2 < airportCounter && i < airportList.size()) //<>// //<>//
      {
        String currentAirportName = infoArray[i][AIRPORT_NAME];
        String cityName = infoArray[i][CITY_NAME];
        if (!currentAirportName.equals(airportName) && flightCount[i] != 0)
        {
          fill(0);
          text(currentAirportName, point + (widthOfBar / 2), SCREENY - 70);
          float barHeight = flightCount[i] * yIncrement;
          pushMatrix();
          textSize(12);
          textAlign(LEFT);
          translate(point + widthOfBar/2, SCREENY - CHART_BUFFER - barHeight - 10);
          rotate(-HALF_PI);
          text(cityName, 0, 0);
          popMatrix();
          textAlign(CENTER);
          textSize(10);
          fill(#08F4FA);
          rect(point, SCREENY - CHART_BUFFER, widthOfBar, -barHeight);
          airportCounter2++;
          point += difference;
        }
        i++;
      }
    } else text("NO DATA AVAILABLE", SCREENX/2, SCREENY/2);
  } //<>// //<>//

  void queryCalculation() {
    if (query == OUTGOING) chartName = "Number of outgoing flights from " + airportName;
    else if (query == INCOMING) chartName = "Number of incoming flights to " + airportName;
    if (maxValue != 0)
    {
      if (maxValue > MAX_Y_VALUES) amountOfYValues = MAX_Y_VALUES;
      else amountOfYValues = maxValue;
      valueOnY = (maxValue / amountOfYValues) + 1;
      amountOfYValues = (maxValue / valueOnY) + 1;
      differenceInValue = valueOnY;
      positionOnY = SCREENY - CHART_BUFFER;
      differenceInPosition = barChartYAxisLength/amountOfYValues;
      xPosition = 80;
      point = CHART_BUFFER + 20;
      yIncrement = differenceInPosition/differenceInValue;
      airportCounter = 0;
      for (int i = 0; i < airportList.size(); i++)
      {
        Airport nextAirport = (Airport) airportList.get(i);
        String nextAirportName = nextAirport.getAirportName();
        if (!nextAirportName.equals(airportName) && flightCount[i] != 0)
        {
          airportCounter++;
        }
      }
      if (airportCounter > 40) 
      {
        airportCounter = 40;
        if(query == OUTGOING) chartName = "Top 40 most popular flights from " + airportName;
        else if(query == INCOMING) chartName = "Top 40 most popular flights to " + airportName;
      }
      difference = (barChartXAxisLength / airportCounter) * 0.99;
      widthOfBar = difference * 0.8;
    }
  }

  void setBarChart()
  {
    fill(0);
    stroke(0);
    strokeWeight(1);
    textSize(10);
    rect(CHART_BUFFER, SCREENY - CHART_BUFFER, barChartXAxisLength, 10);
    rect(CHART_BUFFER, CHART_BUFFER, 10, barChartYAxisLength);
    text("0", 80, SCREENY - CHART_BUFFER);
  }
}
