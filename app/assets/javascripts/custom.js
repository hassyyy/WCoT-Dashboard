var today = new Date();
var monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"];
const CONTRIBUTIONS_FILTER_INPUT = "#contributions-filter-input";
const CONTRIBUTIONS_FILTER_ICON = "#contributions-filter-icon";
// console.log(today);

// Handle Show/Hide {Alternative: Bootstrap Collapse[https://www.w3schools.com/bootstrap/bootstrap_collapse.asp]}
$(function() {
  $('[show-hide-trigger]').click(function(event){
    event.preventDefault();
    elements_selector = "div[show-hide-elements='"+this.getAttribute('show-hide-trigger')+"']"
    // console.log(elements_selector)
    $(elements_selector).toggle();
  });
});

//Datepicker
$(function() {
  $(CONTRIBUTIONS_FILTER_INPUT).datepicker({
      format: "MM yyyy",
      minViewMode: 1,
      autoclose: true,
      disableEntry: true,
      forceParse: false,
      orientation: "auto",
      defaultDate: today,
      startDate: new Date('2017', '07'),
      endDate: new Date(today.getFullYear(), today.getMonth())
  }).on('changeDate', function (ev) {
    var selected_values = $(CONTRIBUTIONS_FILTER_INPUT).val().split(" ")
    // console.log(selected_values[0].slice(0, 3))
    // console.log(selected_values[1])

    update_contributions_index(selected_values[0].slice(0, 3), selected_values[1])
  });
});

//Show datepicker on click of icon
$(function() {
  $(CONTRIBUTIONS_FILTER_ICON).click(function(event){
    event.preventDefault();
    $(CONTRIBUTIONS_FILTER_INPUT).datepicker('show');
  })
});

//Restore stored values on page load
$(document).ready(function(){
  if($(CONTRIBUTIONS_FILTER_INPUT).is(':visible')) {
    $(CONTRIBUTIONS_FILTER_INPUT).val(monthNames[today.getMonth()] + " " + today.getFullYear())
  }
});

//AJAX call to fetch index
function update_contributions_index(month, year) {
  $.ajax({
    url: "contributions",
    data:'month=' + month + '&year=' + year,
    cache:false,
    success:function (data) {
      // console.log("Ajax Success");
      $('#monthly_contributions').html(data)
    }
  })
}
