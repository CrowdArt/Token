function validate(coupon) {
    var myRe = "LUCKY100";
    var coupon = myRe.trim();
    var input = document.getElementById('in').value;
    if(input.toUpperCase() == coupon.toUpperCase()) {
        document.getElementById('message').innerHTML="Coupon applied!";
        document.getElementById('err').innerHTML="";
        return true;
    } else {
        document.getElementById('err').innerHTML="Invalid coupon";
        document.getElementById('message').innerHTML="";
        return false;
    }
}
