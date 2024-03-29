class Search {  //<>//
  ArrayList<String> dataReturned = new ArrayList<String>();
  ArrayList<Integer> results = new ArrayList<Integer>();
  String typeBar = "|";
  boolean gotFlight, hasInput;
  int flightIndex, queryCount, userHelpX, selectedDay, selectedMonth, selectedYear;
  String query, filterQuery, searchQuery, userHelp, selectedDate, userInput, errorMessage, rows;
  boolean searchBox;
  DropdownList daysDropdown, monthsDropdown, yearsDropdown;
  Button submitButton;
  PFont dropdownFont;

  Search()
  {
    createDropdownList();
    setQuery(FL_NO_SEARCH);
    canCount = divCount = 0;
    searchQuery = "true ";
    filterQuery = "true ";
    query = "";
    rows = "Flight Number: " + "\nOrigin Airport Code: " + "\nDestination Airport Code: " + "\nDate of Departure: " + "\nEstimated Departure Time: " +  "\nEstimated Arrival Time: " +
      "\nActual Departure Time: " + "\nActual Arrival Time: " + "\nPunctuality: " + "\nDeparture City: " + "\nArrival City: " + "\nDistance: " + "\nCancelled: " + "\nDiverted: ";
  }

  void setQuery(int searchType)
  {
    hasInput = false;
    userInput = "";
    userHelpX = 420;
    daysDropdown.setVisible(false);
    monthsDropdown.setVisible(false);
    yearsDropdown.setVisible(false);
    searchBox = true;
    flightIndex = 0;
    queryCount = 0;
    switch(searchType)
    {
    case FL_NO_SEARCH:
      query = "CONCAT(mkt_carrier, mkt_carrier_fl_num)";
      userHelp = "Type flight number including the prefix i.e. AA1234 and press Enter";
      errorMessage = "Flight not found: use AA/AS/B6/DL/F9/G4/HA/NK/UA/WN, followed by the flight number";
      dataReturned.clear();
      break;

    case ORIGIN_SEARCH:
      query = "origin";
      userHelp = "Type airport abbreviation code i.e. JFK and press Enter";
      errorMessage = "Flight not found: use a valid 3 letter airport abbreviation code";
      dataReturned.clear();
      break;

    case DATE_SEARCH:
      query = "split_part(fl_date, ' ', 1)";
      userHelp = "Select date and press Enter";
      errorMessage = "No flight data available on selected date";
      userHelpX = 520;
      daysDropdown.setVisible(true);
      monthsDropdown.setVisible(true);
      yearsDropdown.setVisible(true);
      searchBox = false;
      dataReturned.clear();
      break;

    case BACK_BUTTON:
      daysDropdown.setVisible(false);
      monthsDropdown.setVisible(false);
      yearsDropdown.setVisible(false);
      dataReturned.clear();
      break;

    case DEST_SEARCH:
      query = "dest";
      userHelp = "Type airport abbreviation code i.e. JFK and press Enter";
      errorMessage = "Flight not found: use a valid 3 letter airport abbreviation code";
      dataReturned.clear();
      break;

    default:
    }
  }
  
  void setQuery(int searchType, String input)
  {
    setQuery(searchType);
    userInput = input;
    getFlightDetails();
  }

  void setFilterQuery(int filterType)
  {
    switch(filterType)
    {
    case CAN_FILTER:
      filterQuery = canCount % 2 == 0 ? "cancelled = '1' " : "true ";
      errorMessage = "No cancelled flights for this dataset";
      dataReturned.clear();
      getFlightDetails();
      flightIndex = 0;
      break;

    case DIV_FILTER:
      filterQuery = divCount % 2 == 0 ? "diverted = '1' " : "true ";
      errorMessage = "No diverted flights for this dataset";
      dataReturned.clear();
      getFlightDetails();
      flightIndex = 0;
      break;
    }
  }

  void createDropdownList()
  {
    dropdownFont = loadFont("MicrosoftJhengHeiRegular-20.vlw");
    daysDropdown = cp5.addDropdownList("Day")
      .setPosition(180, 30)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(#99D0E3))
      .setColorForeground(color(#8BC8DE))
      .setColorLabel(color(BLACK))
      .setColorActive(color(#71BAD3))
      .setColorValueLabel(color(BLACK))
      .setFont(dropdownFont)
      .setColorValue(BLACK)
      .setValue(0)
      .setLabel("1")
      .addItems(getDays())
      .close();

    monthsDropdown = cp5.addDropdownList("Month")
      .setPosition(290, 30)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(#99D0E3))
      .setColorForeground(color(#8BC8DE))
      .setColorLabel(color(BLACK))
      .setColorActive(color(#71BAD3))
      .setColorValueLabel(color(BLACK))
      .setFont(dropdownFont)
      .setColorValue(BLACK)
      .setValue(0)
      .setLabel("1")
      .addItems(getMonths())
      .close();

    yearsDropdown = cp5.addDropdownList("Year")
      .setPosition(400, 30)
      .setWidth(100)
      .setItemHeight(30)
      .setBarHeight(30)
      .setColorBackground(color(#99D0E3))
      .setColorForeground(color(#8BC8DE))
      .setColorLabel(color(BLACK))
      .setColorActive(color(#71BAD3))
      .setColorValueLabel(color(BLACK))
      .setFont(dropdownFont)
      .setColorValue(BLACK)
      .setValue(0)
      .setLabel("2022")
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
      if (key==BACKSPACE)
      {
        if (userInput.length()>0)
        {
          userInput=userInput.substring(0, userInput.length()-1);
        }
      } else if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z') || (key >= '0' && key <= '9'))
      {
        if (textWidth(userInput) < 180) userInput+=key;
      }
    }
    if (key==RETURN || key==ENTER)
    {
      dataReturned.clear();
      queryCount = 0;
      flightIndex = 0;
      if (!searchBox)
      {
        selectedDay = (int) daysDropdown.getValue() + 1;
        selectedMonth = (int) monthsDropdown.getValue() + 1;
        selectedYear = (int) yearsDropdown.getValue() + 2022;
        userInput = String.format(selectedMonth + "/" + selectedDay + "/" + selectedYear);
      }
      getFlightDetails();
      println ("ENTER");
      if (gotFlight==true)
      {
        println("Found");
      }
    }
    userInput.toUpperCase();
  }

  void getFlightDetails()
  {
    boolean error = false; //<>//
    hasInput = true;
    if (userInput.equals("") && filterQuery.equals("true "))
    {
      text("Please enter text or filter data", 150, 80);
      error=true;
      return;
    }
    gotFlight = false;
    if (error == false)
    {
      searchQuery = userInput != "" ? query + " = '" + userInput + "' " : "true ";
      String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, split_part(fl_date, ' ', 1), origin_city_name, dest_city_name, distance, COUNT(*) OVER() AS total_rows, " +
        "CONCAT(mkt_carrier, mkt_carrier_fl_num), cancelled, diverted " +
        "FROM airlinedata WHERE " + searchQuery + "AND " + filterQuery +
        "GROUP BY crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance, mkt_carrier, mkt_carrier_fl_num, cancelled, diverted";
      pgsql.query(sql);
      int i = 0;
      if (pgsql.next())
      {
        do
        {
          String punctuality = punctualityCalc(pgsql.getString(2), pgsql.getString(4));
          String cancelled = (pgsql.getString(13).equals("1")) ? "Yes" : "No";
          String diverted = (pgsql.getString(14).equals("1")) ? "Yes" : "No";
          queryCount = pgsql.getInt(11);
          dataReturned.add(pgsql.getString(12) + "\n" + pgsql.getString(5) + "\n" + pgsql.getString(6) + "\n" + pgsql.getString(7) + "\n" + depArrTimeFormatter(pgsql.getString(1)) +
            "\n" + depArrTimeFormatter(pgsql.getString(2)) + "\n" + depArrTimeFormatter(pgsql.getString(3)) + "\n" + depArrTimeFormatter(pgsql.getString(4))  +
            "\n" + punctuality + "\n" + pgsql.getString(8) + "\n" + pgsql.getString(9) + "\n" + pgsql.getString(10) + " miles" + "\n" + cancelled + "\n" + diverted);
          results.add(i + 1);
          gotFlight = true;
          i++;
          pgsql.next();
        }
        while (i < queryCount);
      }
    } 
    else
    {
      error = false;
    }
  }

  String punctualityCalc(String scheduled, String actual)
  {
    if (scheduled == null || actual == null) {
      return "N/A";
    }
    try {
      String[] stringScheduledSplit = scheduled.split("");
      String[] stringActualSplit = actual.split("");
      int[] scheduledSplit = new int[4];
      int[] actualSplit = new int[4];
      for (int i = 0; i < 4; i++)
      {
        scheduledSplit[i] = Integer.parseInt(stringScheduledSplit[i]);
        actualSplit[i] = Integer.parseInt(stringActualSplit[i]);
      }
      int scheduledHours = scheduledSplit[0] * 10 + scheduledSplit[1];
      int scheduledMinutes = scheduledSplit[2] * 10 + scheduledSplit[3];
      int actualHours = actualSplit[0] * 10 + actualSplit[1];
      int actualMinutes = actualSplit[2] * 10 + actualSplit[3];
      int timeDifference = ((actualHours - scheduledHours) * 60) + actualMinutes - scheduledMinutes;
      if (timeDifference == 0) return "On time";
      if (timeDifference > 0) return "Late by " + timeDifference + " minutes";
      else return "Early by " + -timeDifference + " minutes";
    }
    catch(ArrayIndexOutOfBoundsException exception) {
      return "N/A";
    }
  }

  void flashingTypingYoke() {
    fill(BLACK);
    textSize(20);
    float s = second()%2;
    if (s==0)
    {
      float barDist = textWidth(userInput);
      text(typeBar, 200 + barDist, 49);
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
    textFont(myFont);
    textSize(20);
    if (searchBox) rect(190, 25, 210, 34);
    else if (currentScreen == searchScreen)
    {
      textAlign(CENTER);
      cp5.draw();
    }
    textAlign(LEFT);
    fill(BLACK);
    textSize(20);
    text(userHelp, userHelpX, 50);
    if (searchBox) text(userInput, 200, 50);
    int dataSize = dataReturned.size();
    textAlign(CENTER);
    textSize(30);
    text("Search", 1350, 100);
    text("Filter", 1350, 600);
    if (dataSize != 0)
    {
      textSize(30);
      textAlign(LEFT);
      text(rows, 200, 150);
      textAlign(RIGHT);
      text(dataReturned.get(flightIndex), 850, 150);
      textAlign(CENTER);
      text("Result " + results.get(flightIndex) + " out of " + queryCount + "", 525, 830);
    } 
    else if (!gotFlight && hasInput)
    {
      textAlign(LEFT);
      textSize(20);
      text(errorMessage, 190, 100);
      fill(WHITE);
      noStroke();
      rect(200, 800, 700, 100);
      textAlign(CENTER);
    } 
    else
    {
      fill(WHITE);
      noStroke();
      rect(200, 800, 700, 100);
    }
    if (searchBox) flashingTypingYoke();
  }
}
