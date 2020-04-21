{** faq_page questions section **}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="questions_form" class="cm-hide-inputs" enctype="multipart/form-data">
<input type="hidden" name="fake" value="1" />
{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id="pagination_contents_questions"}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents_questions"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{if $questions}
<div class="table-responsive-wrapper">
    <table class="table table-middle table--relative table-responsive">
    <thead>
    <tr>
        <th width="1%" class="left mobile-hide">
            {include file="common/check_items.tpl" class="cm-no-hide-input"}
        </th>

        <th>
            <a class="cm-ajax" href="{"`$c_url`&sort_by=position&sort_order=`$search.sort_order_rev`"|fn_url}" 
            data-ca-target-id={$rev}>{__("position_short")}
            {if $search.sort_by == "position"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}
            </a>
        </th>

        <th>
            <a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" 
            data-ca-target-id={$rev}>{__("faq_page.question")}
            {if $search.sort_by == "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}
            </a>
        </th>

        <th class="mobile-hide">
            <a class="cm-ajax" href="{"`$c_url`&sort_by=author&sort_order=`$search.sort_order_rev`"|fn_url}" 
            data-ca-target-id={$rev}>{__("faq_page.author")}
            {if $search.sort_by == "author"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}
            </a>
        </th>

        {hook name="faq_page:manage_header"}
        {/hook}

        <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=timestamp&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("creation_date")}{if $search.sort_by == "timestamp"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="6%" class="mobile-hide">&nbsp;</th>
        <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    </tr>
    </thead>
    {foreach $questions as $question}

        <tr class="cm-row-status-{$question.status|lower}">
            {$allow_save = fn_allow_save_object($question, 'questions')}

            {if $allow_save}
                {assign var="no_hide_input" value="cm-no-hide-input"}
            {else}
                {assign var="no_hide_input" value=""}
            {/if}

            <td class="left mobile-hide">
                <input type="checkbox" name="question_ids[]" value="{$question.question_id}" class="cm-item {$no_hide_input}" />
            </td>

            {* DISPLAY POSITION *}
            <td class="{$no_hide_input} nowrap row-status mobile-hide" data-th="{__("position_short")}">
                {$question.position}
            </td>

            {* DISPLAY QUESTION *}
            <td class="{$no_hide_input}" data-th="{__("faq_page.question")}">
                <a class="row-status" href="{"faq_page.update?question_id=`$question.question_id`"|fn_url}">
                {$question.question|truncate:50 nofilter}</a>
            </td>

            {* DISPLAY AUTHOR *}
            <td class="nowrap row-status {$no_hide_input} mobile-hide">
                {$question.author}
            </td>

            {hook name="faq_page:manage_data"}
            {/hook}

            {* DISPLAY CREATION DATE *}
            <td class="nowrap" data-th="{__("creation_date")}">{$question.timestamp|date_format:"`$settings.Appearance.date_format`"}</td>

            {* DISPLAY gear tools *}
            <td class="mobile-hide">
                {capture name="tools_list"}
                    <li>{btn type="list" text=__("edit") href="faq_page.update?question_id=`$question.question_id`"}</li>
                {if $allow_save}
                    <li>{btn type="list" class="cm-confirm" text=__("delete") href="faq_page.delete?question_id=`$question.question_id`" method="POST"}</li>
                {/if}
                {/capture}
                <div class="hidden-tools">
                    {dropdown content=$smarty.capture.tools_list}
                </div>
            </td>

            {* DISPLAY status*}
            <td class="right" data-th="{__("status")}">
                {include file="common/select_popup.tpl" id=$question.question_id status=$question.status hidden=false object_id_name="question_id" table="faq_questions" popup_additional_class="`$no_hide_input` dropleft"}
            </td>
        </tr>

    {/foreach}
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id="pagination_contents_questions"}

{capture name="buttons"}
    {capture name="tools_list"}
        {if $questions}
            <li>{btn type="delete_selected" dispatch="dispatch[faq_page.m_delete]" form="questions_form"}</li>
        {/if}
    {/capture}
    {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
{/capture}
{capture name="adv_buttons"}
    {hook name="faq_page:adv_buttons"}
    {include file="common/tools.tpl" tool_href="faq_page.add" prefix="top" hide_tools="true" title=__("add_question") icon="icon-plus"}
    {/hook}
{/capture}

</form>

{/capture}


{* side bar section *}
{capture name="sidebar"}
    {hook name="faq_page:manage_sidebar"}
    {include file="common/saved_search.tpl" dispatch="faq_page.manage" view_type="faq_page"}
    {include file="addons/faq_page/views/faq_page/components/faq_page_search_form.tpl" dispatch="faq_page.manage"}
    {/hook}
{/capture}

{* block header section *}
{hook name="faq_page:manage_mainbox_params"}
    {$page_title = __("faq")}
    {$select_languages = true}
{/hook}

{include file="common/mainbox.tpl" title=$page_title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=$select_languages sidebar=$smarty.capture.sidebar}

{** ad section **}