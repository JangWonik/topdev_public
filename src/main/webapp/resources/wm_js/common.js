$(document).ready(function(){
	/* gnb */
	$(".depth1").hover(function(){
		$(this).children("ul").slideDown(200);
		$(".depth1").not(this).children("ul").hide();
	},function(){
		$(this).children("ul").hide();
	});

	// Tab Menu JS
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	// Tab Menu JS
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt2").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	// Tab Menu JS
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt4").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt0").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	// Tab Menu JS
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt5").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	// 보고서 기본
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt6").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

	// Tab Menu JS
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcntSearch").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});
	
	// Tab Menu DS_1
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt_1300_ds").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});
	
	// Tab Menu DS_2
	var $tabPopCate = $('.guestPopTap ul li');
	$tabPopCate.click(function(){
		var idx = $('.guestPopTap ul li').index(this);
		$tabPopCate.removeClass('on');
		$(".guestcnt4").hide().eq(idx).show();
		$tabPopCate.eq(idx).addClass('on');
		return false;
	});
	
	// Tab Menu DS_3 
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcntSearch").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});
	
	// Tab Menu DS_4
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcntSearchExt").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});
	
	
	// 보고서 기본
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt7").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});
	
	// 휴가
	var $tabCate = $('.guestTap ul li');
	$tabCate.click(function(){
		var idx = $('.guestTap ul li').index(this);
		$tabCate.removeClass('on');
		$(".guestcnt8").hide().eq(idx).show();
		$tabCate.eq(idx).addClass('on');
		return false;
	});

});
