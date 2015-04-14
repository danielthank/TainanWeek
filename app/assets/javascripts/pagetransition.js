$(function() {
  var $main = $('#pt-main'),
  $pages = $main.children('div.pt-page'),
  $next = $('#nextButton'),
    $prev = $('#prevButton'),
    pagesCount = $pages.length,
      current = 0,
      isAnimating = 0,
        animEndEventNames = {
          'WebkitAnimation' : 'webkitAnimationEnd',
          'OAnimation' : 'oAnimationEnd',
          'msAnimation' : 'MSAnimationEnd',
          'animation' : 'animationend'
        },
        animEndEventName = animEndEventNames[Modernizr.prefixed('animation')],
          support = Modernizr.cssanimations;

  function init() {
    console.log("current");

    $pages.each(function() {
      var $page = $(this);
      $page.data('originalClassList', $page.attr('class'));
    });

    $pages.eq(current).addClass('pt-page-current');

    $prev.on('click', function(){translatePage(-1);});

    $next.on('click', function(){translatePage(1);});
  }

  function translatePage(flag) {
    if (isAnimating || current + flag < 0 || current + flag >= pagesCount)
      return false;
    console.log(flag);
    isAnimating = true;
    var $currPage = $pages.eq(current);
    current += flag;
    var $nextPage = $pages.eq(current).addClass('pt-page-current');
    switch (flag) {
      case 1:
        outClass = 'pt-page-moveToLeft';
        inClass = 'pt-page-moveFromRight';
        break;
      case -1:
        outClass = 'pt-page-moveToRight';
        inClass = 'pt-page-moveFromLeft';
    }

    $currPage.addClass(outClass).on(animEndEventName, function() {
      $currPage.off(animEndEventName);
      endCurrPage = true;
      if( endNextPage ) {
        onEndAnimation( $currPage, $nextPage );
      }
    });

    $nextPage.addClass( inClass ).on( animEndEventName, function() {
      $nextPage.off( animEndEventName );
      endNextPage = true;
      if( endCurrPage ) {
        onEndAnimation( $currPage, $nextPage );
      }
    } );

    if( !support ) {
      onEndAnimation( $currPage, $nextPage );
    }
  }

  function onEndAnimation( $outpage, $inpage ) {
    endCurrPage = false;
    endNextPage = false;
    resetPage( $outpage, $inpage );
    isAnimating = false;
  }

  function resetPage( $outpage, $inpage ) {
    $outpage.attr( 'class', $outpage.data( 'originalClassList' ) );
    $inpage.attr( 'class', $inpage.data( 'originalClassList' ) + ' pt-page-current' );
  }


  init();
  return {init : init};

});
(jQuery);
