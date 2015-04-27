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
//= require script.min
//= require jquery.min
//= require jquery-ui.min
//= require jquery_ujs
// Incloude class name in <HTML> tag
//= require modernizr

//= require bootstrap.min
//= require jquery-migrate.min
//= require jquery-fileupload

// simple Sinatra style routing that use in lazyjaxdavis.min
//= require davis.min
// require jquery.lazyjaxdavis.min
// Automatically pace load scroll bar
//= require pace.min
// to create scrollbars like iphone/ipad use in core.js
//= require jquery.nicescroll.min
// Helpful to change JavaScript logic for different screen sizes use in core.js
//= require breakpoints
// To create a sidBar that not use
//= require jquery.sidr
// To create a blank image that use in Google map => holder
//= require holder
// To manage multiple DIV in beautiful alignment
//= require jquery.gridalicious.min
// To create a  message Box that use in Gppgle maps
//= require bootbox.min
//= require jquery.notyfy
// all notifications are transparent!
//= require jquery.gritter.min
// For Validation Check in form submit => validate.min
//= require jquery.validate.min
//= require less.min
// To easily create canvas that use in jquery.easy-pie-chart, jquery.flot, myscript1.js, current
//= require excanvas
//= require ie.prototype.polyfill
//= require jquery.datetimepicker
//= require chosen-jquery
// Use in Google map
//= require underscore-min.map
//= require gmaps/google

// require ajaxify.init
//= require preload.pace.init
//= require form-validator.init
// To design checkbox use in fan registration
//= require fuelux-checkbox.init
//= require notyfy.init
//= require gritter.init
//= require gridalicious.init
// require core.init
// require_tree .


jQuery(document).ready (function(){


});



$(function() {


//////////////////////////////////////       Text Input Limit          ////////////////////////////////////

    $(":text").attr('maxlength', 50);
    $("#artist_dialog").attr('maxlength', 200);
    $("textarea").attr('maxlength', 500);


////////////////////////            Info message automatically slide up                //////////////////////

    setTimeout(function(){
        $( ".alert-info").slideUp(1000,function(){
            $(this).alert('close');
        });
    },10000);


//////////////////                    Button enable by clicking Agree tag                    /////////////////////

    var $form_group_input = $(".form-group input:radio");
    $form_group_input.each(function(){
        if ($(this).is(':checked')){
            $(this).next("i").addClass("checked");
        }else{
            $(this).next("i").removeClass("checked");
        }
    });
    $form_group_input.click(function() {
        $(".form-group input:radio").next("i").removeClass("checked");
        $(this).next("i").addClass("checked");
    });


///////////////                   Date fo Birth use datetime gem                /////////////////////

    $( ".datetime" ).datepicker({
        defaultDate: 0,
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        showAnim: 'slideDown',
        yearRange: "-59:+6"
    });


//////////////////////                    Chose muliple genre and COuntry easily               /////////////////

    $('.chosen-select').chosen({
//        disable_search: true,
        allow_single_deselect: true,
        no_results_text: 'No results matched',
        max_selected_options: 5
    });
    $('select.chosen-select').on("change", function(evt, params) {
//        $(evt.target).valid();
        var el = $(evt.target);
        if(params.selected){
            el.parents('.form-group:first').removeClass('has-error').addClass('has-success has-feedback');
            el.parent().children('.has-error').remove();
            el.parent().children('.glyphicon').remove();
            el.parent().append('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
        }else{
            if($(evt.target).attr('multiple')){
                if($("select option:selected").length == 1){
                    el.parents('.form-group:first').removeClass('has-success').addClass('has-error has-feedback');
                    if (el.parents('label:first, div:first').find('.glyphicon').length == 0) {
                        el.parent().append('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                    } else {
                        el.parents('label:first, div:first').find('.glyphicon').removeClass('glyphicon-ok').addClass('glyphicon-remove')
                    }
                    el.parents('label:first, div:first').find('.has-error').remove();
                    el.parent().append('<div class="has-error help-block well well-sm" style="margin-top:5px;">' +
                        '<small password-criteria="">Please, Select minimum one Genre.</small></div>');
                }
            }else{
                el.parents('.form-group:first').removeClass('has-success').addClass('has-error has-feedback');
                if (el.parents('label:first, div:first').find('.glyphicon').length == 0) {
                    el.parent().append('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                } else {
                    el.parents('label:first, div:first').find('.glyphicon').removeClass('glyphicon-ok').addClass('glyphicon-remove')
                }
                el.parents('label:first, div:first').find('.has-error').remove();
                el.parent().append('<div class="has-error help-block well well-sm" style="margin-top:5px;">' +
                    '<small password-criteria="">Please, Select your Country</small></div>');
            }
        }
//        console.log(evt)
    });

});
