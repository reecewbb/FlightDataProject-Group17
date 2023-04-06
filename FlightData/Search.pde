class Search { //<>// //<>// //<>// //<>//
  ArrayList<String> dataReturned = new ArrayList<String>();
  ArrayList<Integer> results = new ArrayList<Integer>();
  String typeBar = "|";
  boolean gotFlight, hasInput;
  int flightIndex, queryCount;
  String query, userHelp;

  Search()
  {
    setQuery(FL_NO_SEARCH);
  }

  void setQuery(int searchType)
  {
    switch(searchType)
    {
    case FL_NO_SEARCH:
      query = "CONCAT(mkt_carrier, mkt_carrier_fl_num)";
      userHelp = "Enter a flight number including the prefix i.e. AA1234";
      hasInput = false;
      userInput = "";
      dataReturned.clear();
      break;

    case ORIGIN_SEARCH:
      query = "origin";
      userHelp = "Enter airport abbreviation code i.e. JFK";
      hasInput = false;
      userInput = "";
      dataReturned.clear();
      break;

    default:
    }
  }

  void searchTyping() 
  {
    flightIndex = 0;
    queryCount = 0;
    if (key==BACKSPACE)
    {
      if (userInput.length()>0)
      {
        userInput=userInput.substring(0, userInput.length()-1);
      }
    } 
    else if (key==RETURN || key==ENTER)
    {
      dataReturned.clear();
      getFlightDetails();
      println ("ENTER");
      if (gotFlight==true)
      {
        println("Found");
      }
    } 
    else if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z') || (key >= '0' && key <= '9'))
    {
      userInput+=key;
    }
  }

  void getFlightDetails()
  {
    boolean error = false;
    hasInput = true;
    if (userInput.equals(""))
    {
      text("Flight not found.", 150, 80);
      error=true;
      return;
    }
    gotFlight = false;
    println(userInput);
    if (error == false)
    {
      String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance, COUNT(*) OVER() AS total_rows, " +
        "CONCAT(mkt_carrier, mkt_carrier_fl_num) " +
        "FROM airlinedata WHERE " + query + " = '" + userInput + "'" +
        "GROUP BY crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance, mkt_carrier, mkt_carrier_fl_num";
      pgsql.query(sql);
      int i = 0;
      do
      {
        if (pgsql.next())
        {
          queryCount = pgsql.getInt(11);
          dataReturned.add("Flight Number: " + pgsql.getString(12) + "\nOrigin Airport Code: " + pgsql.getString(5) +
            "\nDestination Airport Code: " + pgsql.getString(6) +
            "\nDate of Departure: " + pgsql.getString(7) +
            "\nEstimated Departure Time: " + depArrTimeFormatter(pgsql.getString(1)) +
            "\nEstimated Arrival Time: " + depArrTimeFormatter(pgsql.getString(2)) +
            "\nActual Departure Time: " + depArrTimeFormatter(pgsql.getString(3)) +
            "\nActual Arrival Time: " + depArrTimeFormatter(pgsql.getString(4))  +
            "\nDeparture City: " + pgsql.getString(8) + "\nArrival City: " + pgsql.getString(9) +
            "\nDistance: " + pgsql.getString(10) + " miles");
          results.add(i + 1);
          gotFlight = true;
          i++;
        }
      } while (i < queryCount);
    }
    else
    {
      error = false;
    }
  }

  void flashingTypingYoke() {
    float s = second()%2;
    if (s==0)
    {
      float barDist = (textWidth(userInput) - 4);
      text(typeBar, 166 + barDist, 47);
    }
  }

  String depArrTimeFormatter(String time) {
    if (time==null) {
      return "N/A";
    }
    try {
      String[] timeSplit = time.split("");
      String toReturn = timeSplit[0] + timeSplit[1] +":" + timeSplit[2] + timeSplit[3];
      return toReturn;
    }
    catch(ArrayIndexOutOfBoundsException exception) {
      return "N/A";
    }
  }

  void nextAirport()
  {
    if (flightIndex < queryCount - 1) flightIndex++;
    println(flightIndex);
  }

  void previousAirport()
  {
    if (flightIndex > 0) flightIndex--;
    println(flightIndex);
  }

  void draw() {
    stroke(BLACK);
    strokeWeight(1);
    rect(150, 25, 210, 30);
    textAlign(LEFT);
    textFont(myFont);
    textSize(20);
    fill(BLACK);
    text(userHelp, 380, 50);
    text(userInput, 160, 50);
    int dataSize = dataReturned.size();
    println(queryCount);
    if (dataSize != 0)
    {
        text(dataReturned.get(flightIndex), 150, 80);
        text("Result " + results.get(flightIndex) + " out of " + queryCount + "", 150, 500);
    } 
    else if (!gotFlight && hasInput)
    {
      text("Flight not found.", 150, 80);
      textAlign(CENTER);
      flashingTypingYoke();
    }
  }
}
