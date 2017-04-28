public class SmsCountry {
    public String vmsg{get;set;}
    public String pagemsg{get;set;}
    //API Details
    public string smsmenu
    {
        get
        {
            if(smsmenu == null) smsmenu = '1';
            return smsmenu;
        }
        set;
    }
    public string cMenu
    {
        get
        {
            if(cMenu == null) cMenu = '1';
            return cMenu;
        }
        set;
    }
    public boolean smsapi{get;set;}    
	public string apikey
    {
        get
        {
            if(apikey == null) apikey = '';
            return apikey;
        }
        set;
    }
    public string apitoken
    {
        get
        {
            if(apitoken == null) apitoken = '';
            return apitoken;
        }
        set;
    }
    public String sender_id{
        get{
            if(sender_id==null) sender_id = '';
            return sender_id;
        }
        set;
    }
    //Initiator
    public SmsCountry(){
        vmsg = 'Default Message';
        smsapi=false;
        integer objcount=0;
        SMSCountry__c objRec;
        objcount = [SELECT count() FROM SMSCountry__c];
        if(objcount!=0){
            objRec = [SELECT apikey__c,api_token__c,api_sender__c FROM SMSCountry__c LIMIT 1];
            apikey=objRec.apikey__c;
            apitoken=objRec.api_token__c;
            sender_id=objRec.api_sender__c;
            if(String.isBlank(sender_id)==false) smsapi=true;            
        }        
        if(smsapi==false) ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please check Configurations once.'));
        //phoneblock = 'Contact';
		//searchContacts(); 
        //sender_list();
        if(smsmenu=='3'){
            vmsg = 'Message Tracking 1';
            phoneblock='';
            searchValue='';
            smsphones='';
            smsall='';
            smsnotes='';
            sender_id='';
            etemplate='';
            editTemp='';
            dtemplate='';
            tempDivs='';
        } else if(smsmenu=='1') {
            vmsg = 'Settings';
        }
        else if(smsmenu=='2') {
            vmsg = 'Send SMS';            
        }
    }
     
    //Page Refresh Configuration
      public void totpageRefresh() {
          /*report_offset = 0;
          sender_idtc = '';
          filter_from_date = '';
          filter_to_date = '';
          phoneblock = '';
          searchValue ='';
          smsphones = '';
          smsall = '';
          smsnotes = '';
          sender_id = '';
          etemplate = '';
          editTemp = '';
          dtemplate = '';
          tempDivs = '';
          searchValue = '';
          smsphones = '';
          phoneblock = '';
          smsall = '';
          smsnotes = '';
          sender_id = '';
          dtemplate = ''; */
          
          
          if(smsmenu=='3'){
              vmsg = 'Message Tracking 1';  
              filter_from_date = '';
              filter_to_date = '';
              sender_idtc = '';
              searchValue = '';
              sms_reports_count = 0;
              sms_reports = new List<SMSReportItem>();
          } else if(smsmenu=='1') { 
              vmsg = 'Settings'; 
              searchValue = '';              
          }
          else if(smsmenu=='2') {
              vmsg = 'Send SMS';
              smsnotes = '';
              sender_id = '';
              etemplate = '';
              editTemp = '';
              dtemplate = '';
              tempDivs = '';
              searchValue = '';
              phoneblock = 'Contact';
              searchContacts();
              sender_list();
          }
    }
    
    //Save API configurations
    public void saveAuth() {
        integer objcount=0;
        SMSCountry__c objRec;
        objcount = [SELECT count() FROM SMSCountry__c];
        if(objcount!=0){
            objRec = [SELECT apikey__c,api_token__c,api_sender__c FROM SMSCountry__c LIMIT 1];
            objRec.apikey__c=apikey;
            objRec.api_token__c=apitoken;
            objRec.api_sender__c=sender_id;
            update objRec;
        } else {
            objRec=new SMSCountry__c();
            objRec.apikey__c=apikey;
            objRec.api_token__c=apitoken;
            objRec.api_sender__c='';
            insert objRec;
        }
        /*SMSTemplate__c objRec1=new SMSTemplate__c();
        objRec1.TemplateName__c='Text';
        insert objRec1;*/
        /*SMSTemplate__c objRec2 = [SELECT TemplateName__c FROM SMSTemplate__c LIMIT 1];
        delete objRec2;*/
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Configuration details saved.'));
    }
    //***********************************BULK SMS*****************
    //BULK SMS    
    public String smsall{
        get{
            if(smsall==null) smsall = '';
            return smsall;
        }
        set;
    }
    public String smsnotes{
        get{
            if(smsnotes==null) smsnotes = '';
            return smsnotes;
        }
        set;
    }
    public String smsphones{
        get{
            if(smsphones==null) smsphones = '';
            return smsphones;
        }
        set;
    }
	public String phoneblock{
        get{
            if(phoneblock==null) phoneblock = 'Contact';
            return phoneblock;
        }
        set;
    } 
    public String senderList{
        get{
            if(senderList==null) senderList = '';
            return senderList;
        }
        set;
    } 
    //Get SMS Menu
    public List<SelectOption> getsmsmenus() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','Settings'));
        if(smsapi==true){
            options.add(new SelectOption('2','Send SMS'));
            options.add(new SelectOption('3','Message Tracking'));    
        }        
        return options;
    }
    //List Languages
    public List<SelectOption> getlanguages() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('en','English'));
        options.add(new SelectOption('te','Telugu'));
        options.add(new SelectOption('hi','Hindi'));
        options.add(new SelectOption('ta','Tamil'));
        options.add(new SelectOption('kn','Kannada'));
        options.add(new SelectOption('ml','Malayalam'));
        options.add(new SelectOption('mr','Marathi'));
        options.add(new SelectOption('or','Oriya'));
        options.add(new SelectOption('pa','Punjabi'));
        options.add(new SelectOption('ur','Urdu'));
        options.add(new SelectOption('sa','Sanskrit'));
        options.add(new SelectOption('gu','Gujarati'));
        options.add(new SelectOption('bn','Bengali'));
        options.add(new SelectOption('ar','Arabic'));
        options.add(new SelectOption('zh','Chinese'));
        options.add(new SelectOption('el','Greek'));
        options.add(new SelectOption('ne','Nepali'));
        options.add(new SelectOption('fa','Persian'));
        options.add(new SelectOption('ru','Russian'));
        options.add(new SelectOption('sr','Serbian'));
        options.add(new SelectOption('si','Sinhalese'));
        return options;
    }
    //Get Phone Blocks
    public List<SelectOption> getphoneblocks() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Contact','Contacts'));
        options.add(new SelectOption('Account','Accounts'));
        options.add(new SelectOption('Lead','Leads'));
        return options;
    }
    //Get Sender IDs
    public List<SelectOption> getsenderids() {        
        List<SelectOption> options = new List<SelectOption>();
        integer objcount=0;
        objcount = [SELECT count() FROM SMSCountry__c];
        if(objcount==0) return options;
        SMSCountry__c objRec;
        objRec = [SELECT apikey__c,api_token__c FROM SMSCountry__c LIMIT 1];
        HttpRequest req = new HttpRequest();
        req.setTimeout(60000);
        req.setEndpoint('https://restapi.smscountry.com/v0.1/Accounts/'+objRec.apikey__c+'/SenderIDs/');
        req.setMethod('GET');
        
        Blob headerValue = Blob.valueOf(objRec.apikey__c + ':' + objRec.api_token__c);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);        
        
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String sRes = res.getBody();                
        Map<String, Object> resp1 = (Map<String, Object>)JSON.deserializeUntyped(sRes);
        JSONParser parser = JSON.createParser(sRes);
        SenderIdResponse response = new  SenderIdResponse();
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                response = (SenderIdResponse)parser.readValueAs(SenderIdResponse.class);
                break;
            }
        }
        if(response.getSuccess()=='false') return options;
        for(SenderId sender: response.getSenderIds()){
            String typ = sender.getSenderId();
            SelectOption opt = new SelectOption(typ,typ);
            options.add(opt);
        }
        return options;
    }
    //Get Sender IDs
    public void sender_list() {        
        senderList ='<div class="sender_list"></div>';
        integer objcount=0;
        objcount = [SELECT count() FROM SMSCountry__c];
        if(objcount==0) return;
        SMSCountry__c objRec;
        objRec = [SELECT apikey__c,api_token__c FROM SMSCountry__c LIMIT 1];
        HttpRequest req = new HttpRequest();
        req.setTimeout(60000);
        req.setEndpoint('https://restapi.smscountry.com/v0.1/Accounts/'+objRec.apikey__c+'/SenderIDs/');
        req.setMethod('GET');
        
        Blob headerValue = Blob.valueOf(objRec.apikey__c + ':' + objRec.api_token__c);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);        
        
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String sRes = res.getBody();
        Map<String, Object> resp1 = (Map<String, Object>)JSON.deserializeUntyped(sRes);
        JSONParser parser = JSON.createParser(sRes);
        SenderIdResponse response = new  SenderIdResponse();
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                response = (SenderIdResponse)parser.readValueAs(SenderIdResponse.class);
                break;
            }
        }
        senderList ='';
        if(response.getSuccess()=='false') return;
        for(SenderId sender: response.getSenderIds()){            
            String typ = sender.getSenderId();
            senderList +='<option value="'+typ+'">'+typ+'</option>';
        }
        senderList ='<div class="sender_list">'+senderList+'</div>';
    }
    //Send SMS
    public void sendsms() {
		String error = '';
        if (smsall!='1') {
        	if(String.isBlank(smsphones)==TRUE) {
                error = 'Select Contacts';
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,error));
            }
        }
        
        if(String.isBlank(smsnotes)==TRUE) {
            error = 'Message Required';
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,error));
        }
        if(String.isBlank(sender_id)==TRUE) {
            error = 'Sender ID Required';
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,error));
        }
        if(String.isBlank(error)==FALSE) return;
        
        integer objcount=0;
        SMSCountry__c objRec;
        objcount = [SELECT count() FROM SMSCountry__c];
        if(objcount==0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'SMS API not configured.'));
            return;
        }
        Map<String, String> smsInfo = new Map<String, String>{};
        objRec = [SELECT apikey__c,api_token__c FROM SMSCountry__c LIMIT 1];
        smsInfo.put('SMSKey', objRec.apikey__c);
        smsInfo.put('SMSToken', objRec.api_token__c);
        smsInfo.put('SMSText', smsnotes);        
        smsInfo.put('SenderId', sender_id);
        String SMSPhoneRec = smsphones;
        if (smsall=='1') SMSPhoneRec = allContacts();
        String[] phones = SMSPhoneRec.split(',');
        Map<String, String> resp = new Map<String, String>{};
        if(phones.size()==0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Phone number not found.'));
            return;
        }
        if(phones.size()>1) {
        	SMSPhoneRec = SMSPhoneRec.replace(',', '","');
        	SMSPhoneRec = '"'+SMSPhoneRec+'"';
            smsInfo.put('SMSPhone', SMSPhoneRec);
        	resp = SMS_Country.bulkSMS(smsInfo);
        } else {
            smsInfo.put('SMSPhone', SMSPhoneRec);
        	resp = SMS_Country.singleSMS(smsInfo);
        }
        
        if(resp.get('Success')=='true') {
            smsphones = '';
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Message sent'));
        }            
        else
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Message not sent becuase '+resp.get('Message')));
        //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Message Sent again.' + ' Contact Status : '+res.getStatus()+' Contact Status code : '+res.getStatusCode()+' Result: '+res.getBody()+' Req:'+body));
        //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Message Sent.'));
    }
    //***********************************BULK SMS*****************
    
    //***********************************MESSAGE TRACKING*****************
    public String filter_from_date{get;set;}
    public String sender_idtc
    {
        get
        {
            if(sender_idtc == null)
                sender_idtc = '';
            return sender_idtc;
        }
        set;
    }
    
    public String filter_to_date{get;set;}
    
    public String getDateString(Date input){
        return input.year()+'-'+input.month()+'-'+input.day();
    }
    
    public List<SMSReportItem> sms_reports{
        get{
            if(sms_reports == null) return new List<SMSReportItem>();
            return sms_reports;
        }
        set;
    }
    public Integer sms_reports_count {
        get{
            if(sms_reports_count == null) return 0;
            return sms_reports_count;
        } set;
    }
    public Boolean has_next_report_page {
        get{
            if(has_next_report_page == null) return false;
            return has_next_report_page;
        } set;
    }
    public Boolean has_prev_report_page {
        get{
            if(has_prev_report_page == null) return false;
            return has_prev_report_page;
        } set;
    }
    public Integer report_offset {
        get{
            if(report_offset == null) return 1;
            return report_offset;
        } set;
    }
    public String tempResponse = '';
    public Boolean TracknextPages{get;set;}
    public void prev_report(){
        if(report_offset>1)  makeRequest(report_offset - 1, false);
    }
    public void next_report(){
        makeRequest(report_offset + 1, false);
    }
    public void first_report(){
        //searchSMSes();
        makeRequest(1, false);
    }
    //Filter SMS Records
    public void makeRequest(Integer page, Boolean isFirst){        
        String senderId = sender_idtc;
        String from_date = filter_from_date;
        String to_date = filter_to_date;
        
        SMSCountry__c objRec;
        objRec = [SELECT apikey__c,api_token__c FROM SMSCountry__c LIMIT 1];
        HttpRequest req = new HttpRequest();
        req.setTimeout(60000);
        //https://restapi.smscountry.com/v0.1/Accounts/%7BauthKey%7D/SMSes/?FromDate={FromDate}&ToDate={ToDate}&SenderId={SenderId}&Offset={Offset}&Limit={Limit(default=10)}&Tool={Tool(default=ALL)}
        String endPoint = 'https://restapi.smscountry.com/v0.1/Accounts/'+objRec.apikey__c+'/SMSes/';
        String query = '';
        /*if(from_date!=NULL) query += '?FromDate='+getDateString(from_date);
        if(String.isBlank(filter_to_date)==false) query += (query == '')?'?':'&' + 'ToDate='+getDateString(to_date);
        if(String.isBlank(senderId)==false) query += (query == '')?'?':'&' + 'SenderId='+senderId;        */
        if(String.isBlank(sender_idtc)==false) query += '?SenderId='+sender_idtc;
        
        if(String.isBlank(from_date) == false) {
            String[] arrFrom = from_date.split('-');
            String formated_from_date = arrFrom[2] +'-'+ arrFrom[1] +'-'+ arrFrom[0];
            
            query += (String.isBlank(query)==true?'?':'&')+'FromDate='+formated_from_date;
        }
        if(String.isBlank(to_date) == false)   
        {   
            String[] arrTo = to_date.split('-');
            String formated_to_date = arrTo[2] +'-'+ arrTo[1] +'-'+ arrTo[0];
            query += (String.isBlank(query)==true?'?':'&')+'ToDate='+formated_to_date;
        }
        
        /*if(isFirst) query += (query == '')?'?':'&' + 'Offset=1';
        else {
            query += (query == '')?'?':'&' + 'Offset='+page;
            report_offset = page;
        }*/
        query += (String.isBlank(query)==true?'?':'&')+'Offset='+page;
        report_offset = page;
        
        endPoint += query;
        pagemsg = endPoint;
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        //System.debug(endPoint);
        Blob headerValue = Blob.valueOf(objRec.apikey__c + ':' + objRec.api_token__c);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);        
        
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String sRes = res.getBody();
        sRes = sRes.replace('"Number":', '"NumberX":');
        tempResponse = sRes;
        JSONParser parser = JSON.createParser(sRes);
        SMSReportReponse response = new SMSReportReponse();
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                response = (SMSReportReponse)parser.readValueAs(SMSReportReponse.class);
                break;
            }
        }
        //if(response.getSuccess() == 'True'){
            sms_reports = response.getSMSes();
	        sms_reports_count = sms_reports.size();
        //}
        //pagemsg +='<br>---|||\n---Next: '+response.getNext()+'<br>---|||\n---Page: '+page;
        //pagemsg +='<br>---|||\n---senderId: '+senderId+'<br>---|||\n---from_date: '+from_date+'<br>---|||\n---to_date: '+to_date;
        //pagemsg = '';
        if(response.getNext() == null || response.getNext() == '') has_next_report_page = false;
        else has_next_report_page = true;
        if(report_offset == 1) has_prev_report_page = false;
        else has_prev_report_page = true;
        TracknextPages=(has_prev_report_page==true || has_next_report_page==true ?true:false);
    }
    
    public void searchSMSes(){
        makeRequest(1, false);
    }
    //***********************************MESSAGE TRACKING*****************
    
    //***********************************SMS TEMPLATE*****************
    public String newtemp{
        get{
            if(newtemp==null) newtemp = '[ContactType] : [ContactRecordName] Inserted';
            return newtemp;
        }
        set;
    }
    public String updatetemp{
        get{
            if(updatetemp==null) updatetemp = '[ContactType] : [ContactRecordName] Updated';
            return updatetemp;
        }
        set;
    }
    public String deletetemp{
        get{
            if(deletetemp==null) deletetemp = '[ContactType] : [ContactRecordName] Deleted';
            return deletetemp;
        }
        set;
    }
    
    public String editTemp{
        get{
            if(editTemp==null) editTemp = '';
            return editTemp;
        }
        set;
    }
    public String etemplate{
        get{
            if(etemplate==null) etemplate = '';
            return etemplate;
        }
        set;
    }
    public String dtemplate{
        get{
            if(dtemplate==null) dtemplate = '';
            return dtemplate;
        }
        set;
    }
    public String tempDivs{
        get{
            if(tempDivs==null) tempDivs = '';
            return tempDivs;
        }
        set;
    }
    //Get templates
    public List<SelectOption> gettemplates() {        
        List<SelectOption> options = new List<SelectOption>();
        integer objcount=0;
        tempDivs = '';
        objcount = [SELECT count() FROM SMSTemplate__c];
        if(objcount==0) return options;
        List<SMSTemplate__c> results = [SELECT Name,TemplateID__c,TemplateName__c FROM SMSTemplate__c];
        for(SMSTemplate__c sobj: results) {
            //if(sObj.TemplateID__c=='dtsave' || sObj.TemplateID__c =='dtupdate' || sObj.TemplateID__c == 'dtdelete') continue;
            options.add(new SelectOption(sObj.Name,sObj.TemplateID__c));
            sObj.TemplateName__c = sObj.TemplateName__c.replace('\n', '<br>');
            sObj.TemplateName__c = sObj.TemplateName__c.replace(' ', '&nbsp;');
            tempDivs +='<div class="t'+sObj.Name+'">'+sObj.TemplateName__c+'</div>';
        }
        return options;
    }
    //Save Template
    public void savetemplate() {
        Boolean er=false;
        if(String.isBlank(smsnotes)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Message Required'));
            er=true;
        }
        if(String.isBlank(etemplate)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Name Required'));
            er=true;
        } else {
            /*if(etemplate=='dtsave' || etemplate =='dtupdate' || etemplate == 'dtdelete') {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Name already exists'));
                er=true;
            } else*/
            {
                integer objcount=0;
                if(String.isBlank(editTemp)==TRUE || editTemp=='0' || String.isBlank(dtemplate)==TRUE) {
                    objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :etemplate];
                    if(objcount>0) {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Name already exists'));
                        er=true;
                    }
                }    
            }
            
        }
        if(er==true) return;
        if(String.isBlank(editTemp)!=TRUE && editTemp=='1' && String.isBlank(dtemplate)!=TRUE) {
            SMSTemplate__c objet = [SELECT TemplateID__c,TemplateName__c FROM SMSTemplate__c where Name = :dtemplate];
            objet.TemplateID__c=etemplate;
            objet.TemplateName__c=smsnotes;
            update objet;
        } else {
            SMSTemplate__c objRec1=new SMSTemplate__c();
            objRec1.TemplateID__c=etemplate;
            objRec1.TemplateName__c=smsnotes;
            insert objRec1;
        }
        etemplate = '';
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Template saved.'));
    }
    //Save Default Templates
    public void savetemplates() {
        Boolean er=false;
        if(String.isBlank(newtemp)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required: Contact Inserted'));
            er=true;
        }
        if(String.isBlank(updatetemp)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required: Contact Updated'));
            er=true;
        }
        if(String.isBlank(deletetemp)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required: Contact Deleted'));
            er=true;
        }
        if(er==true) return;
        integer objcount=0;
        SMSTemplate__c objet;
        String dfTemp = 'dtsave';        
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :dfTemp];
        if(objcount>0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :dfTemp];
            objet.TemplateName__c=newtemp;
            update objet;
        } else {
           	objet=new SMSTemplate__c();
            objet.TemplateID__c=dfTemp;
            objet.TemplateName__c=newtemp;
            insert objet; 
        }
        dfTemp = 'dtupdate';        
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :dfTemp];
        if(objcount>0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :dfTemp];
            objet.TemplateName__c=updatetemp;
            update objet;
        } else {
           	objet=new SMSTemplate__c();
            objet.TemplateID__c=dfTemp;
            objet.TemplateName__c=updatetemp;
            insert objet; 
        }
        dfTemp = 'dtdelete';
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :dfTemp];
        if(objcount>0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :dfTemp];
            objet.TemplateName__c=deletetemp;
            update objet;
        } else {
           	objet=new SMSTemplate__c();
            objet.TemplateID__c=dfTemp;
            objet.TemplateName__c=deletetemp;
            insert objet; 
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Templates Updated.'));
    }
    //Delete Template
    public void deltemplate() {
        Boolean er=false;
        if(String.isBlank(dtemplate)==TRUE) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Template Required'));
            er=true;
        }
        if(er==true) return;
        SMSTemplate__c objRec = [SELECT TemplateName__c FROM SMSTemplate__c WHERE Name=:dtemplate];
        delete objRec;
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Template deleted.'));
    }
    //***********************************SMS TEMPLATE*****************
    
    //***********************************CONTACTS*****************
    //CONTACTS
    private string block='search';
    private String SOrder='LastName';
    private String SBy='ASC';
    public Integer TotalPages{get;set;}
    public Integer PageNumber{get;set;}
    public Integer ResultSize{get;set;}
    private Integer PageSize{get;set;}
    private Integer StartVal{get;set;}
    //Inner class because of we would be interested in common field of all sobjects
    public class sObjectWrapper {
      public string Name{get;set;}
      public string Phone{get;set;}
    }
    public List<sObjectWrapper> searchResults
    {
        get
        {
            if(searchResults == null)
                searchResults = new List<sObjectWrapper>();
            return searchResults;
        }
        set;
    }
    public string searchValue
    {
        get
        {
            if(searchValue == null)
                searchValue = '';
            return searchValue;
        }
        set;
    }
    public Void searchAccounts(){        
        getContacts();        
    }    
    public void FirstPage()
    {
        PageNumber=1;
        searchAccounts();
    }
    public void previous()
    {
        if(PageNumber > 1) PageNumber--;
        searchAccounts();
    }
    public void next()
    {
        if(TotalPages > PageNumber) PageNumber++;
        searchAccounts();
    }
    public void LastPage()
    {
        PageNumber=TotalPages;
        searchAccounts();
    }
    public boolean getprev()
    {    
        if(PageNumber>1) return false; else return true;
    }
    public boolean getnxt()
    {
        if(PageNumber<TotalPages) return false; else return true;
    }
    
    //Search Contacts
    public void searchContacts() {        
        TotalPages = 0;
        PageNumber = 1;
        getContacts();
    }
    //List All contacts
    public void getContacts() {
        TotalPages = 0;
        PageSize = 10;
        if(PageNumber == 0 || PageNumber == null) PageNumber = 1;
        searchResults = new List<sObjectWrapper>();
        List<sobject> results = new List<Contact>();
        if(String.isBlank(phoneblock)==TRUE) phoneblock='Contact';
        if(searchValue=='') {
            if(phoneblock=='Contact') this.ResultSize = [select count() from Contact WHERE Phone != null ];
            else if(phoneblock=='Account') this.ResultSize = [select count() from Account WHERE Phone != null ];
            else if(phoneblock=='Lead') this.ResultSize = [select count() from Lead WHERE Phone != null ];
            getTotalPages();
            if(PageNumber > 1) StartVal = (PageNumber - 1) * PageSize;
            else StartVal = 0;
            results = Database.query(
                'SELECT Name, Phone ' +
                'FROM '+phoneblock+' WHERE  ' + 
                ' Phone != null' +
                ' ORDER BY Name ASC ' +
                'LIMIT :PageSize OFFSET :StartVal'
            );            
        } else {            
            Set<String> skeys = new Set<String>{};
            List<String> skarr = searchValue.split(' ');
            for(String skpart: skarr) {
                if(String.isBlank(skpart)!=TRUE) {
                    if(String.isBlank(skpart)==TRUE) continue;
                    skeys.add('%' + skpart + '%');
                }
            }
            
            String finalSearchValue = '%' + searchValue + '%';
            if(phoneblock=='Contact'){
                this.ResultSize = [select count() from Contact WHERE (FirstName like :skeys OR LastName like :skeys OR Name like :skeys) and Phone != null ];
                getTotalPages();
                if(PageNumber > 1) StartVal = (PageNumber - 1) * PageSize;
                else StartVal = 0; 
                results = [select Name, Phone from Contact WHERE (FirstName like :skeys OR LastName like :skeys OR Name like :skeys) and Phone != null ORDER BY Name ASC LIMIT :PageSize OFFSET :StartVal ];
            } else if(phoneblock=='Account'){
                this.ResultSize = [select count() from Account WHERE Name like :skeys and Phone != null ];
                getTotalPages();
                if(PageNumber > 1) StartVal = (PageNumber - 1) * PageSize;
                else StartVal = 0;
                results = [select Name, Phone from Account WHERE Name like :skeys and Phone != null ORDER BY Name ASC LIMIT :PageSize OFFSET :StartVal ];
            } else if(phoneblock=='Lead'){
                this.ResultSize = [select count() from Lead WHERE (FirstName like :skeys OR LastName like :skeys OR Name like :skeys) and Phone != null ];
                getTotalPages();
                if(PageNumber > 1) StartVal = (PageNumber - 1) * PageSize;
                else StartVal = 0;
                results = [select Name, Phone from Lead WHERE (FirstName like :skeys OR LastName like :skeys OR Name like :skeys) and Phone != null ORDER BY Name ASC LIMIT :PageSize OFFSET :StartVal ];
            }            	
        }
        String sphone = '';
        for(sObject sobj: results) {
            sObjectWrapper sobjWrap = new sObjectWrapper();
            sObjWrap.Name = sObj.get('Name')+'';
            sphone = sObj.get('Phone')+'';
            if(sphone =='true' || sphone == 'false') sphone = '';
            sObjWrap.Phone = sphone;
            searchResults.add(sObjWrap);
        }
    }
    //Get All phone numbers
    public String allContacts() {  
        String SMSPhoneRec ='';
        //All Contacts
        if(phoneblock=='Contact'){
           	List<Contact> results;
                results = Database.query(
                    'SELECT Phone ' +
                    'FROM Contact WHERE  ' + 
                    ' Phone != null' +
                    ' ORDER BY Name ASC '
                );
            for(Contact rec:results) {
                SMSPhoneRec += ','+rec.Phone;
            }
            SMSPhoneRec = SMSPhoneRec.substring(1);
        } 
        //All Accounts
        else if(phoneblock=='Account'){
           	List<Account> results;
                results = Database.query(
                    'SELECT Phone ' +
                    'FROM Account WHERE  ' + 
                    ' Phone != null'
                );
            for(Account rec:results) {
                SMSPhoneRec += ','+rec.Phone;
            }
            SMSPhoneRec = SMSPhoneRec.substring(1);
        } 
        //All Leads
        else if(phoneblock=='Lead'){
           	List<Lead> results;
                results = Database.query(
                    'SELECT Phone ' +
                    'FROM Lead WHERE  ' + 
                    ' Phone != null'
                );
            for(Lead rec:results) {
                SMSPhoneRec += ','+rec.Phone;
            }
            SMSPhoneRec = SMSPhoneRec.substring(1);
        } 
        return SMSPhoneRec;
    }
    //Total pages
    public void getTotalPages(){
        this.TotalPages = (ResultSize / PageSize);
        if(math.mod(ResultSize, PageSize) > 0) this.TotalPages++;
    } 

    //***********************************CONTACTS*****************//
    
	/** Sender ID Response Classes Start **/
    public class SenderIdResponse {
        private String ApiId;
        private String Message;
        private String Success;
        private List<SenderId> SenderIds; 
        
        public void setApiId(String apiId){
            ApiId = apiId;
        }
        
        public void setMessage(String message){
            Message = message;
        }
        
        public void setSuccess(String success){
            Success = success;
        }
        
        public void setSenderIds(List<SenderId> senderIds){
            SenderIds = senderIds;
        }
        
        public String getApiId(){
            return ApiId;
        }
        
        public String getMessage(){
            return Message;
        }
        
        public String getSuccess(){
            return Success;
        }
        
        public List<SenderId> getSenderIds(){
            return SenderIds;
        }
    }
    public class SenderId{
        private String SenderId;
        private String ExpiryDate;
        
        public void setSenderId(String senderId){
            SenderId = senderId;
        }
        
        public void setExpiryDate(String expiryDate){
            ExpiryDate = expiryDate;
        }
        
        public String getSenderId(){
            return SenderId; 
        }
        
        public String getExpiryDate(){
            return ExpiryDate;
        }
    }
    /** Sender ID Response Classes End **/
}