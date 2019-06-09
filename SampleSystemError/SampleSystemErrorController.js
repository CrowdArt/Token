({
  validate : function(cmp, evt) {
    var action = cmp.get(“c.getServerSideMessage”);
    action.setCallback(this, function(a) {
      // Retrieve Response Object
       var response = a.getReturnValue();
      
       if (action.getState() == “SUCCESS” && response.isSuccess) {
         // Success completion
         cmp.set(“v.message”, response.values.lastName);
       } else if (action.getState() == “ERROR” || !response.isSuccess)) {
         var errors = a.getError();
         if (errors[0] && errors[0].message){
           // Did not catch on the Server Side
           cmp.set(“v.message”, errors[0].message);
         } else if ( !response.isSuccess ) {
           // Did catch on the Server Side
           cmp.set(“v.message”, response.message);
         }
       }
    }); 
    $A.enqueueAction(action);
  }
})
