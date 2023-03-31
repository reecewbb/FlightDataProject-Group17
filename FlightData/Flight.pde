class Flight
{
  int dataIdentifier, mktCarrierFlNum, originWAC, destWAC, distance;
  String flightDate, mktCarrier, origin, originCityName, originStateAbr, dest, destCityName, destStateAbr, crsDepTime, depTime, crsArrTime, arrTime;
  boolean cancelled, diverted;

  Flight(int dataIdentifier)
  {
    this.dataIdentifier = dataIdentifier;
  }

  public String joinData()
  {
    String allJoinedData = this.flightDate + ", " + this.mktCarrier + ", " + this.mktCarrierFlNum + ", " + this.origin + ", " + this.originCityName + ", " + this.originStateAbr + ", " + this.originWAC +
      ", " + this.dest + ", " + this.destCityName + ", " + this.destStateAbr + ", " + this.destWAC + ", " + this.crsDepTime + ", " + this.depTime + ", " + this.crsArrTime + ", " +
      this.arrTime + ", " + ((cancelled) ? 1 : 0) + ", " + ((diverted) ? 1 : 0) + ", " + this.distance;
    return allJoinedData;
  }
  
  public String getMktCarrier()
  {
    return mktCarrier;
  }
  
  public String getStatus(){
    String corN="";
    if(cancelled == true || arrTime==null){
      corN = "Cancelled";
      return corN;
    }
    
    if(diverted == true){
      corN = "Diverted";
    }
    
    if(diverted == false && cancelled == false && Float.valueOf(getEstimatedArrivalTime()) >= Float.valueOf(getArrivalTime())){
      corN = "Arrived";
      return corN;
    }
    
    if(Float.valueOf(getEstimatedArrivalTime()) < Float.valueOf(getArrivalTime())){
      corN = "Late";
      return corN;
    }
    return corN;
  }

  public String getOrigin()
  {
    return origin;
  }

  public String getDest()
  {
    return dest;
  }

  public String getCityName()
  {
    String cityName = originCityName + ", " + originStateAbr;
    return cityName;
  }
  
  public String getArrivalCityName(){
    String ac = destCityName + ", " + destStateAbr;
    return ac;
  }
  
  public String getFlightNumber(){
    String fn = mktCarrier + mktCarrierFlNum;
    return fn;
  }
  
  public String getDepartureTime(){
    String departureTime = depTime;
    return departureTime;
  }
  
  public String getArrivalTime(){
    String arrivalTime = arrTime;
    return arrivalTime;
  }
  
  public String getEstimatedDepartureTime(){
    String edt = crsDepTime;
    return edt;
  }
  
  public String getEstimatedArrivalTime(){
    String eat = crsArrTime;
    return eat;
  }
  
  public String getDistance(){
  return String.valueOf(distance);
  }
  
  public String getFlightDate(){
    String fd = flightDate;
    fd = fd.replaceAll(" ", "");
    fd = fd.replaceAll("AM", "");
    fd = fd.replaceAll("PM", "");
    //fd = fd.replaceAll(":", "");
    fd=fd.substring(0, fd.length()-8);
    return fd;
  }
  
  public void setData(String data, int dataType)
  {
    switch(dataType)
    {
    case FLIGHT_DATE_NO:
      this.flightDate = data;
      break;

    case MKT_CARRIER_NO:
      this.mktCarrier = data;
      break;

    case MKT_CARRIER_FL_NUM_NO:
      this.mktCarrierFlNum = Integer.parseInt(data);
      break;

    case ORIGIN_NO:
      this.origin = data;
      break;

    case ORIGIN_CITY_NAME_NO:
      this.originCityName = data;
      break;

    case ORIGIN_STATE_ABR_NO:
      this.originStateAbr = data;
      break;

    case ORIGIN_WAC_NO:
      this.originWAC = Integer.parseInt(data);
      break;

    case DEST_NO:
      this.dest = data;
      break;

    case DEST_CITY_NAME_NO:
      this.destCityName = data;
      break;

    case DEST_STATE_ABR_NO:
      this.destStateAbr = data;
      break;

    case DEST_WAC_NO:
      this.destWAC = Integer.parseInt(data);
      break;

    case CRS_DEP_TIME_NO:
      this.crsDepTime = data;
      break;

    case DEP_TIME_NO:
      this.depTime = data;
      break;

    case CRS_ARR_TIME_NO:
      this.crsArrTime = data;
      break;

    case ARR_TIME_NO:
      this.arrTime = data;
      break;

    case CANCELLED_NO:
      double cancelledAsDouble = Double.parseDouble(data);
      int cancelledAsInt = (int) cancelledAsDouble;
      if (cancelledAsInt == 0)
      {
        cancelled = false;
      } else
      {
        cancelled = true;
      }
      break;

    case DIVERTED_NO:
      double divertedAsDouble = Double.parseDouble(data);
      int divertedAsInt = (int) divertedAsDouble;
      if (divertedAsInt == 0)
      {
        diverted = false;
      } else
      {
        diverted = true;
      }
      break;

    case DISTANCE_NO:
      double distanceAsDouble =Double.parseDouble(data);
      this.distance = (int) distanceAsDouble;
      break;

    default:
    }
  }
}
