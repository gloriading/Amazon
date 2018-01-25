$( document ).ready(function() {


// when user add more than 5 options, hide the button and alert 
  let counter = 1;
  $('.add_fields').on('click', function(){
  	counter ++;
  	console.log(counter);
    if(counter>=5){
      $('.add_fields').hide();
      alert('too many......stop!!!!');
    }
  });










});
