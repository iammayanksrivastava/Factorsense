$(document).ready(function() {
  $(".film-selectors input").change(function() {
    const listitems = $(".films li");
    const listitemsarray = [...listitems];
    const selectedItems = $(".film-selectors input:checked");
    const selectedItemsArray = [...selectedItems];

    if (selectedItems.length === 0) {
      listitems.show();
      return;
    }

    const selectedElements = selectedItemsArray.map(function(inputfield) {
      return inputfield.value;
    });

    const listItemsToShow = listitemsarray.filter(listItem => {
      if (selectedElements.includes(listItem.className)) {
        return listItem;
      }
    });

    const listItemtoHide = listitemsarray.filter(listItem => {
      if (!selectedElements.includes(listItem.className)) {
        return listItem;
      }
    });

    $(listItemsToShow).show();
    $(listItemtoHide).hide();
  });

  //Ordering Elements

  $("#order").on("change", function() {
    const value = $(this).find("option:checked")[0].value;
    const tableRows = $(".table-body tr"); //anHTMLCollection
    const tableArray = [...tableRows]; //array

    //  const anotherAtrr = Array.from(tableRows)

    const orderedArray = tableArray.sort((nextElement, currentElement) => {
      const a = $(nextElement).children(`.${value}`)[0].innerText;
      const b = $(currentElement).children(`.${value}`)[0].innerText;
      if (a < b) return -1;
      if (a > b) return 1;
      else return 0;
    });

    $(".table-body").html(orderedArray);
  });
});
