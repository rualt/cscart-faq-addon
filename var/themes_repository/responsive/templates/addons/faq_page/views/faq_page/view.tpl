{include file="common/pagination.tpl"}

{foreach from=$questions item=question}
   {$question.question}
   {$question.answer}
{/foreach}

{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{__("faq")}{/capture}