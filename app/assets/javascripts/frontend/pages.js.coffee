# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#my_photos").slidesjs({
          width: 200,
          height: 300,
          play: {
             active: true,
             effect: "fade",
             interval: 5000,
             auto: true,
             swap: true,
             pauseOnHover: true,
             restartDelay: 4500
           }
        });