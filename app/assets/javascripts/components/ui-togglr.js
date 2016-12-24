$(document).ready(function(){
  $('.ui-togglr').on('click', function(){
    var target = $('#' + $(this).data('target'));
    target.toggle();
  });
});
