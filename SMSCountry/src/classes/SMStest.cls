@isTest
global class SMStest {
    static testMethod void test1(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '';
        sc.apitoken = '';        
    }
    static testMethod void test2(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = null;
        sc.apitoken = null;        
    }
    static testMethod void test3(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '123';
        sc.apitoken = '456';        
        sc.saveAuth();
        sc.saveAuth();
        SmsCountry sc1 = new SmsCountry();
    }
    //Contact Test
    static testMethod void test4(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '123';
        sc.apitoken = '456';        
        sc.saveAuth();
        Contact rec = new Contact();
        rec.FirstName='John';
        rec.LastName='Roy';
        rec.Phone='917207255435';
        insert rec;
        Contact recToUpdate =[SELECT FirstName FROM Contact WHERE LastName='Roy' LIMIT 1];
        // Update.
        recToUpdate.FirstName = 'Johnson';
        // Make the update call.
        update recToUpdate;        
        delete recToUpdate;
    }
    //Account test
    static testMethod void test5(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '123';
        sc.apitoken = '456';        
        sc.saveAuth();
        Account rec = new Account();
        rec.Name='John4489';
        rec.Phone='917207255435';
        insert rec;
        Account recToUpdate =[SELECT Name FROM Account WHERE Name='John4489' LIMIT 1];
        // Update.
        recToUpdate.Name = 'Johns4489';
        // Make the update call.
        update recToUpdate;        
        delete recToUpdate;
    }
    //Lead Test
    static testMethod void test6(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '123';
        sc.apitoken = '456';        
        sc.saveAuth();
        Lead rec = new Lead();
        rec.LastName='John4489';
        rec.FirstName='P';
        rec.Company='C';
        rec.Phone='917207255435';
        insert rec;
        Lead recToUpdate =[SELECT LastName,FirstName,Company FROM Lead WHERE LastName='John4489' LIMIT 1];
        // Update.
        recToUpdate.LastName = 'Johns4489';
        recToUpdate.FirstName = 'P4';
        recToUpdate.Company = 'P4';
        // Make the update call.
        update recToUpdate;        
        delete recToUpdate;
    }
    //Opportunity Test
    static testMethod void test7(){
        SmsCountry sc = new SmsCountry();
        sc.apikey = '123';
        sc.apitoken = '456';        
        sc.saveAuth();
        Opportunity rec = new Opportunity();
        rec.Name='John4489';
        rec.CloseDate=System.Today();
        rec.StageName='Prospecting';
        insert rec;
        Opportunity recToUpdate =[SELECT Name,CloseDate,StageName FROM Opportunity WHERE Name='John4489' LIMIT 1];
        // Update.
        recToUpdate.Name = 'Johns4489';
        recToUpdate.CloseDate = System.Today();
        recToUpdate.StageName = 'Prospecting';
        // Make the update call.
        update recToUpdate;        
        delete recToUpdate;
    }
}