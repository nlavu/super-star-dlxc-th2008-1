	function checkLength( o, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				return false;
			} 
			else {
				return true;
			}
		}

	function checkRegexp( o, regexp) {
		if ( !( regexp.test( o.val() ) ) ) {
			return false;
		} else {
			return true;
		}
	}
	
	function kiemtra(){
		var name = $( "#regusername" ),
			email = $( "#email" ),
			password = $( "#password" );
		if(checkLength(name,3,20) == false)
			{
				alert('Tên tài khoản phải từ 3 đến 20 ký tự !');
				return false;
			}
		if(checkRegexp(name, /^[0-9a-z]([0-9a-z_])+$/i) == false)
			{
				alert('Tên tài khoản không được có những ký tự đặc biệt !');
				return false;
			}
			
			//
		if(checkLength(password,6,1000000000000000000) == false)
			{
				alert('Mật khẩu từ 6 trở lên !');
				return false;
			}
		if(checkRegexp(password, /^([0-9a-zA-Z])+$/) == false)
			{
				alert('Mật khẩu không được có những ký tự đặc biệt');
				return false;
			}
			
			//
		if(checkLength(email,6,80) == false)
			{
				alert('Email từ 6 đến 80 ký tự !');
				return false;
			}
		if(checkRegexp(email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i) == false)
			{
				alert('Email nhập không đúng !');
				return false;
			}
		else
		{
			return confirm('Tôi đã đọc, và đồng ý tuân theo điều khoản đăng ký thành viên của Shopping-Here - Mua bán và giới thiệu sản phẩm online');
			return true;
		}
	}
	
	function kttaogianhang()
	{
		
			var tengianhang = $( "#tengianhang" );

		if(checkLength(tengianhang,6,20) == false)
			{
				alert('Tên gian hàng phải từ 6 đến 20 ký tự !');
				return false;
			}
		if(checkRegexp(tengianhang, /^[0-9a-z]([0-9a-z_])+$/i) == false)
			{
				alert('Bao gồm các ký tự chữ cái, số, gạch dưới. Không bao gồm các ký tự đặc biệt !');
				return false;
			}
		else
		{
			return confirm('Khi đã đăng ký tạo gian hàng trong hệ thống, tức là bạn đã đọc , đã nhất trí &amp; hoàn toàn tuân thủ theo điều lệ hoạt động của Shopping-Here ?');
			return true;
		}
	}
	
	
	
	function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    }
  }
}

function prepareInputsForHints() {
	var inputs = document.getElementsByTagName("input");
	for (var i=0; i<inputs.length; i++){
		// test to see if the hint span exists first
		if (inputs[i].parentNode.getElementsByTagName("span")[0]) {
			// the span exists!  on focus, show the hint
			inputs[i].onfocus = function () {
				this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
			}
			// when the cursor moves away from the field, hide the hint
			inputs[i].onblur = function () {
				this.parentNode.getElementsByTagName("span")[0].style.display = "none";
			}
		}
	}
	// repeat the same tests as above for selects
	var selects = document.getElementsByTagName("select");
	for (var k=0; k<selects.length; k++){
		if (selects[k].parentNode.getElementsByTagName("span")[0]) {
			selects[k].onfocus = function () {
				this.parentNode.getElementsByTagName("span")[0].style.display = "inline";
			}
			selects[k].onblur = function () {
				this.parentNode.getElementsByTagName("span")[0].style.display = "none";
			}
		}
	}
}
addLoadEvent(prepareInputsForHints);
