String.prototype.startsWith = function(s) {
    return this.indexOf(s)==0;
}

var errors;
function submitForm(ev) {
    try {
        var $form = ev.data;

        var params = getFormContent($form[0]);
        params.ajax = 1;
        params[this.name] = "clicked";

        $.ajax({
            url: $form[0].action,
            data: params,
            dataType: "json",
            beforeSend: function beforeSendRequest(request) {
                this.data = this.data.replace(/%5B%5D/g,'');
                request.open("GET", this.url.replace(/%5B%5D/g,''));
            },
            success:
            function receiveFormResponse(result) {
                if (result.ok) {
                    if (result.redirect) {
                        window.location.href = getMetaData('base_url') + result.redirect;
                    } else if (result.content) {
                        $('#blogcontent').empty();
                        $('#blogcontent').html(result.content);
                    } else {
                        LoadBlogContent();
                        LoadTagStatistic();
                    }
                } else { // Błędy walidacji

                    // Usuń stare błędy walidacji
                    var $container = $("#errorContainer", $form).empty();
                    for (var field in errors) {
                        if (!field.startsWith('global-error-')) {
                            $("#" + field + "-errorField", $form).empty();
                        }
                    }

                    // Wstaw nowe błęd walidacji
                    errors = result.errors;

                    var s = "";
                    for (var field in errors) {
                        if (field.startsWith('global-error-')) { // globalne błędy walidacji
                            s += "<span class=\"error\">" + errors[field] + "</span>";
                        } else { // błędy walidacji przpisane do konkretnego pola
                            $("#" + field, $form).after("<div id=\"" + field + "-errorField\" class=\"error\">" + errors[field] + "</div>");
                        }
                    }
                    $container.append(s);
                }
            }
        });
    } catch(e) {
        console.error(e);
    }
    return false;
}

function getFormContent(form) {
    var params = {};
    var fields = form.elements;

    for (var i=0; i < fields.length; i++) {
        var field = fields[i];
        if (filterFn(field)) {
            var old = params[ field.name ];
            var value = $(field).val();

            

            if (old) {
                if (typeof old == "string") {
                    params[ field.name ] = [ old , value ];
                } else {
                    params[ field.name ].push(value);
                }
            } else {
                //                if($.isArray(value)) {
                //                    $.each(value, function(index, val) {
                //                       params[ field.name ] = val;
                //                    });
                //                } else {
                params[ field.name ]  = value;
            //                }
            }
        }
    }

    return params;
}

function filterFn(field) {
    return field.name && !field.disabled &&
    (field.checked || /select|textarea/i.test(field.nodeName) ||
        /text|hidden|password/i.test(field.type)) && !$(field).hasClass("ignored");
}