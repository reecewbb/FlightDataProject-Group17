class Search { //<>// //<>//
  ArrayList<String> dataReturned = new ArrayList<String>();
  ArrayList<Integer> results = new ArrayList<Integer>();
  String typeBar = "|";
  boolean gotFlight, hasInput;
  int flightIndex, queryCount, userHelpX, selectedDay, selectedMonth, selectedYear;
  String query, userHelp, selectedDate, userInput, errorMessage;
  boolean searchBox;
  DropdownList daysDropdown, monthsDropdown, yearsDropdown;
  Button submitButton;

  Search()
  {
    createDropdownList();
    setQuery(FL_NO_SEARCH);
  }

  void setQuery(int searchType)
  {
    hasInput = false;
    userInput = "";
    userHelpX = 380;
    daysDropdown.setVisible(false);
    monthsDropdown.setVisible(false);
    yearsDropdown.setVisible(false);
    searchBox = true;
    switch(searchType)
    {
    case FL_NO_SEARCH:
      query = "CONCAT(mkt_carrier, mkt_carrier_fl_num)";
      userHelp = "Enter a flight number including the prefix i.e. AA1234 and press Enter";
      errorMessage = "Flight not found: use AA/AS/B6/DL/F9/G4/HA/NK/UA/WN, followed by the flight number";
      dataReturned.clear();
      break;

    case ORIGIN_SEARCH:
      query = "origin";
      userHelp = "Enter airport abbreviation code i.e. JFK and press Enter";
      errorMessage = "Flight not found: use a valid 3 letter airport abbreviation code";
      dataReturned.clear();
      break;

    case DATE_SEARCH:
      query = "split_part(fl_date, ' ', 1)";
      userHelp = "Select date and press Enter";
      errorMessage = "No flight data available on selected date";
      userHelpX = 500;
      daysDropdown.setVisible(true);
      monthsDropdown.setVisible(true);
      yearsDropdown.setVisible(true);
      searchBox = false;
      dataReturned.clear();
      break;
    default:
    }
  }

  void createDropdownList()
  {
    daysDropdown = cp5.addDropdownList("Day")
      .setPosition(150, 25)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(WHITE - 20))
      .setColorForeground(color(WHITE - 50))
      .setColorLabel(color(BLACK))
      .setColorActive(color(WHITE - 100))
      .setColorValueLabel(color(BLACK))
      .setFont(createFont("MicrosoftJhengHeiUIRegular-20.vlw", 20))
      .setColorValue(BLACK)
      .addItems(getDays())
      .close();

    monthsDropdown = cp5.addDropdownList("Month")
      .setPosition(260, 25)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(WHITE - 20))
      .setColorForeground(color(WHITE - 50))
      .setColorLabel(color(BLACK))
      .setColorActive(color(WHITE - 100))
      .setColorValueLabel(color(BLACK))
      .setFont(createFont("MicrosoftJhengHeiUIRegular-20.vlw", 20))
      .setColorValue(BLACK)
      .addItems(getMonths())
      .close();

    yearsDropdown = cp5.addDropdownList("Year")
      .setPosition(370, 25)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(WHITE - 20))
      .setColorForeground(color(WHITE - 50))
      .setColorLabel(color(BLACK))
      .setColorActive(color(WHITE - 100))
      .setColorValueLabel(color(BLACK))
      .setFont(createFont("MicrosoftJhengHeiUIRegular-20.vlw", 20))
      .setColorValue(BLACK)
      .addItems(getYears())
      .close();
  }
  
  String[] getDays() {
    String[] days = new String[31];
    for (int i = 0; i < 31; i++) {
      days[i] = str(i + 1);
    }
    return days;
  }

  String[] getMonths() {
    String[] months = new String[6];
    for (int i = 0; i < 6; i++) {
      months[i] = str(i + 1);
    }
    return months;
  }

  String[] getYears() {
    String[] years = new String[1];
    for (int i = 0; i < 1; i++) {
      years[i] = str(2022);
    }
    return years;
  }

  void searchTyping()
  {
    if (searchBox)
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
      else if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z') || (key >= '0' && key <= '9'))
      {
        userInput+=key;
      } 
    }
    if (key==RETURN || key==ENTER) //<>//
      {
        dataReturned.clear();
        if(!searchBox) 
        {
          selectedDay = (int) daysDropdown.getValue() + 1;
          selectedMonth = (int) monthsDropdown.getValue() + 1;
          selectedYear = (int) yearsDropdown.getValue() + 2022;
          userInput = String.format(selectedDay + "/" + selectedMonth + "/" + selectedYear);
        }
        getFlightDetails();
        println ("ENTER");
        if (gotFlight==true)
        {
          println("Found");
        }
      }
  }

  void getFlightDetails()
  {
    boolean error = false; //<>//
    hasInput = true;
    if (userInput.equals(""))
    {
      text(errorMessage, 150, 80);
      error=true;
      return;
    }
    gotFlight = false;
    if (error == false)
    {
      String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, split_part(fl_date, ' ', 1), origin_city_name, dest_city_name, distance, COUNT(*) OVER() AS total_rows, " +
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
      }
      while (i < queryCount);
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
      text(typeBar, 163 + barDist, 49);
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
  }

  void previousAirport()
  {
    if (flightIndex > 0) flightIndex--;
  }

  void draw() {
    stroke(BLACK);
    strokeWeight(1);
    if (searchBox) rect(150, 25, 210, 34);
    else
    {
      textAlign(CENTER);
      cp5.draw();
    }
    textAlign(LEFT);
    textFont(myFont);
    textSize(20);
    fill(BLACK);
    text(userHelp, userHelpX, 50);
    text(userInput, 160, 50);
    int dataSize = dataReturned.size();
    if (dataSize != 0)
    {
      text(dataReturned.get(flightIndex), 150, 120);
      text("Result " + results.get(flightIndex) + " out of " + queryCount + "", 150, 500);
    } 
    else if (!gotFlight && hasInput)
    {
      text(errorMessage, 150, 80);
      textAlign(CENTER);

    }
    flashingTypingYoke();
  }
}
