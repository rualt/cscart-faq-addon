
{assign var="title" value=__("faq")}

{include file="common/pagination.tpl"}

{if $questions}
{script src="js/addons/faq_page/accordion.js"}
<div class="ty-accordion">
{foreach $questions as $question}
    <div class='faq-accordion'>
        <h3 class="ui-accordion-header">
        <span class="ui-accordion-header-icon ui-icon"></span>
            {$question.question}
        </h3>
        <div class="ui-accordion-content hidden">
            <p>
                {$question.answer nofilter}
            </p>    
        </div>
    </div>
    {/foreach}
    </div>
{else}
    <p class="ty-no-items">{__("no_items")}</p>
{/if}

{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{$title}{/capture}
