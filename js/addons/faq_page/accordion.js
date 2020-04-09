/**
 *
 * faq_pageAccordion
 *
 */
(function (_, $) {
    $( document ).ajaxComplete(function() {
        propellFaqAccordion();
    });

    function propellFaqAccordion () {
        $( ".faq-accordion" ).on( "click", function () {
            if ($( 'h3' , this ).hasClass('ui-accordion-header-active ui-state-active')) {
                $( 'h3', this ).removeClass( 'ui-accordion-header-active ui-state-active' );
                $( '.ui-accordion-content', this ).hide( 100 );
            } else {
                $( 'h3', this ).addClass( 'ui-accordion-header-active ui-state-active' );
                $( '.ui-accordion-content', this ).show( 200 );
            }
        });
    }
})(Tygh, Tygh.$);