// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

//=previous
// jQuery(function($) {
// $("tr[data-link]").click(function() {
// window.location = this.dataset.link
// });
// })

//=previous, previous
// jQuery(document).ready(function($) {
//     $(".clickable-row").click(function() {
//         window.document.location = $(this).data("href");
//     });
// });

jQuery(function($) {
    $('#inst-form').submit(function(event) {
      // Get the form object.
      var $form = $(this);
      // Disable the submit button to prevent repeated clicks
      $form.find('button').prop('disabled', true);
      // Create a token with Stripe
      Stripe.bankAccount.createToken($form, stripeResponseHandler);
      // Prevent the form from submitting with the default action
      return false;
    });
  });

function toggleModal() {
    var divModal = document.getElementById("divModal");
    divModal.style.display = (divModal.style.display == "table") ? "none" : "table";
}

function toggleTable() {
    var lTable = document.getElementById("addCardTable");
    lTable.style.display = (lTable.style.display == "table") ? "none" : "table";
}