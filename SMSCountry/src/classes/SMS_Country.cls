global class SMS_Country {
    
@future(callout=true)
   //public static void sendSMS(String smsText, String smsPhone) 
   public static void sendSMS(Map<String, String> smsInfo) 	       
   {
       //System.debug('SMS Trigger Started!');
       try{
            HttpRequest req = new HttpRequest();
            req.setTimeout(60000);
            req.setEndpoint('https://restapi.smscountry.com/v0.1/Accounts/'+smsInfo.get('SMSKey')+'/SMSes/');
            req.setMethod('POST');
            
            Blob headerValue = Blob.valueOf(smsInfo.get('SMSKey') + ':' + smsInfo.get('SMSToken'));
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('Content-Type', 'application/json');
           	String smsTxt = smsInfo.get('SMSText');
           	String char92 = String.fromCharArray(new List<Integer>{92});
           	smsTxt = smsTxt.replace(char92, '');
            smsTxt = smsTxt.replace('/', '');                  
			smsTxt = smsTxt.replace('"', '');
            String body = '{"Text": "'+smsTxt+'","Number": "'+smsInfo.get('SMSPhone')+'","SenderId": "'+smsInfo.get('SenderId')+'","DRNotifyUrl": "http://smscountry.com","DRNotifyHttpMethod": "POST","Tool": "API"}';            
            req.setBody(body);            
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            //system.debug('Contact Update Completed.');
            //System.debug('Contact Status : '+res.getStatus()); 
            //System.debug('Contact Status code : '+res.getStatusCode()); 
            //System.debug(res.getBody());
            //System.debug('SMS: '+smsInfo.get('SMSText')+' Sent');
        } catch (Exception e) {
            system.debug('Error fired.');
            System.debug(e.getMessage());
        }
        //System.debug('Contact Trigger Update Done!');    
   }
    
   public static Map<String, String> singleSMS(Map<String, String> smsInfo) 	       
   {
       //System.debug('SMS Trigger Started!');
       Map<String, String> resp = new Map<String, String>{};
       resp.put('Success', 'false');
       resp.put('Message', 'Not sent');
       try{
            HttpRequest req = new HttpRequest();
            req.setTimeout(60000);
            req.setEndpoint('https://restapi.smscountry.com/v0.1/Accounts/'+smsInfo.get('SMSKey')+'/SMSes/');
            req.setMethod('POST');
            
            Blob headerValue = Blob.valueOf(smsInfo.get('SMSKey') + ':' + smsInfo.get('SMSToken'));
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('Content-Type', 'application/json');
           	String smsTxt = smsInfo.get('SMSText');
           	String char92 = String.fromCharArray(new List<Integer>{92});
           	smsTxt = smsTxt.replace(char92, '');
            smsTxt = smsTxt.replace('/', '');                  
			smsTxt = smsTxt.replace('"', '');
            String body = '{"Text": "'+smsTxt+'","Number": "'+smsInfo.get('SMSPhone')+'","SenderId": "'+smsInfo.get('SenderId')+'","DRNotifyUrl": "http://smscountry.com","DRNotifyHttpMethod": "POST","Tool": "API"}';            
            req.setBody(body);            
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            //system.debug('Contact Update Completed.');
            //System.debug('Contact Status : '+res.getStatus()); 
            //System.debug('Contact Status code : '+res.getStatusCode()); 
            //System.debug(res.getBody());
            //System.debug('SMS: '+smsInfo.get('SMSText')+' Sent');
            String sRes = res.getBody();
           	Map<String, Object> resp1 = (Map<String, Object>)JSON.deserializeUntyped(sRes);
            resp.put('Success', String.valueOf(resp1.get('Success')));
       		resp.put('Message', (String)resp1.get('Message'));
        } catch (Exception e) {
            system.debug('Error fired.');
            System.debug(e.getMessage());
            resp.put('Message', e.getMessage());
        }
        //System.debug('Contact Trigger Update Done!');    
        return resp;
   } 
   public static Map<String, String> bulkSMS(Map<String, String> smsInfo) 	       
   {
       //System.debug('SMS Trigger Started!');
       Map<String, String> resp = new Map<String, String>{};
       resp.put('Success', 'false');
       resp.put('Message', 'Not sent');    
       try{
            HttpRequest req = new HttpRequest();
            req.setTimeout(60000);
            req.setEndpoint('https://restapi.smscountry.com/v0.1/Accounts/'+smsInfo.get('SMSKey')+'/BulkSMSes/');
            req.setMethod('POST');
            
            Blob headerValue = Blob.valueOf(smsInfo.get('SMSKey') + ':' + smsInfo.get('SMSToken'));
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('Content-Type', 'application/json');
           	String smsTxt = smsInfo.get('SMSText');
           	String char92 = String.fromCharArray(new List<Integer>{92});
           	smsTxt = smsTxt.replace(char92, '');
            smsTxt = smsTxt.replace('/', '');                  
			smsTxt = smsTxt.replace('"', '');
            String body = '{"Text": "'+smsTxt+'","Numbers": ['+smsInfo.get('SMSPhone')+'],"SenderId": "'+smsInfo.get('SenderId')+'","DRNotifyUrl": "http://smscountry.com","DRNotifyHttpMethod": "POST","Tool": "API"}';            
            req.setBody(body);            
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            //system.debug('Contact Update Completed.');
            //System.debug('Contact Status : '+res.getStatus()); 
            //System.debug('Contact Status code : '+res.getStatusCode()); 
            //System.debug(res.getBody());
            //System.debug('SMS: '+smsInfo.get('SMSText')+' Sent');
            String sRes = res.getBody();
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,sRes+body));
           	Map<String, Object> resp1 = (Map<String, Object>)JSON.deserializeUntyped(sRes);
            resp.put('Success', String.valueOf(resp1.get('Success')));
       		resp.put('Message', (String)resp1.get('Message'));
        } catch (Exception e) {
            //system.debug('Error fired.');
            System.debug(e.getMessage());
            resp.put('Message', e.getMessage());
        }
       	return resp;
   } 
}