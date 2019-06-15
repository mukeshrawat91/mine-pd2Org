@RestResource(urlMapping='/flightdeck/contacts/personalNotes/*')
global with sharing class GetContacts {

    @HttpGet
    global static void doSearch() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        try {
            String accName = req.params.get('accName');
            List<Contact> conList  = [Select id,firstname,lastname,email,Account.name FROM Contact
                                      WHERE Account.name=:accName];
            res.responseBody = Blob.valueOf(JSON.serialize(conList));
            res.statusCode = 200;
            System.debug('res====' + res.responseBody);
        }
        
        catch(Exception ex) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(ex.getMessage());
        }
    }    
}