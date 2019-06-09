public class SampleServerSideController {

    @AuraEnabled
    public static ResponseDto getServerSideMessage(){
        try{
            // some kind of processing 
        } catch(Exception e){
            // Insert error into the Object for Response
            ResponseDto res = new ResponseDto(false, 'System Error has occurred：' + e.getMessage());
            return res;
        }
       
        // Create Object for response as Success Completion. Insert the return value to Map
        ResponseDto res = new ResponseDto(true, '');
        res.values.put('lastName', UserInfo.getLastName());
        return res;
    }
}
