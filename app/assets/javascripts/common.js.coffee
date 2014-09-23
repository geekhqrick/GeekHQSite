# application startup
keepMenu = false

jQuery ->
  isTouch = (('ontouchstart' in window) || (navigator.msMaxTouchPoints > 0))
  $('body').addClass('touch') if isTouch

  checkScroll()
  $(window).scroll checkScroll

  $('a[href*=#]:not([href=#])').click (ev) =>
    anchr = ev.currentTarget
    nm = anchr.href.substring( anchr.href.indexOf('#') + 1 )
    scrollToSection(nm)
    false

  $('#mbut').click (ev) =>
    keepMenu = true
    $('.zone h2').toggleClass('w_menu')
    $('#mbut').toggleClass 'w_sel'
    setTimeout( clearKeepMenu, 200 )

  $('.zone h2').click (ev) =>
    hdr = $(ev.currentTarget)
    if hdr.hasClass('w_menu')
      zone = hdr.parents('.zone')
      nm = zone.attr('id').slice(2)
      $('#mbut').removeClass('w_sel')
      setMenu(nm)
      scrollToSection(nm)

  $('.zone#z_meet ul li').click (ev) =>
    geek = $(ev.currentTarget)
    $('.zone#z_meet ul li').toggleClass('w_sel') unless geek.hasClass('w_sel')

checkScroll = () ->
  scrollTop = $(window).scrollTop()
  if scrollTop > 0
    $('body').addClass 'w_scrl'
    $('.scrl').addClass 'w_scrl'

    selZone = 'top'
    offSel = true
    for zone in $('.zone')
      zpos = $(zone).position().top - scrollTop
      if zpos <= 5
        selZone = zone.id.slice(2)
        offSel = (zpos < -30)
    setMenu(selZone, offSel)
  else
    $('body').removeClass 'w_scrl'
    $('.scrl').removeClass 'w_scrl'
    setMenu('top')

scrollToSection = (nm) ->
  target = $("a[name='"+nm+"']")
  $('#mmenu li').removeClass('w_sel w_zone')
  $('html,body').animate({ scrollTop: target.offset().top }, 300, 'swing', checkScroll)

setMenu = (nm, zone) ->
  $('#mmenu li').removeClass('w_sel w_zone')
  $('.zone h2').removeClass('w_menu') unless keepMenu
  $('.zone').removeClass('w_sel ')
  $('li.m_'+nm).addClass('w_sel')
  $('.zone#z_'+nm).addClass('w_sel')
  $('li.m_'+nm).addClass('w_zone') if zone

clearKeepMenu = () ->
  keepMenu = false
