{** block-faq_page:original **}
{script src="js/addons/faq_page/accordion.js"}
{foreach $items as $key=>$question}
    <div class='ty-accordion faq-accordion'>
        <h3 class="ui-accordion-header">
            <span class="ui-accordion-header-icon ui-icon"></span>
            {$question.question}
        </h3>
            <div class="ui-accordion-content ty-wysiwyg-content hidden">
                <p>
                    {$question.answer nofilter}
                </p>    
            </div>
        </div>
{/foreach}
