class PieChart //<>//
{
  //starting at 0 degrees (at top and middle of the pie chart) each section of the pie chart will be drawn by connecting a line the length of the radius from the point on the

  int diameterOfPieChart;
  int airportID;
  String airportName, chartName;
  ArrayList<Airport> airportList = new ArrayList();
  int totalNumberOfFlightsToAndFrom;
  String[] airlines = new String[10];
  String[] airlineNames = new String[10];
  int[] airlineFlightsTotal = new int[10];
  int pieChartType;
  int numberOfFlightsCancelled;
  int numberOfFlightsDiverted;
  int numberOfFlightsNotDivertedOrCancelled;


  PieChart(int airportID, ArrayList airportList, int pieChartType)
  {
    diameterOfPieChart = 800;
    this.airportID = airportID;
    this.airportList = airportList;
    this.pieChartType = pieChartType;
    Airport currentAirport = (Airport) airportList.get(airportID);
    airportName = currentAirport.getAirportName();
    setAirlines();
    setAirlineNames();
    getNumberOfFlightsForAirlinesAndTotal();
    setMostCommonAirline();
    chartName = "Airlines at " + airportName;
    numberOfFlightsCancelled = 0;
    numberOfFlightsDiverted = 0;
    getNumberOfCancelledAndDiverted();
    if(this.pieChartType == PIE_CHART_ARR_DEP)
    {
      chartName = "Airlines at " + airportName;
    }
    else if(this.pieChartType == PIE_CHART_CANC_DIV)
    {
      chartName = "Flights cancelled and diverted at " + airportName;
    }
    totalNumberOfFlightsToAndFrom = calculateFlights(airportName, INCOMING) + calculateFlights(airportName, OUTGOING);
    numberOfFlightsNotDivertedOrCancelled = totalNumberOfFlightsToAndFrom - (numberOfFlightsCancelled + numberOfFlightsDiverted);
  }


  public void setAirlines()
  {
    airlines[0] = "AA";
    airlines[1] = "AS";
    airlines[2] = "B6";
    airlines[3] = "DL";
    airlines[4] = "F9";
    airlines[5] = "G4";
    airlines[6] = "HA";
    airlines[7] = "NK";
    airlines[8] = "UA";
    airlines[9] = "WN";
  }

  public void setAirlineNames()
  {
    airlineNames[0] = AA;
    airlineNames[1] = AS;
    airlineNames[2] = B6;
    airlineNames[3] = DL;
    airlineNames[4] = F9;
    airlineNames[5] = G4;
    airlineNames[6] = HA;
    airlineNames[7] = NK;
    airlineNames[8] = UA;
    airlineNames[9] = WN;
  }
  
  public void getNumberOfCancelledAndDiverted()
  {
    String query = "SELECT COUNT(*) as query_count FROM airlinedata WHERE (origin = '" + airportName + "' OR dest = '" + airportName + "') AND cancelled = '1.00'"; //<>//
    pgsql.query(query);
    if(pgsql.next())
    {
      numberOfFlightsCancelled = pgsql.getInt(1);
    }
    query = "SELECT COUNT(*) as query_count FROM airlinedata WHERE (origin = '" + airportName + "' OR dest = '" + airportName + "') AND diverted = '1.00'";
    pgsql.query(query);
    if(pgsql.next());
    {
      numberOfFlightsDiverted = pgsql.getInt(1);
    }
  }

  public void getNumberOfFlightsForAirlinesAndTotal()
  {
    String query = "SELECT mkt_carrier, " +
      "SUM(CASE WHEN dest = '" + airportName + "' OR origin = '" + airportName + "' THEN 1 ELSE 0 END) AS total_flights " +
      "FROM airlinedata " +
      "GROUP BY mkt_carrier";
    pgsql.query(query);
    while (pgsql.next()) {
      String mktCarrier = pgsql.getString(1);
      int total_flights = pgsql.getInt(2);
      for (int j = 0; j < airlines.length; j++)
      {
        if (airlines[j].equals(mktCarrier))
        {
          airlineFlightsTotal[j] = total_flights;
        }
      }
    }
  }

  public void setMostCommonAirline()
  {
    int highestTotal = 0;
    mostCommonAirline = "null";
    for (int i = 0; i < airlineFlightsTotal.length; i++)
    {
      int currentAirlineTotal = airlineFlightsTotal[i];
      if (currentAirlineTotal > highestTotal)
      {
        highestTotal = currentAirlineTotal;
        mostCommonAirline = airlineNames[i];
      }
    }
  }

  void draw()
  {
    textSize(20);
    fill(BLACK);
    text(chartName, SCREENX/2, TOP_TEXT_BUFFER);
    stroke(BLACK);
    strokeWeight(1);
    float lastAngle = 0;
    int xForKey = 1295;
    int yForKey = 925;
    int widthAndHeightForKey = 25;
    if(pieChartType == PIE_CHART_ARR_DEP)
    {
      for (int i = 0; i < airlineFlightsTotal.length; i++)
      {
        float numerator = airlineFlightsTotal[i];
        float fraction = numerator / totalNumberOfFlightsToAndFrom;
        int bigPercent = (int) (fraction * 10000);
        float percentRounded = (float) bigPercent / 100;
        float numberConvertedToDegrees = fraction * 360;
        color arcColor = 0;
        switch(i)
        {
        case 0:
          arcColor = color(#FF0303);
          break;

        case 1:
          arcColor = color(#050455);
          break;

        case 2:
          arcColor = color(#1210E3);
          break;

        case 3:
          arcColor = color(#F75407);
          break;

        case 4:
          arcColor = color(#3C7E50);
          break;

        case 5:
          arcColor = color(#F5E20A);
          break;

        case 6:
          arcColor = color(#E10AFA);
          break;

        case 7:
          arcColor = color(#F1FA05);
          break;

        case 8:
          arcColor = color(#05FAF8);
          break;

        case 9:
          arcColor = color(#FAC608);
          break;

        default:
        }
        fill(arcColor);
        if (numberConvertedToDegrees != 0)
        {
          arc(SCREENX/2, SCREENY/2, diameterOfPieChart/2, diameterOfPieChart/2, lastAngle, lastAngle + radians(numberConvertedToDegrees));
          lastAngle += radians(numberConvertedToDegrees);
        }
        String airlineName = airlineNames[i];
        if (percentRounded != 0)
        {
          textAlign(LEFT);
          textSize(15);
          fill(arcColor);
          rect(xForKey, yForKey, widthAndHeightForKey, widthAndHeightForKey);
          fill(BLACK);
          text("-  " + airlineName + "  -  " + percentRounded + "%", xForKey + widthAndHeightForKey + 15, yForKey + (widthAndHeightForKey) - 6);
          yForKey -= 35;
        }
        fill(BLACK);
        textAlign(CENTER);
      }
    }
    else if(pieChartType == PIE_CHART_CANC_DIV)
    {
      float denominator = totalNumberOfFlightsToAndFrom;
      float percentageNumberOfFlightsNeither = numberOfFlightsNotDivertedOrCancelled/denominator;
      int bigPercentNeither = (int) (percentageNumberOfFlightsNeither * 10000);
      float percentRoundedNeither = (float) bigPercentNeither / 100;
      float neitherInDegrees = percentageNumberOfFlightsNeither * 360;
      float percentageNumberOfFlightsCancelled = numberOfFlightsCancelled/denominator;
      int bigPercentCancelled = (int) (percentageNumberOfFlightsCancelled * 10000);
      float percentRoundedCancelled = (float) bigPercentCancelled / 100;
      float cancelledInDegrees = percentageNumberOfFlightsCancelled * 360;
      float percentageNumberOfFlightsDiverted = numberOfFlightsDiverted/denominator;
      int bigPercentDiverted = (int) (percentageNumberOfFlightsDiverted * 10000);
      float percentRoundedDiverted = (float) bigPercentDiverted / 100;
      float divertedInDegrees = percentageNumberOfFlightsDiverted * 360;
      textAlign(LEFT);
      textSize(15);
      if(neitherInDegrees != 0)
      {
        fill(#05FC13);
        arc(SCREENX/2, SCREENY/2, diameterOfPieChart/2, diameterOfPieChart/2, lastAngle, lastAngle + radians(neitherInDegrees));
        lastAngle += radians(neitherInDegrees);
        rect(xForKey, yForKey, widthAndHeightForKey, widthAndHeightForKey);
        fill(BLACK);
        text("- neither - " + percentRoundedNeither + "%", xForKey + widthAndHeightForKey + 15, yForKey + (widthAndHeightForKey) - 6);
        yForKey -= 35; 
      }
      if(divertedInDegrees != 0)
      {
        fill(#FFA703);
        arc(SCREENX/2, SCREENY/2, diameterOfPieChart/2, diameterOfPieChart/2, lastAngle, lastAngle + radians(divertedInDegrees));
        lastAngle += radians(divertedInDegrees);
        rect(xForKey, yForKey, widthAndHeightForKey, widthAndHeightForKey);
        fill(BLACK);
        text("- diverted - " + percentRoundedDiverted + "%", xForKey + widthAndHeightForKey + 15, yForKey + (widthAndHeightForKey) - 6);
        yForKey -= 35; 
      }
      if(cancelledInDegrees != 0)
      {
        fill(#F70718);
        arc(SCREENX/2, SCREENY/2, diameterOfPieChart/2, diameterOfPieChart/2, lastAngle, lastAngle + radians(cancelledInDegrees));
        lastAngle += radians(cancelledInDegrees);
        rect(xForKey, yForKey, widthAndHeightForKey, widthAndHeightForKey);
        fill(BLACK);
        text("- cancelled - " + percentRoundedCancelled + "%", xForKey + widthAndHeightForKey + 15, yForKey + (widthAndHeightForKey) - 6);
        yForKey -= 35; 
      }
    }
  }
}
