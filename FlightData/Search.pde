class Search {
  String dataReturned ="";
  String extraData="";
  String thirdDataString="";
  String fourthDataString="";
  String typeBar = "|";
  boolean alreadyRun=true;
  void searchTyping() {
    if (key==CODED) {
      alreadyRun=false;
      if (keyCode==LEFT) {
        println ("left");
      } // if
      /*else {
       // message
       println ("unknown special key");
       alreadyRun=true;
       } // else*/
    } // if
    else
    {
      if (key==BACKSPACE) {
        if (text1.length()>0) {
          text1=text1.substring(0, text1.length()-1);
        } // if
      } // if
      else if (key==RETURN || key==ENTER) {
        dataReturned="";
        extraData="";
        String[] flightNoAndDate= text1.split(",");
        boolean gotFlight = false;
        String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance" +
                     "FROM airlinedata WHERE CONCAT(mkt_carrier, mkt_carrier_fl_num) = '" + flightNoAndDate[0] + "', LEFT(fl_date, 8) = '" + flightNoAndDate[1] + "'"; 
        pgsql.query(sql);
        if (pgsql.next())
        {
          dataReturned =  "Flight Number: " + text1 + "\nOrigin Airport Code: " + pgsql.getString(5) +
            "\nDestination Airport Code: " + pgsql.getString(6) +
            "\nDate of Departure: " + pgsql.getString(7) +
            "\nEstimated Departure Time: " + depArrTimeFormatter(pgsql.getString(1)) +
            "\nEstimated Arrival Time: " + depArrTimeFormatter(pgsql.getString(2)) +
            "\nActual Departure Time: " + depArrTimeFormatter(pgsql.getString(3)) + 
            "\nActual Arrival Time: " + depArrTimeFormatter(pgsql.getString(4))  +
            "\nDeparture City: " + pgsql.getString(8) + "\nArrival City: " + pgsql.getString(9) +
            "\nDistance: " + pgsql.getString(10) + " miles";
            gotFlight = true;
        }
        println ("ENTER");
        if (gotFlight==true) {
          println("Found");
          text1="";
          alreadyRun=true;
        } // if
        else {
          dataReturned= "Flight not found. Please try again.\nAirline carrier prefixes supported include:\nAA, AS, B6, DL, F9, G4, HA, NK, UA, WN. ";
          text1="";
          alreadyRun=true;
        }
      } // else if
      else {
        text1+=key; //<>// //<>//
      } // else
      // output
    } // else
  } // func
  
  void flashingTypingYoke(){
    float s = second()%2;
    if(s==0)
    {
      float barDist = (textWidth(text1) - 4);
      text(typeBar, 166 + barDist, 47);}
  }
  
  String depArrTimeFormatter(String time){
    if(time==null){
      return "N/A";
    }
    try{ 
    String[] timeSplit = time.split("");
    String toReturn = timeSplit[0] + timeSplit[1] +":" + timeSplit[2] + timeSplit[3];
    return toReturn; }
    catch(ArrayIndexOutOfBoundsException exception){return "N/A";}
  }
  
  void draw() {
    stroke(BLACK);
    rect(150, 25, 210, 30);
    textAlign(LEFT);
    textFont(myFont);
    textSize(20);
    fill(BLACK);
    text("Enter a flight number followed by the departure date, separated by a comma, in the format DD/MM/YYYY", 380, 50);
    text(text1, 160, 50);
    text(dataReturned, 150, 80);
    //text(extraData, 550, 80);
    //text(thirdDataString, 900, 80);
    //text(fourthDataString,1200, 80);
    textAlign(CENTER);
    flashingTypingYoke();
  }
}
