jQuery(document).on("turbolinks:load", function() {

  function selectedParcels() {
    var parcels_array = ""
    if ($(".child-checkbox input[type='checkbox']:checked").length == 0) {
      $(".child-checkbox input[type='checkbox']").each(function() {
        checkbox = this.id.split('_')
        parcels_array = parcels_array + "parcels%5B%5D="+checkbox[1]+"&"
      });
    } else {
      $(".child-checkbox input[type='checkbox']:checked").each(function() {
        checkbox = this.id.split('_')
        parcels_array = parcels_array + "parcels%5B%5D="+checkbox[1]+"&"
      })
    }
    $("#book_train").prop('href', "/train_bookings/new?"+ parcels_array)
  }

  function disabledCheckboxes(selector) {
    var source = $("#source_"+selector.value).text()
    var destination = $("#destination_"+selector.value).text()
    $(".parcel_checkbox").each(function(index, checkbox){
      var value_source = $("#source_"+checkbox.value).text()
      var value_destination = $("#destination_"+checkbox.value).text()
      if (!(value_source == source && value_destination == destination)) {
        $('#' + checkbox.id).prop("disabled", true);
      }
    });
  }

  function enabledCheckboxes() {
    if ($("input[type='checkbox']:checked").length == 0) {
      $("input[type=checkbox]").prop('disabled', false);
    }
  }

  function buttonEnableDisable() {
    if ($("input[type='checkbox']:checked").length == 0) {
      $("#book_train").addClass("disabled")
    } else {
      $("#book_train").removeClass("disabled")
    }
  }

  $('.parcel_checkbox').click(function(){
    selectedParcels();
    disabledCheckboxes(this);
    enabledCheckboxes();
    buttonEnableDisable();
  });

  $(".close").click(function() {
    $(".flash").hide();
  })

  $("#book_train").addClass("disabled")

})
