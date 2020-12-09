document.addEventListener("turbolinks:load", function() {

  $input = $("#searchBar")

  var options = {
    url: function(phrase) {
      return "/item_search.json?q=" + phrase;
    },
    getValue: "name",
    theme: "square",
  };
  
  $input.easyAutocomplete(options);

});