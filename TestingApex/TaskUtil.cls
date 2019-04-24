public class TaskUtil {
    // The main task of this method is to return a priority value string based on the lead state.
    // The method validates the state first and returns null if the state is invalid.
    // If the state is 'CA', the method returns 'High'
    // Otherwise, it returns 'Normal' for any other state value
    public static String getTaskPriority(String leadState) {
        // Validate input
        if (String.isBlank(leadState) || leadState.length() > 2) {
            return null;
        }
            
        String taskPriority;
        
        if (leadState == 'CA') {
             taskPriority = 'High'; 
        } else {
             taskPriority = 'Normal';
        }
        
        return taskPriority;
    }
}
