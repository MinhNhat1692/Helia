
jQuery(document).ready(function($) {  
  $('form').validate({
    debug: true,
    onkeyup: false,
    onfocusout: function(e){ $(e).valid() },
    rules: {
      'user[name]': {required: true, minlength: 6},
      'user[email]': {required: true, email: true, remote: "/users/check_email"},
      'user[password]': {minlength: 8, required: true},
      'user[password_confirmation]': {required: true, equalTo: "#user_password"}
    },
    messages: {
      'user[name]': {required: "Bạn phải nhập Tên Người Dùng", minlength: "Ít nhất 6 ký tự"},
      'user[email]': {required: "Bạn phải nhập địa chỉ email", email: "Email không hợp lệ", remote: "Email đã được sử dụng"},
      'user[password]': {minlength: "Mật khẩu phải có ít nhất 8 ký tự", required: "Bạn phải nhập mật khẩu"},
      'user[password_confirmation]': {required: "Bạn phải nhập lại mật khẩu", equalTo: "Nhập lại không khớp"}
    },
    submitHandler: function(form) {
    // do other things for a valid form
      form.submit();
    }
  });
});

