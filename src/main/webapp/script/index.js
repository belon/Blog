/**
 * This function loads post on the first page, starting at page page
 */
function LoadBlogContent(page,tag) {
    $('#blogcontent').empty();

    if (getMetaData('showLoginForm')) {
        $.ajax({
            url: "/Blog/app/login",
            success: function(data) {
                $('#blogcontent').html(data);
                $('#loginError').removeAttr('style');
            },
            error: function(data) {
                MessageBox(data);
            }
        });
    } else {
        var url = "/Blog/app/bloglist";
        if (!(typeof tag == "undefined")) {
            url = url + "?tagId="+tag+"&ajax=1"
        }
        $.ajax({
            url: url,
            success: function(data) {
                $('#blogcontent').html(data);

                // dodanie linków do 'Pokaż komentarze'
                $('#blogcontent .comments_link a').click(function() {
                    ReloadPosts(this);
                });

                // dodanie linków do 'Edytuj post'
                $('#blogcontent .postmeta .category_link a').click(function() {
                    var postElem = $(this).parents('.post');
                    $.ajax({
                        url: "/Blog/app/admin/editPost?id="+postElem.attr('id'),
                        success: function(data) {
                            $('#blogcontent').html(data);
                        },
                        error: function(data) {
                            ErrorBox(data);
                        }
                    });
                });
                
                // dodanie linków do 'Usuń post'
                $('#blogcontent .postmeta .permalink a').click(function() {
                    var postElem = $(this).parents('.post');
                    $.ajax({
                        url: "/Blog/app/admin/delPost?id="+postElem.attr('id')+"&ajax=1" ,
                        error: function(data) {
                            ErrorBox(data);
                        },
                        success: function(data) {
                            simpleMessageBox(data);
                        }
                    });
                });

                // dodanie linków do tagów
                $('#blogcontent .tag_link').click(function() {
                    LoadBlogContent(1,$(this).attr('rel'));
                });
            },
            error : function(data) {
                MessageBox(data);
            }
        });
    }
}

function LoadTagStatistic(page) {
    $('#tagStatistic').empty();

    $.ajax({
        url: "/Blog/app/taglist?ajax=1",
        success: function(data) {
            $('#tagStatistic').html(data);

            $('#tagStatistic #taglist .tag_link').click(function() {
                LoadBlogContent(1,this.id);
            });
        },
        error : function(data) {
            MessageBox(data);
        }
    });
}

function LoadPostForm(page) {
    $('#blogcontent').empty();

    $('#addPost').click(function() {
        $.ajax({
            url: "/Blog/app/admin/newPost",
            success: function(data) {
                $('#blogcontent').html(data);
            },
            error: function(data) {
                ErrorBox(data);
            }
        });
    });
}

function LoadLoginForm(page) {
    $('#blogcontent').empty();

    $('#loginForm').click(function() {
        $.ajax({
            url: "/Blog/app/login",
            success: function(data) {
                $('#blogcontent').html(data);
            },
            error: function(data) {
                ErrorBox(data);
            }
        });
    });
}

var infoDialog = null;

function ErrorBox(message) {
    var $dialog = $('<div></div>')
    .html(message)
    .dialog({
        autoOpen: false,
        modal: true,
        title: 'Error',
        buttons: {
            Ok: function() {
                $(this).dialog('close');
            }
        }

    });
    $dialog.dialog('open');
}

function MessageBox(message) {
    var $dialog = $('<div></div>')
    .html(message)
    .dialog({
        autoOpen: false,
        modal: true,
        title: 'Info',
        buttons: {
            Ok: function() {
                $(this).dialog('close');
            }
        }

    });
    $dialog.dialog('open');
}

function simpleMessageBox(message) {
    var $dialog = $('<div></div>')
    .html(message)
    .dialog({
        autoOpen: false,
        modal: true,
        title: 'Info'
    });
    $dialog.dialog('open');
}

function getMetaData(name) {
    return $("meta[name=" + name + "]").attr("content")
}

function getGravatarFor(email) {
    return "http://gravatar.com/avatar/" + hex_md5(email) + "?s=48";
}

$(function() {

    $("#1, #2, #3").lavaLamp({
        fx: "backout",
        speed: 700,
        click: function(event, menuItem) {
            return true;
        }
    });

    LoadBlogContent();
    LoadTagStatistic();
    LoadPostForm();
    LoadLoginForm();

    // Kolorowanie składni
    SyntaxHighlighter.config.stripBrs = true;
    SyntaxHighlighter.all();
});


function ReloadPosts(item) {
    var postElem = $(item).parents('.post');
    $.ajax({
        url: "/Blog/app/commentlist?id="+postElem.attr('id')+"&ajax=1" ,
        error: function(data) {
            ErrorBox(data);
        },
        success: function(data) {
            postElem.find('.comments').html(data).find('.addcomment').click(function() {
                $.ajax({
                    url: "/Blog/app/addComment?id=" +postElem.attr('id')+"&ajax=1",
                    error: function(data) {
                        ErrorBox(data);
                    },
                    success: function(data) {
                        var $dialog = $('<div></div>')
                        .html(data)
                        .dialog({
                            width: 540,
                            height: 450,
                            modal: true,
                            title: 'Dodaj komentarz',
                            open: function(e,u) {
                                var me = this;
                                $(this).find('#email').keyup(function() {
                                    $(me).find('#gravatarnew').css('background-image',"url('"+getGravatarFor($(me).find('#email').val())+"')");
                                });
                            },
                            buttons: {
                                Ok: function() {
                                    if (!$(this).find('#addCommentForm').valid()) {
                                        return
                                    }
                                    var me = this;
                                    $.ajax({
                                        type: "post",
                                        data: $(this).find('#addCommentForm').serialize(),
                                        url: $(this).find('#addCommentForm').attr('action'),
                                        error: function (data) {
                                            ErrorBox(data)
                                        },
                                        success: function(data) {
                                            $(me).dialog('close');
                                            ReloadPosts(item);
                                        }
                                    });
                                },
                                Cancel: function() {
                                    $(this).dialog('close');
                                }
                            }

                        }).find('#addCommentForm').validate({
                            rules: {
                                author: {
                                    required:true
                                },
                                email: {
                                    required:true,
                                    email:true
                                },
                                content: "required"
                            },
                            messages: {
                                author: {
                                    required: "Podaj swój login lub imię"
                                },
                                email: {
                                    required: "Podaj swój e-mail",
                                    email: "Błędny format adresu e-mail"
                                },
                                content: "Podaj treść komentarza"
                            }
                        });

                    }
                });
            });
            postElem.find('.gravatar').attr("src", function () {
                return getGravatarFor($(this).attr("src"));
            });
        }
    });

}


