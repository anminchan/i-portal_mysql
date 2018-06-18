/*----------------------------------------------------------------------------
 * Plugin	: jquery.plani.popupzone.js
 * ---------------------------------------------------------------------------
 * Author	: (주)플랜아이 http://plani.co.kr
 * ---------------------------------------------------------------------------
 * Usage	:
 * ---------------------------------------------------------------------------

	
	<div class="popupzone">
		<h2><img src="/images/korean/main/popupzone_title.gif" alt="popupzone" /></h2>
		<ul class="popupzone-controll">
			<li><a href="#popupzone-list" class="pause-button">일시정지</a></li>
			<li><a href="#popupzone-list" class="play-button">재생</a></li>
		</ul>
		<ul class="popupzone-btns">
			<li><a href="#popupzone-list-1"><img src="/images/korean/main/popupzone_btn_off.gif" alt="" /></a></li>
			<li class="on"><a href="#popupzone-list-2"><img src="/images/korean/main/popupzone_btn_on.gif" alt="" /></a></li>
			<li><a href="#popupzone-list-3"><img src="/images/korean/main/popupzone_btn_off.gif" alt="" /></a></li>
		</ul>
		<ul class="popupzone-list" id="popupzone-list">
			<li id="popupzone-list-1"><a href="#"><img src="/images/korean/main/popupzone_01.gif" alt="popupzone_01" /></a></li>
			<li id="popupzone-list-2"><a href="#"><img src="/images/korean/main/popupzone_02.gif" alt="popupzone_03" class="display-none" /></a></li>
			<li id="popupzone-list-3"><a href="#"><img src="/images/korean/main/popupzone_03.gif" alt="popupzone_04" class="display-none" /></a></li>
		</ul>
	</div>

	<script type="text/javascript">
	//<![CDATA[
	try 
	{ 
		$('div.popupzone').PopupZone
		({
			'delay'				: 2,											// 변경 딜레이
			'popupzone_name'	: '.popupzone-list',							// popup obj
			'navigations'		:												// 네비게이션 
			{
				'name'			: '.popupzone-btns',							// 네비게이션 영역 obj
				'on'			: '/images/korean/main/popupzone_btn_on.gif',	// 네비게이션 버튼 on
				'off'			: '/images/korean/main/popupzone_btn_off.gif',	// 네비게이션 버튼 off
				'use'			: true											// 네비게이션 버튼 출력 할 것인가
			},
			'controlls'			:												// 컨트롤러 
			{
				'name'			: '.popupzone-controll',						// 컨트롤러 영역 obj
				'play'			: '.play-button',								// 컨트롤러 시작 버튼명
				'pause'			: '.pause-button',								// 컨트롤러 멈춤 버튼명
				'use'			: true											// 컨트롤러 버튼 출력 할 것인가
			}
		}); 
	}
	catch (e) { }
	//]]>
	</script>

 * ---------------------------------------------------------------------------
 * History
 * ---------------------------------------------------------------------------
 * 2012-01-29(pigcos)	: 최초작성
 * -------------------------------------------------------------------------*/
(function($)
{
	$.fn.PopupZone	= function (option)
	{
		
		var option			= option || {};															/* 옵션 */
		var controlls		= option.controlls || {};												/* 컨트롤러  */
		var navigations		= option.navigations || {};												/* 네비게이션  */
		var delay			= option.delay ? option.delay : 3;										/* 변경 딜레이 */
		var popupzone_name	= option.popupzone_name ? option.popupzone_name : '.popupzone-list';	/* popup obj */

		controlls.name		= controlls.name ? controlls.name :		'.banner_control';				/* 컨트롤러 영역 obj */
		controlls.play		= controlls.play ? controlls.play :		'.btn_play';					/* 컨트롤러 시작 버튼명 */
		controlls.pause		= controlls.pause ? controlls.pause :	'.btn_pause';					/* 컨트롤러 멈춤 버튼명 */
		controlls.before	= controlls.before ? controlls.before :	'.btn_before';					/* 컨트롤러 이전 버튼명 */
		controlls.next		= controlls.next ? controlls.next :		'.btn_next';					/* 컨트롤러 다음 버튼명 */
		controlls.cnt		= controlls.cnt ? controlls.cnt : 		'.now-page';					/* 컨트롤러 멈춤 버튼명 */
		controlls.total		= controlls.total ? controlls.total : 	'.total-page';					/* 컨트롤러 멈춤 버튼명 */
		controlls.use		= controlls.use ? true : false;											/* 컨트롤러 버튼 사용여부 */

		navigations.name	= navigations.name ? navigations.name : '.popupzone-btns';				/* 네비게이션 영역 obj */
		navigations.on		= navigations.on ? navigations.on : false;								/* 네비게이션 버튼 on */
		navigations.off		= navigations.off ? navigations.off : false;							/* 네비게이션 버튼 off */
		navigations.use		= navigations.use ? true : false;										/* 네비게이션 버튼 사용여부 */

		delay				= delay * 1000;

		$(this).each(function ()
		{
			var is_rotate		= true;		
			var element			= $(this);
			var interval		= null;
			var current			= 1;
			var is_focus		= false;
			var plus			= true;
			
			var controll		= $(element).children(controlls.name);
			var navigation		= $(element).find(navigations.name);
			var popupzone		= $(element).find(popupzone_name);

			try	{ var size		= parseInt($(popupzone).children().size(), 10);} catch (e) { var size		= 1;}

			if (controlls.use == false)
			{
				$(controlls.name).hide();
			}
			if (navigations.use == false)
			{
				$(navigation).hide();
			}
			$(controll).find(controlls.total).text(size);

			if (size < 2) { return; }

			$(popupzone).children(':not(:nth-child(1))').slideUp();
			$(popupzone).children(':nth-child(1)').slideDown();

			$(navigation).children().find('img').css('cursor', 'pointer');

			$(popupzone).children().each(function (i)
			{
				$(this).find('a').on
				(
					'mouseover mouseout focusin focusout',
					function (e)
					{
						if (e.type=='mouseover')
						{
							if (is_rotate == true)
							{
								clearTimeout(interval);
								interval	= null;
							}
						}

						if (e.type=='mouseout')
						{
							if (is_rotate == true)
							{
								if (is_focus == false)
								{
									interval	= null;
									interval	= setInterval(rotate, delay); 
								}
							}
						}

						if (e.type=='focusin')
						{
							if (is_rotate == true)
							{
								is_focus	= true;
								clearTimeout(interval);
								interval	= null;
							}
						}

						if (e.type=='focusout')
						{
							if (is_rotate == true)
							{
								is_focus	= false;
								interval	= null;
								interval	= setInterval(rotate, delay);
							}
						}
					}
				);
			});

			if (controlls.use === true)
			{
				$(controll).find(controlls.pause).click(function()
				{
					is_rotate	= false;
					clearInterval(interval);
					interval	= null;
					$(controll).find(controlls.play).show();
					$(controll).find(controlls.pause).hide();
					
					return false;
				});

				$(controll).find(controlls.play).click(function()
				{
					if (is_rotate === false)
					{
						is_focus	= false;
						is_rotate	= true;
						interval	= null;
						interval	= setInterval(rotate, delay);
						$(controll).find(controlls.play).hide();
						$(controll).find(controlls.pause).show();
					}
					return false;
				});
				$(controll).find(controlls.before).click(function()
				{
					plus		= false;
					clearInterval(interval);
					interval	= null;
					rotate();
					if (is_rotate === true)
					{
						interval	= setInterval(rotate, delay);
					}
					return false;
				});
				$(controll).find(controlls.next).click(function()
				{
					plus		= true;
					clearInterval(interval);
					interval	= null;
					rotate();
					if (is_rotate === true)
					{
						interval	= setInterval(rotate, delay);
					}
					return false;
				});
			}
			
			if (navigations.use === true)
			{
				$(navigation).children().each(function(i)
				{
					$(this).click(function()
					{
						current	= i;
						rotate();
						clearInterval(interval);
						interval	= null;
						if (is_rotate === true)
						{
							interval	= setInterval(rotate, delay);
						}
						return false;
					});
				});
			}

			var rotate	= function ()
			{
				if (plus === true)
				{
					current++;
				}
				else current--;
				if (current > size) 
				{ 
					current = 1;
				}
				else if (current <= 0) 
				{
					current = size;
				}
				if (navigations.use === true && navigations.on != false && navigations.off != false)
				{
					$(navigation).children(':not(:nth-child('+current+'))').find('img:first').attr('src', navigations.off).attr('alt', '미선택');
					$(navigation).children(':nth-child('+current+')').find('img:first').attr('src', navigations.on).attr('alt', '선택');
				}
				
				$(popupzone).children(':visible').hide();
				$(popupzone).find('img').hide();

				$(popupzone).children(':nth-child('+current+')').show();
				$(popupzone).children(':nth-child('+(current)+')').find('img:first').show();
				$(controll).find(controlls.cnt).text(current);
			};
			if (is_rotate === true)
			{
				interval	= setInterval(rotate, delay);
			}
		});

		return this;
	};
	
})(jQuery);
