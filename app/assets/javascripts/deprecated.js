// //= require moment
// const YEAR_FILTER = "#filter-year"
// const MONTH_FILTER = "#filter-month"
//
// // Change list of months when year is changed
// $(function() {
//   $(YEAR_FILTER).change(function(){
//     // console.log("Changed");
//     appendOptions($(MONTH_FILTER), availableMonths($(this).val()))
//   })
// });
//
// // Update contributions list when year or month is changed
// $(function() {
//   $(YEAR_FILTER + "," + MONTH_FILTER).change(function(){
//     // console.log("Ajax Call");
//     localStorage.setItem("month", $(MONTH_FILTER).val()); //store the selected values
//     localStorage.setItem("year", $(YEAR_FILTER).val());
//     update_contributions_index($(MONTH_FILTER).val(), $(YEAR_FILTER).val())
//   })
// });
//
// // Update contributions list when on page load => To handle navigation from other pages, refresh
// $(function() {
//   $(window).load(function(){
//     if($(MONTH_FILTER).is(':visible')) {
//       // console.log("On Load");
//       update_contributions_index($(MONTH_FILTER).val(), $(YEAR_FILTER).val())
//     }
//   })
// });
//
// //Restore stored values on page load
// $(document).ready(function(){
//   if($(MONTH_FILTER).is(':visible')) {
//     // console.log("Ready");
//     appendOptions($(MONTH_FILTER), availableMonths(localStorage.getItem("year")))
//     $(MONTH_FILTER).val(localStorage.getItem("month"))
//     $(YEAR_FILTER).val(localStorage.getItem("year"))
//   }
// });
//
// // $(window).on('beforeunload', function(){
// //   if($('#filter-month').is(':visible')) {
// //     console.log("Refresh");
// //     localStorage.setItem("month", $(MONTH_FILTER).val());
// //     localStorage.setItem("year", $(YEAR_FILTER).val());
// //   }
// //  });
//
// function update_contributions_index(month, year) {
//   $.ajax({
//     url: "contributions",
//     data:'month=' + month + '&year=' + year,
//     cache:false,
//     success:function (data) {
//       // console.log("Ajax Success");
//       $('body').html(data)
//     }
//   })
// }
//
// function appendOptions(element, options_array) {
//   element.children().remove();
//
//   for(index in options_array){
//      var option = document.createElement("option");
//      option.value= options_array[index];
//      option.innerHTML = options_array[index];
//
//      element.append(option);
//   }
// }
//
// function availableMonths(year) {
//   if (year == 2017){
//     return moment.monthsShort().slice(7,12)
//   }
//   else{
//     var today = new Date();
//     return moment.monthsShort().slice(0, today.getMonth()+1)
//   }
// }
