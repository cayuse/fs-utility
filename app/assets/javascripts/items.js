$(document).on("ready page:change", function() {
  if ( $( "#datepicker" ).length ) {$( "#datepicker" ).datepicker(); }
  if ( $( "#datepicker1" ).length ) {$( "#datepicker1" ).datepicker(); }
  if ( $( "#accordion" ).length ) {$( "#accordion" ).accordion({ header: "h3" }); }
  if ( $( ".collapsible" ).length ) {$(".collapsible").collapsible({defaultOpen: "open"}); }
  if ( $( "#tabs" ).length ) {$("#tabs").tabs({}); }
  if ( $( "table.display" ).length ) {
    $("table.display").dataTable( {
      "iDisplayLength": 50
    } ); }
  if ( $( "#drag" ).length ) {
    var rd = REDIPS.drag;
    rd.init();
      rd.myhandler_dropped    = function () {
        var tc = REDIPS.drag.top_cell.childNodes[1].name;
        rd.obj.childNodes[0].name = 'index' + '[' + tc + ']' + '[]';
      }
    }
});
