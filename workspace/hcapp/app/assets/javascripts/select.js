var ready;
var selected = [];

ready = function(){
  $(".condition").click(function(){

    //adds and removes class to higlight selected criteria
     $(this).toggleClass("unselected");
    
    //text for the profile
    var holder = $(this).html();
    var to_html = "";
    
    if ($.inArray(holder, selected) == -1){
      selected.push(holder);
    } else {
      selected.splice($.inArray(holder, selected), 1);
    }; //end if
    
    for (var i = 0; i<selected.length ; i++){
      if (i == selected.length - 1){
        to_html += selected[i]
      }else{
        to_html += selected[i]+", "
      };
    };
    //manipulate html according to selected criteria
    //add criteria to profile
    $(".selected_conditions").html(to_html);
   
    //show or hide selected programs
    $(".td_conditions").each(function(){
         var criterias = $(this).html().split(";");
         console.log(criterias);

         if(selected.length < 1){
          $(this).parent().fadeIn();
         }else{
          $(this).parent().fadeOut();
          var j = 0;
           for (var i = 0; i <selected.length; i++){

            if($.inArray(selected[i],criterias) > -1){
              //finds selection in criterias
              j++;}

            if (j==selected.length){
              $(this).parent().fadeIn();
          };
        };
      };
      });//end of loop
    }); //end of click function
	};	


$(document).ready(ready);
$(document).on('page:load', ready);