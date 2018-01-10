// Handle Show/Hide {Alternative: Bootstrap Collapse[https://www.w3schools.com/bootstrap/bootstrap_collapse.asp]}
$(function() {
  $('[show-hide-trigger]').click(function(event){
    event.preventDefault();
    elements_selector = "div[show-hide-elements='"+this.getAttribute('show-hide-trigger')+"']"
    // console.log(elements_selector)
    $(elements_selector).toggle();
  });
});
