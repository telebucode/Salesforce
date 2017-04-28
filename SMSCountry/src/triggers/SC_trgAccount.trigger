trigger SC_trgAccount on Account (after insert, after update, after delete) {
	User Usr = [SELECT Phone FROM User WHERE Id = : UserInfo.getUserId()];
    String SMSPhone=Usr.Phone;
    if(String.isBlank(SMSPhone)==TRUE) return;
    String cAct='';
    if (Trigger.isInsert) cAct='Inserted';
    else if (Trigger.isUpdate) cAct='Updated';
    else if (Trigger.isDelete) cAct='Deleted';
    
    String SMSText = '';
	String SMSPhoneRec = '';    
    integer objcount=0;
    SMSCountry__c objRec;
    objcount = [SELECT count() FROM SMSCountry__c];
    if(objcount==0) return;
    Map<String, String> smsInfo = new Map<String, String>{};
    objRec = [SELECT apikey__c,api_token__c,api_sender__c FROM SMSCountry__c LIMIT 1];
    smsInfo.put('SMSKey', objRec.apikey__c);
    smsInfo.put('SMSToken', objRec.api_token__c);
    if(String.isBlank(objRec.api_sender__c)==TRUE) return;
    smsInfo.put('SenderId', objRec.api_sender__c);
    //Default Templates
    String tstr = '';
    String dftemplate = '';
    String tag1 = '[ContactType]';
    String tag2 = '[ContactRecordName]';
    String rtag1 = 'Account';
    String rtag2 = '';
    String cformat = '';    
    SMSTemplate__c objet;
    if(cAct=='Inserted') {
    	tstr = 'dtsave';
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :tstr];
        if(objcount > 0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :tstr];
            dftemplate=objet.TemplateName__c;
        } else dftemplate='[ContactType] : [ContactRecordName] Inserted';
    } else if(cAct=='Updated') {
    	tstr = 'dtupdate';
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :tstr];
        if(objcount > 0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :tstr];
            dftemplate=objet.TemplateName__c;
        } else dftemplate='[ContactType] : [ContactRecordName] Updated';
    } else if(cAct=='Deleted') {
    	tstr = 'dtdelete';
        objcount = [SELECT count() FROM SMSTemplate__c where TemplateID__c = :tstr];
        if(objcount > 0) {
            objet = [SELECT TemplateName__c FROM SMSTemplate__c where TemplateID__c = :tstr];
            dftemplate=objet.TemplateName__c;
        } else dftemplate='[ContactType] : [ContactRecordName] Deleted';
    }    
    
    if(cAct=='Inserted' || cAct=='Updated') {
    	for (Account a : Trigger.new) {
            //SMSText = 'Account : '+a.Name+' '+cAct;
            cformat = dftemplate;
            cformat = cformat.replace(tag1, rtag1);
            rtag2 = a.Name;
            cformat = cformat.replace(tag2, rtag2);            
            SMSText = cformat;
            smsInfo.put('SMSText', SMSText);
            smsInfo.put('SMSPhone', SMSPhone);
            SMS_Country.sendSMS(smsInfo);
            SMSPhoneRec = a.Phone!=NULL?a.Phone:'';
            if(String.isBlank(SMSPhoneRec)==FALSE) {
                smsInfo.put('SMSPhone', SMSPhoneRec);
                SMS_Country.sendSMS(smsInfo);
            }
        }    
    } else if(cAct=='Deleted') {
    	for (Account a : Trigger.old) {
            //SMSText = 'Account : '+a.Name+' '+cAct;
            cformat = dftemplate;
            cformat = cformat.replace(tag1, rtag1);
            rtag2 = a.Name;
            cformat = cformat.replace(tag2, rtag2);            
            SMSText = cformat;
            smsInfo.put('SMSText', SMSText);
            smsInfo.put('SMSPhone', SMSPhone);
            SMS_Country.sendSMS(smsInfo);
            SMSPhoneRec = a.Phone!=NULL?a.Phone:'';
            if(String.isBlank(SMSPhoneRec)==FALSE) {
                smsInfo.put('SMSPhone', SMSPhoneRec);
                SMS_Country.sendSMS(smsInfo);
            }
        }    
    }
}