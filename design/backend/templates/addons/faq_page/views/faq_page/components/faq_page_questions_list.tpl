
{include file="common/pagination.tpl" div_id="pagination_`$smarty.request.data_id`"}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="rev" value="pagination_`$smarty.request.data_id`"|default:"pagination_contents"}

{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{if $questions}
<input type="hidden" id="add_question_id" name="question_id" value=""/>

<div class="table-responsive-wrapper">
    <table width="100%" class="table table-middle table--relative table-responsive">
    <thead>
    <tr>
        {hook name="faq_page_questions_list:table_head"}
        <th class="center" width="1%">
            {include file="common/check_items.tpl"}
        </th>
        <th width="90%"><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("question")}{if $search.sort_by == "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        {/hook}
    </tr>
    </thead>
    {foreach $questions as $question}
    <tr>
        {hook name="faq_page_questions_list:table_body"}
        <td>
            <input type="checkbox" name="{$smarty.request.checkbox_name|default:"questions_ids"}[]" value="{$question.question_id}" class="cm-item mrg-check" /></td>
        <td id="question_{$question.question_id}" width="100%" data-th="{__("question")}">{$question.question}</td>
        {/hook}
    </tr>
    {/foreach}
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id="pagination_`$smarty.request.data_id`"}