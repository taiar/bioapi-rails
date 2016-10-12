$(document).ready(function(){
  $('.add-smarts').on('click', function(){
    types = [];
    types['carboxilico']  = "[CX3](=O)[OX2H1]";
    types['amina']        = "[NX3;H2,H1;!$(NC=O)]";
    types['amida']        = "[CX3]=[OX1]";

    $('input#smarts').val(types[$(this).data('smarts-type')]);
  });
});
