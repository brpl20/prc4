$(document).ready(function(){

  // checkboxes init 
 function checkAll(){
 $("#checkAll").click(function () {
   $('input:checkbox').not(this).prop('checked', this.checked);
 })};

  // checkboxes end 


});
