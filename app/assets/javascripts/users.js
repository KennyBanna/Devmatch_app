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
    //disable button.
    signupBtn.val("Processing").prop('disabled', true);
      
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
    
  function stripeResponseHandler(status, response){
    
    //If the card info contained no errors
    if(!response.error){
      
      //Get token from response
      var token = response.id
      
      //Inject field as hidden field in to form
      theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
      
      //Save customer to rails app
      theForm.get(0).submit;
      
    } else {
      //Display error message
      alert(response.error.message);
      //enable button
      signupBtn.val("Sign Up").prop('disabled', true);
    }
    
  }
  
});