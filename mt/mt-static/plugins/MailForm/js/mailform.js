var FJAjaxMail = {};

FJAjaxMail.send = function(mode) {
    document.mail_form.mail_preview.disabled = true;
    document.mail_form.mail_post.disabled = true;
    var params = Form.serialize("mail_form");
    $('ajax_mail').innerHTML = FJAjaxMail.waitMsg;
    if (mode == "post") {
        params += "&mail_post=1";
    }
    else if (mode == "preview") {
        params += "&mail_preview=1";
    }

    new Ajax.Request(FJAjaxMail.cgiPath + 'plugins/MailForm/mt-mail-form.cgi',
                     { method : 'post',
                       parameters : params,
                       onComplete : FJAjaxMail.showResult,
                       onFailure : FJAjaxMail.failureResult });
    location.hash = 'ajax_mail';
    return false;
};

FJAjaxMail.showResult = function(obj) {
    $("ajax_mail").innerHTML = obj.responseText;
};

FJAjaxMail.failureResult = function(obj) {
    $('ajax_mail').innerHTML = FJAjaxMail.failureMsg;
    $("send_status").style.display = 'none';
}
