class Flight //<>// //<>//
{
  int dataIdentifier;
  String flightDate;
  String mktCarrier;
  int mktCarrierFlNum;
  String origin;
  String originCityName;
  String originStateAbr;
  int originWAC;
  String dest;
  String destCityName;
  String destStateAbr;
  int destWAC;
  String crsDepTime;
  String depTime;
  String crsArrTime;
  String arrTime;
  boolean cancelled;
  boolean diverted;
  int distance;
  
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
      
      case CANCELLED_NO: //<>//
      int cancelledAsInt = Integer.parseInt(data);
      if(cancelledAsInt == 0)
      {
        cancelled = false;
      }
      else
      {
        cancelled = true;
      }
      break;
      
      case DIVERTED_NO:
      int divertedAsInt = Integer.parseInt(data);
      if(divertedAsInt == 0)
      {
        diverted = false;
      }
      else
      {
        diverted = true;
      }
      break;
      
      case DISTANCE_NO:
      this.distance = Integer.parseInt(data);
      break;
      
      default:
    }
    
  }
  
  
  
}
