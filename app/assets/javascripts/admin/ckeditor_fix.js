var CKEDITOR_BASEPATH = '/assets/ckeditor/';

function ck_load() {
  $('.ckeditor').each(function(){
    CKEDITOR.replace( $(this).attr('name') );
  });
}

$(document).on('page:load', ck_load);