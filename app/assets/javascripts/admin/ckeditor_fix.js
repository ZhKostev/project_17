var CKEDITOR_BASEPATH = '/assets/ckeditor/';

(function() {
  if (typeof window['CKEDITOR_BASEPATH'] === "undefined" || window['CKEDITOR_BASEPATH'] === null) {
    window['CKEDITOR_BASEPATH'] = "<%= config.relative_url_root %>/assets/ckeditor/";
  }
}).call(this);

function ck_load() {
  $('.ckeditor').each(function(){
    CKEDITOR.replace( $(this).attr('name') );
  });
}

$(document).on('page:load', ck_load);