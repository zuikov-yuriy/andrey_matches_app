// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require stimulus/init
//= require_tree .


function updateCheckout(xhr) {
  if(xhr.response !== null) {
    console.log(xhr.response);
    var default_notice = document.querySelector(".checkout-default-notice");
    var notice = document.querySelector(".checkout-notice"); 
    if (xhr.response.matches_session.amount_minutes == 0){
      notice.style.display = "none";
      default_notice.style.display = "block";
    } else {
      default_notice.style.display = "none";
      notice.style.display = "block";
      notice.textContent = xhr.response.notice;
    }
    var quantity_minutes = document.querySelector("#quantity_minutes_"+xhr.response.entity.id);
    quantity_minutes.value = xhr.response.current_amount_minutes;
  }
}

function up(match_id) {
  request("/matches/"+match_id+"/up", updateCheckout);
}

function down(match_id) {
  request("/matches/"+match_id+"/down", updateCheckout);
}

function request(link, callback) {
  var xhr = new XMLHttpRequest();
  
  xhr.onreadystatechange = function() {
    if(xhr.status === 200){
      callback(xhr);
    }
  }
  xhr.open("POST", link);
  xhr.responseType = "json";
  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8")
  xhr.setRequestHeader("X-CSRF-Token", document.querySelector('meta[name="csrf-token"]').getAttribute("content"));
  xhr.send();
}


