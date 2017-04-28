public class SMSReportItem {
	private String ToolName;
    private String NumberX;
    private String MessageUUID;
    private String Text;
    private String SenderId;
    private String Cost;
    private String ProcessTime;
    private String Status;
    private String StatusTime;
    
    public String getToolName(){return ToolName;}
    public void setToolName(String val){ToolName = val;}
    
    public String getNumberX(){return NumberX;}
    public void setNumberX(String val){NumberX = val;}
    
    public String getMessageUUID(){return MessageUUID;}
    public void setMessageUUID(String val){MessageUUID = val;}
    
    public String getText(){return Text;}
    public void setText(String val){Text = val;}
    
    public String getSenderId(){return SenderId;}
    public void setSenderId(String val){SenderId = val;}
    
    public String getCost(){return Cost;}
    public void setCost(String val){Cost = val;}
    
    public String getProcessTime(){return ProcessTime;}
    public void setProcessTime(String val){ProcessTime = val;}
    
    public String getStatus(){return Status;}
    public void setStatus(String val){Status = val;}
    
    public String getStatusTime(){return StatusTime;}
    public void setStatusTime(String val){StatusTime = val;}
}