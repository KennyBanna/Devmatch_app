/* global $, Stripe */
//document ready.
$(document).on('turbolinks:load', function(){
    
  //Set stripe public key.
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  
  var theForm = $('#pro_form');
  var signupBtn = $('#form-signup-btn')
  
  //When user clicks form button.
  signupBtn.click(function(event){
    //prevent default event.
    event.preventDefault();
    
    //Collect card fields.
    var cardNumber =  $('#card_number').val(),
        cardCvc = $('#card_code').val(),
        cardExpMonth = $('#card_month').val(),
        cardExpYear = $('#card_year').val();
    
    //Send fields to stripe  
    Stripe.card.createToken({
      number: cardNumber,
      cvc: cardCvc,
      exp_month: cardExpMonth,
      exp_year: cardExpYear
    }, stripeResponseHandler);
    
  });
  
  

  //Inject field as hidden field in to form
  
  //Save customer to rails app
});