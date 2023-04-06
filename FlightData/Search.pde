class Search {
  ArrayList<String> dataReturned = new ArrayList<String>();
  ArrayList<String> results = new ArrayList<String>();
  String typeBar = "|";
  boolean alreadyRun = true;
  boolean gotFlight;
  int flightIndex, queryCount;
  int countInput = 0;

  void searchTyping() {
    flightIndex = 0;
    queryCount=0;
    if (key==CODED)
    {
      alreadyRun=false;
      if (keyCode==LEFT)
      {
        println ("left");
      }
    } 
    else
    {
      if (key==BACKSPACE) 
      {
        if (userInput.length()>0) 
        {
          userInput=userInput.substring(0, userInput.length()-1);
        }
      }  
      else if (key==RETURN || key==ENTER) 
      { 
        dataReturned.clear(); //<>//
        getFlightDetails();
        println ("ENTER");
        if (gotFlight==true) 
        {
          println("Found");
          alreadyRun=true;
        } 
        /*else 
        {
          dataReturned.add("Flight not found. Please try again.\nAirline carrier prefixes supported include:\nAA, AS, B6, DL, F9, G4, HA, NK, UA, WN. ");
          userInput="";
          alreadyRun=true;
        }*/
      } 
      else 
      {
        userInput+=key;
      }
    }
  }

  void getFlightDetails()
  {  //<>//
    countInput++;
    boolean error = false;
    if(userInput.equals(""))
    {text("Flight not found.", 150, 80);
    error=true;
    return;}
    String [] stringCheck = userInput.split("");
    try{
     String hasNumber = stringCheck[2];
    }
    catch(ArrayIndexOutOfBoundsException exception){text("Flight not found.", 150, 80);error=true; return; }
    gotFlight = false;
    println(userInput);
    if(error==false){
    String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance, COUNT(*) OVER() AS total_rows " +
      "FROM airlinedata WHERE CONCAT(mkt_carrier, mkt_carrier_fl_num) = '" + userInput + "'" +
      "GROUP BY crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance";
    pgsql.query(sql);
    int i = 0;
    do
    {
      if(pgsql.next()) //<>//
      {
        queryCount = pgsql.getInt(11);
        dataReturned.add("Flight Number: " + userInput + "\nOrigin Airport Code: " + pgsql.getString(5) +
          "\nDestination Airport Code: " + pgsql.getString(6) +
          "\nDate of Departure: " + pgsql.getString(7) +
          "\nEstimated Departure Time: " + depArrTimeFormatter(pgsql.getString(1)) +
          "\nEstimated Arrival Time: " + depArrTimeFormatter(pgsql.getString(2)) +
          "\nActual Departure Time: " + depArrTimeFormatter(pgsql.getString(3)) +
          "\nActual Arrival Time: " + depArrTimeFormatter(pgsql.getString(4))  +
          "\nDeparture City: " + pgsql.getString(8) + "\nArrival City: " + pgsql.getString(9) +
          "\nDistance: " + pgsql.getString(10) + " miles");
        results.add("Result " + (i + 1) + " out of " + queryCount + "");
        gotFlight = true;
        i++;
      }
    } while (i < queryCount);}
    else{error = false;}
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
    if(flightIndex < queryCount - 1) flightIndex++;
    println(flightIndex);
  }
  
  void previousAirport()
  {
    if(flightIndex > 0) flightIndex--;
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
    text("Enter a flight number including the prefix i.e. AA1234", 380, 50);
    text(userInput, 160, 50);
    int dataSize = dataReturned.size();
    if(dataSize != 0) //<>//
    { try{
      text(dataReturned.get(flightIndex), 150, 80);
      text(results.get(flightIndex), 150, 500);}
      catch(IndexOutOfBoundsException exception){dataSize=0;}
      
    }
    if(dataSize == 0 && countInput != 0){
      text("Flight not found.", 150, 80);
    }
    textAlign(CENTER);
    flashingTypingYoke();
  }
}
