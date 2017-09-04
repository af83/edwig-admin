$(function() {
  var $el, link, ptitleCont, selectedItem, sticker;
  link = [];
  ptitleCont = "";
  $(document).on('page:before-change', function() {
    link = [];
    return ptitleCont = "";
  });
  $el = $('#main_nav');
  $el.find('.openMenu').on('click', function(e) {
    console.log("menu")
    return $(this).parent().addClass('open');
  });
  $el.find('.closeMenu').on('click', function(e) {
    return $(this).closest('.nav-menu').removeClass('open');
  });
  selectedItem = $el.find('.active');
  selectedItem.closest('.panel-collapse').addClass('in');
  selectedItem.closest('.panel-title').children('a').attr('aria-expanded') === true;
  sticker = function() {
    var data, limit, stickyContent;
    limit = 51;
    if ($(window).scrollTop() >= limit) {
      if ($('.page-action .small').length > 0) {
        data = $('.page-action .small')[0].innerHTML;
      }
      if ($(".page-title").length > 0) {
        ptitleCont = $(".page-title").html();
      }
      stickyContent = '<div class="sticky-content">';
      stickyContent += '<div class="sticky-ptitle">' + ptitleCont + '</div>';
      stickyContent += '<div class="sticky-paction"><div class="small">' + data + '</div></div>';
      stickyContent += '</div>';
      $('#main_nav').addClass('sticky');
      if ($('#menu_top').find('.sticky-content').length === 0) {
        if (ptitleCont.length > 0) {
          $('#menu_top').children('.menu-content').after(stickyContent);
        }
        if (link.length === 0) {
          link = $('.page-action .small').next();
        }
        return $('.sticky-paction .small').after(link);
      }
    } else {
      $('#main_nav').removeClass('sticky');
      if ($('#menu_top').find('.sticky-content').length > 0) {
        if (!$('.page-action').find('.formSubmitr').length) {
          $('.page-action .small').after(link);
        }
        return $('.sticky-content').remove();
      }
    }
  };
  sticker();
  return $(document).on('scroll', sticker);
});