var ready;
ready = function(){
	$(".div_mole_name").hide();
  $(".div_mole_score").hide();
  
  //find dimensions of div -constant to fit in the screen
  var container_top = $('.container').position().top;
  var container_bottom = container_top + $('.container').outerHeight(false) - 60;
  var container_height = container_bottom - container_top - 15; 
  
  //calculate color div height
  var no_divs = $("div.div_color").length;
  var color_height = container_height / no_divs;
  
  //position color divs
  $(".div_color").each(function(index){
    $(this).height(color_height);
  });

  //define left to seperate each mole
  var left = 150 ;
  var left_const = 50;
  
	$(".div_mole_name").each(function(index){
    //place name div for each mole
    $(this).offset({ top: container_bottom, left: left * index + left_const});
    $(this).fadeIn("slow");
  });
    
  var max_pts = 100000;
  	$(".div_mole_score").each(function(index){
      //calculate the top of div according to points
      var mole_score = parseInt($(this).text());
      var relative_top = container_height * (mole_score / max_pts) + 25;
      //place score div for each mole
      $(this).offset({ top: container_bottom - relative_top, left: left * index + left_const});
      $(this).fadeIn("slow");
  });
}
  
$(document).ready(ready);
$(document).on('page:load', ready);
