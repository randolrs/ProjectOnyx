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
//= require jquery-ui
//= require bootstrap
//= require turbolinks
//= require_tree .

// require webcomponentsjs/webcomponents
// require webcomponentsjs/webcomponents-lite
// require webcomponentsjs/webcomponents-lite.min.js
// require platform/platform

//Bower packages


function toggleModal() {
    var divModal = document.getElementById("divModal");
    divModal.style.display = (divModal.style.display == "table") ? "none" : "table";
}

function toggleTable() {
    var lTable = document.getElementById("addCardTable");
    lTable.style.display = (lTable.style.display == "table") ? "none" : "table";
}

