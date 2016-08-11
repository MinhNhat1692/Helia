
jQuery(document).ready(function($) {  
  $('form').validate({
    debug: true,
    onkeyup: false,
    onfocusout: function(e){ $(e).valid() },
    rules: {
      'session[email]': {required: true, email: true},
      'session[password]': {required: true}
    },
    messages: {
      'session[email]': {required: "Bạn phải nhập địa chỉ email", email: "Địa chỉ email không hợp lệ"},
      'session[password]': {required: "Bạn phải nhập mật khẩu"}
    },
    submitHandler: function(form) {
    // do other things for a valid form
      form.submit();
    }
  });
});

