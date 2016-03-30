$(document).ready(function(){
  $('#loan-amount').on("change", function() {
    var newAmount = $('#remaining-goal').data("remaining-amount") - $('#loan-amount').val().slice(1)
    $('#remaining-goal').text("$" + newAmount);
  });
});
