public class SMSReportReponse {
	private String ApiId;
    private String Message;
    private String Success;
    private List<SMSReportItem> SMSes; 
    private String Next;
    
    public String getApiId(){return ApiId;}
    public void setApiId(String apiId){Apiid = apiId;}
    
    public String getMessage(){return Message;}
    public void setMessage(String message){Message = message;}
    
    public String getSuccess(){return Success;}
    public void setSuccess(String success){Success = success;}
    
    public List<SMSReportItem> getSMSes(){return SMSes;}
    public void setSMSes(List<SMSReportItem> smses){SMSes = smses;}
    
    public String getNext(){return Next;}
    public void setNext(String next){Next = next;}
}