public class ResponseDto {
    @AuraEnabled public Boolean isSuccess { get; set; }
    @AuraEnabled public String message { get; set; }
	@AuraEnabled public Map<Object, Object> values { get; set; }

    public ResponseDto(Boolean isSuccess, String msg){
        this.isSuccess = isSuccess;
        this.message = msg;
        this.values = new Map<Object, Object>();
    }
}
