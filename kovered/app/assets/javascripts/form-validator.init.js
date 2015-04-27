$.validator.setDefaults(
    {
        submitHandler: function (form) {
            form.submit();
        },

        highlight: function (element, errorClass, validClass) {
            var el = $(element);
            el.parents('.form-group:first').removeClass('has-success').addClass('has-error has-feedback');
            if (el.parents('label:first, div:first').find('.glyphicon').length == 0) {
                el.parent().append('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            } else {
                el.parents('label:first, div:first').find('.glyphicon').removeClass('glyphicon-ok').addClass('glyphicon-remove')
            }
            el.parents('label:first, div:first').find('.has-error').remove();
            el.parent().append('<div class="has-error help-block well well-sm" style="margin-top:5px;">' +
                '<small password-criteria="">' + this.errorMap[el.attr('name')] + '</small></div>');
        },
        unhighlight: function (element, errorClass, validClass) {
            var el = $(element);
            el.parents('.form-group:first').removeClass('has-error').addClass('has-success has-feedback');
            el.parent().children('.has-error').remove();
            el.parent().children('.glyphicon').remove();
            el.parent().append('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
        }
        /*showErrors: function(map, list)
         {
         this.currentElements.parents('label:first, div:first').find('.has-error').remove().end()
         .find('.glyphicon').remove();
         this.currentElements.parents('.form-group:first').removeClass('has-error has-feedback');

         $.each(list, function(index, error)
         {
         var ee = $(error.element);
         var eep = ee.parents('label:first').length ? ee.parents('label:first') : ee.parents('div:first');

         ee.parents('.form-group:first').addClass('has-error has-feedback');
         eep.find('.has-error').remove();
         eep.append('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
         eep.append('<p class="has-error help-block">' + error.message + '</p>');
         });
         }*/
    });

$(function () {
    $.validator.addMethod("validation_format", function (value, element, regexp) {
//            var re = new RegExp(regexp,"i");
        return this.optional(element) || regexp.test(value);
    }, "Invalid input");
    $.validator.addMethod(     //adding a method to validate select box//
        "chosen",
        function(value, element) {
            return (value == null ? false : (value.length == 0 ? false : true))
        },
        "please select an option"//custom message
    );

    //validate fans registration
    $("#new_fan").validate({
        debug: true,
        ignore: ":hidden:not(.chosen-select)",
        rules: {
            "fan[first_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "fan[last_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "fan[genre_ids][]": {
                chosen:true
            },
            "fan[date_of_birth]": "required",
            "fan[country_id]": {
                chosen:true
            },
            "fan[user_attributes][username]": {
                required: true,
                validation_format: /^[a-zA-Z0-9](_(?!(\.|_|-))|\.(?!(_|\.|-))|-(?!(_|\.|-))|[a-zA-Z0-9-]){4,18}[a-zA-Z0-9]$/i
            },
            "fan[user_attributes][email]": {
                required: true,
                email: true,
                maxlength: 50
            },
            "fan[user_attributes][password]": {
                required: true,
                maxlength: 50,
                validation_format: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?!.*\s).{6,}/
            },
            "fan[user_attributes][password_confirmation]": {
                required: true,
                equalTo: "#fan_user_attributes_password"
            }
        },
        messages: {
            "fan[first_name]": {
                required: "Please enter your First name",
                validation_format: "Please use only letters (a-z)."
            },
            "fan[last_name]": {
                required: "Please enter your Last name",
                validation_format: "Please use only letters (a-z)."
            },
            "fan[date_of_birth]": "Please enter your date of birth",
            "fan[user_attributes][username]": {
                required: "Please enter the Username",
                validation_format: "<b>Username must be between 6 to 20 characters long and will be the following criteria:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numbers</li><li>Underscores</li><li>Hypens and </li><li>Periods</li></ul><b>Username can not be the following criteria:</b><ul><li>Two underscores, two hypens or two periods in a row.</li><li>Underscore, hypen or periods at the start or end.</li></ul>"
//                validation_format: "Please use only letters (a-z), numbers, underscores, hypens and periods.<br>Cannot be two underscores, two hypens or two periods in a row.<br>Cannot have a underscore, hypen or periods at the start or end."
            },
            "fan[genre_ids][]": "Please, Select minimum one Genre.",
            "fan[user_attributes][email]": {
                required: "Please provide a email",
                email: "Please enter a valid email address",
                maxlength: "Your email must consist within 50 characters"
            },
            "fan[user_attributes][password]": {
                required: "Please provide a password",
                maxlength: "Your username must consist within 50 characters",
                validation_format: "<b>Passwords must be a minimum of 6 characters and besides letters, fulfill the following criteria at least one time:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numeric digit</li><li>Special Characters Allowed: <b>!@#$%^&*</b></li><li>Password can not have a space</li></ul>"
//                validation_format: "Please use at least one lowercase letter, one uppercase letter, one numeric digit and one special character.<br>Cannot have a space."

            },
            "fan[user_attributes][password_confirmation]": {
                required: "You can't leave this empty.",
                equalTo: "Please enter the same password as above"
            }
        },
        errorPlacement: function (error, element) {
            var element = $(element);
            if (element.is(":radio")) {
//                console.log('radio error'+ element);
                error.appendTo(element.parent().next());//if its a radio button
            }
            else if (element.is(":checkbox")) {
//                console.log('checkbox error'+ element);
                error.appendTo(element.next());//if its a radio button
            }
            else
                error.appendTo(element.parent().next());
        }
    });

    // propose username by comblining first- and lastname
    $("#fan_user_attributes_username").focus(function () {
        var firstname = $("#fan_first_name").val();
        var lastname = $("#fan_last_name").val();
        if (firstname && lastname && !this.value) {
            this.value = (firstname + '.' + lastname).replace(/\s{1,}/g, "");
        }
    });

    //validate artist registration
    $("#new_artist").validate({
        debug: true,
        ignore: ":hidden:not(select)",
        rules: {
            "artist[first_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "artist[last_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "artist[band_name]": "required",
            "artist[genre]": "required",
            "artist[date_of_birth]": "required",

            "artist[user_attributes][username]": {
                required: true,
                validation_format: /^[a-zA-Z0-9](_(?!(\.|_|-))|\.(?!(_|\.|-))|-(?!(_|\.|-))|[a-zA-Z0-9-]){4,18}[a-zA-Z0-9]$/i
            },
            "artist[user_attributes][email]": {
                required: true,
                email: true,
                maxlength: 50
            },
            "artist[user_attributes][password]": {
                required: true,
                maxlength: 50,
                validation_format: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?!.*\s).{6,}/
            },
            "artist[user_attributes][password_confirmation]": {
                required: true,
                equalTo: "#artist_user_attributes_password"
            }
        },
        messages: {
            "artist[first_name]": {
                required: "Please enter your First name",
                validation_format: "Please use only letters (a-z)."
            },
            "artist[last_name]": {
                required: "Please enter your Last name",
                validation_format: "Please use only letters (a-z)."
            },
            "artist[band_name]": "Please enter your Band name",
            "artist[genre]": "Please enter your Genre",
            "artist[date_of_birth]": "Please enter your date of birth",
            "artist[user_attributes][username]": {
                required: "Please enter the Username",
                validation_format: "<b>Username must be between 6 to 20 characters long and will be the following criteria:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numbers</li><li>Underscores</li><li>Hypens and </li><li>Periods</li></ul><b>Username can not be the following criteria:</b><ul><li>Two underscores, two hypens or two periods in a row.</li><li>Underscore, hypen or periods at the start or end.</li></ul>"
            },
            "artist[user_attributes][email]": {
                required: "Please provide a Email",
                email: "Please enter a valid email address",
                maxlength: "Your email must consist within 50 characters"

            },
            "artist[user_attributes][password]": {
                required: "Please provide a Password",
                maxlength: "Your username must consist within 50 characters",
                validation_format: "<b>Passwords must be a minimum of 6 characters and also contain all criteria at least one time from the following:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numeric digit</li><li>Special Characters Allowed: <b>!@#$%^&*</b></li><li>Password can not have a space</li></ul>"

            },
            "artist[user_attributes][password_confirmation]": {
                required: "You can't leave this empty.",
                equalTo: "Please enter the same password as above"
            }
        },
        errorPlacement: function (error, element) {
            if (element.is(":radio"))
                error.appendTo(element.parent().next());//if its a radio button
            else if (element.is(":checkbox"))
                error.appendTo(element.next());//if its a radio button
            else
                error.appendTo(element.parent().next());
        }
    });

    // propose username by combining first- and lastname
    $("#artist_user_attributes_username").focus(function () {
        var firstname = $("#artist_first_name").val();
        var lastname = $("#artist_last_name").val();
        if (firstname && lastname && !this.value) {
            this.value = firstname + "." + lastname;
        }
    });

    //validate executive registration
    $("#new_executive").validate({
        debug: true,
        rules: {
            "executive[first_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "executive[last_name]": {
                required: true,
                validation_format: /^([a-z]+)(\s{0,1})([a-z]*)$/i
            },
            "executive[date_of_birth]": "required",
            "executive[website]": {
                url: true
            },
            "executive[user_attributes][username]": {
                required: true,
                validation_format: /^[a-zA-Z0-9](_(?!(\.|_|-))|\.(?!(_|\.|-))|-(?!(_|\.|-))|[a-zA-Z0-9-]){4,18}[a-zA-Z0-9]$/i
            },
            "executive[user_attributes][email]": {
                required: true,
                email: true,
                maxlength: 50
            },
            "executive[user_attributes][password]": {
                required: true,
                maxlength: 50,
                validation_format: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?!.*\s).{6,}/
            },
            "executive[user_attributes][password_confirmation]": {
                required: true,
                equalTo: "#executive_user_attributes_password"
            }
        },
        messages: {
            "executive[first_name]": {
                required: "Please enter your First name",
                validation_format: "Please use only letters (a-z)."
            },
            "executive[last_name]": {
                required: "Please enter your Last name",
                validation_format: "Please use only letters (a-z)."
            },
            "executive[date_of_birth]": "Please enter your date of birth",
            "executive[website]": {
                url: "Please enter a valid URL."
            },
            "executive[user_attributes][username]": {
                required: "Please enter the Username",
                validation_format: "<b>Username must be between 6 to 20 characters long and will be the following criteria:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numbers</li><li>Underscores</li><li>Hypens and </li><li>Periods</li></ul><b>Username can not be the following criteria:</b><ul><li>Two underscores, two hypens or two periods in a row.</li><li>Underscore, hypen or periods at the start or end.</li></ul>"
            },
            "executive[user_attributes][email]": {
                required: "Please provide a Email",
                email: "Please enter a valid email address",
                maxlength: "Your email must consist within 50 characters"

            },
            "executive[user_attributes][password]": {
                required: "Please provide a Password",
                maxlength: "Your username must consist within 50 characters",
                validation_format: "<b>Passwords must be a minimum of 6 characters and also contain all criteria at least one time from the following:</b><ul><li>Lowercase alphabet characters (a–z)</li><li>Uppercase alphabet characters (A–Z)</li><li>Numeric digit</li><li>Special Characters Allowed: <b>!@#$%^&*</b></li><li>Password can not have a space</li></ul>"

            },
            "executive[user_attributes][password_confirmation]": {
                required: "You can't leave this empty.",
                equalTo: "Please enter the same password as above"
            }
        },
        errorPlacement: function (error, element) {
            if (element.is(":radio"))
                error.appendTo(element.parent().next());//if its a radio button
            else if (element.is(":checkbox"))
                error.appendTo(element.next());//if its a radio button
            else
                error.appendTo(element.parent().next());
        }
    });

    // propose username by combining first- and lastname
    $("#executive_user_attributes_username").focus(function () {
        var firstname = $("#executive_first_name").val();
        var lastname = $("#executive_last_name").val();
        if (firstname && lastname && !this.value) {
            this.value = (firstname + '.' + lastname).replace(/\s{1,}/g, "");
        }
    });


    //code to hide topic selection, disable for demo
    var newsletter = $("#fan_subscription");
    // newsletter topics are optional, hide at first
    var inital = newsletter.is(":checked");
    var topics = $("#newsletter_topics")[inital ? "removeClass" : "addClass"]("gray");
    var topicInputs = topics.find("input").attr("disabled", !inital);
    // show when newsletter is checked
    newsletter.click(function () {
        topics[this.checked ? "removeClass" : "addClass"]("gray");
        topicInputs.attr("disabled", !this.checked);
    });


});