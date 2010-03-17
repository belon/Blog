/**
 * This function loads post on the first page, starting at page page
 */
function LoadBlogContent(page) {
    $('#blogcontent').empty();

    $.ajax({
        url: "/Blog/app/bloglist",
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
//                                $.ajax({
//                                   url: "/Blog/app/addComment?id="+t.id ,
//                                   error: function(data) {
//                                       ErrorBox(data);
//                                   },
//                                   success: function(data) {
//                                       $(t).find('.commentcontent').html(data);
//                                   }
//                                });
//                            });
            });
        },
        error : function(data) {
            MessageBox(data);
        }
    });
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
});


