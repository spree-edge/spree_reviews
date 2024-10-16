//= require jquery.rating

// Navigating to a page with ratings via TurboLinks shows the radio buttons
$(document).on('turbo:load', function () {
  if ($('input[type=radio].star').length > 0) {
    $('input[type=radio].star').rating();
  }
});
