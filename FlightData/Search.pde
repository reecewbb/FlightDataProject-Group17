class Search {
  String dataReturned ="";
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
        boolean gotFlight = false;
        String sql = "SELECT crs_dep_time, crs_arr_time, dep_time, arr_time, origin, dest, fl_date, origin_city_name, dest_city_name, distance" +
                     "FROM airlinedata WHERE CONCAT(mkt_carrier, mkt_carrier_fl_num) = '" + text1 + "'";
        pgsql.query(sql);
        if (pgsql.next())
        {
          String[] EDT = pgsql.getString(1).split("");
          String[] EAT = pgsql.getString(2).split("");
          String[] departsAt = pgsql.getString(3).split("");
          String[] arrivesAt = pgsql.getString(4).split("");
          dataReturned = text1 + "\nOrigin Airport Code: " + pgsql.getString(5) +
            "\nDestination Airport Code: " + pgsql.getString(6) +
            "\nDate of Departure: " + pgsql.getString(7) +
            "\nEstimated Departure Time: " + EDT[0] + EDT[1] + ":" + EDT[2] + EDT[3] +
            "\nEstimated Arrival Time: " + EAT[0] + EAT[1] + ":" + EAT[2] + EAT[3] +
            "\nActual Departure Time: " + departsAt[0]+departsAt[1]+":"+departsAt[2]+departsAt[3] + 
            "\nActual Arrival Time: " + arrivesAt[0] + arrivesAt[1]+ ":" + arrivesAt[2] + arrivesAt[3]  +
            "\nDeparture City: " + pgsql.getString(8) + "\nArrival City: " + pgsql.getString(9) +
            "\nDistance: " + pgsql.getString(10) + " miles";
            gotFlight = true;
        }
        else dataReturned= "Flight not found";
        println ("ENTER");
        if (gotFlight==true) {
          println("Hurra!");
          text1="";
          alreadyRun=true;
        } // if
        else {
          dataReturned= "Flight not found";
          alreadyRun=true;
        }
      } // else if
      else {
        text1+=key;
      } // else
      // output
      //println (text1);
    } // else
  } // func
  void draw() {
    stroke(BLACK);
    rect(150, 25, 210, 30);
    textAlign(LEFT);
    textFont(myFont);
    textSize(20);
    fill(BLACK);
    text(text1, 160, 50);
    text(dataReturned, 160, 75);
    textAlign(CENTER);
  }
}
