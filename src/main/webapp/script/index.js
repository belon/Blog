/**
 * This function loads post on the first page, starting at page page
 */
function LoadBlogContent(page) {
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
        $.ajax({
            url: "/Blog/app/bloglist",
            success: function(data) {
                $('#blogcontent').html(data);

                // dodanie linków do 'Pokaż komentarze'
                $('#blogcontent .comments_link a').click(function() {
                    var postElem = $(this).parents('.post');
                    $.ajax({
                        url: "/Blog/app/commentlist?id="+postElem.attr('id')+"&ajax=1" ,
                        error: function(data) {
                            ErrorBox(data);
                        },
                        success: function(data) {
                            postElem.find('.comments').html(data);
                        }
                    });
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
                $.ajax({
                    url: "/Blog/app/bloglist?tagId="+this.id+"&ajax=1" ,
                    success: function(data) {
                        $('#blogcontent').html(data);
                        $('#blogcontent .comments_link a').click(function() {
                            var postElem = $(this).parents('.post');
                            $.ajax({
                                url: "/Blog/app/commentlist?id="+postElem.attr('id')+"&ajax=1" ,
                                error: function(data) {
                                    ErrorBox(data);
                                },
                                success: function(data) {
                                    postElem.find('.comments').html(data);
                                }
                            });
                        });
                    },
                    error: function(data) {
                        ErrorBox(data);
                    }
                });
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
    return "http://gravatar.com/avatar/" + hex_md5(email) + "?s=48&d=http://" + getMetaData('base_url') + "images/gravatar-48.png";
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

    // załadowanie gravatarów
    $('#gravatars img').attr("src", getGravatarFor("jaroslaw.bela@gmail.com"));

    // Kolorowanie składni
    SyntaxHighlighter.config.stripBrs = true;
    SyntaxHighlighter.all();
});


