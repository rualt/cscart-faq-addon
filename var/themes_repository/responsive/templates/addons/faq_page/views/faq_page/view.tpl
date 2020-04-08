{assign var="title" value=__("faq")}

{include file="common/pagination.tpl"}

{if $questions}

</br>

{foreach $questions as $question}
    <p>
        <h3>
            <details>
                <summary>{$question.question}</summary>
                </br>
                <p>{$question.answer nofilter}</p>
            </details>
        </h3>
    </p>
{/foreach}

{else}
    <p class="ty-no-items">{__("no_items")}</p>
{/if}


{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{$title}{/capture}
