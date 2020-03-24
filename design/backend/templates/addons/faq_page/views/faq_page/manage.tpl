{** test section **}

{* <p>
{__('faq_page.question')}: {$question}
</p>
<p>
{__('faq_page.answer')}: {$answer}
</p> *}

{** questions section **}

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
            <a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" 
            data-ca-target-id={$rev}>{__("faq_page.question")}
            {if $search.sort_by == "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
        </th>
        <th class="mobile-hide">
            <a class="cm-ajax" href="{"`$c_url`&sort_by=type&sort_order=`$search.sort_order_rev`"|fn_url}" 
            data-ca-target-id={$rev}>{__("faq_page.author")}
            {if $search.sort_by == "type"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
        </th>

        {* {hook name="banners:manage_header"}
        {/hook} *}

        <th width="6%" class="mobile-hide">&nbsp;</th>
        <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
    </tr>
    </thead>
    {foreach from=$questions item=question}
        <tr class="cm-row-status-{$question.status|lower}">
            {assign var="allow_save" value=$question|fn_allow_save_object:"questions"}

            {if $allow_save}
                {assign var="no_hide_input" value="cm-no-hide-input"}
            {else}
                {assign var="no_hide_input" value=""}
            {/if}

            <td class="left mobile-hide">
                <input type="checkbox" name="question_ids[]" value="{$question.question_id}" class="cm-item {$no_hide_input}" />
            </td>

            <td class="{$no_hide_input}" data-th="{__("faq_page.question")}">
                <a class="row-status" href="{"question.update?question_id=`$question.question_id`"|fn_url}">{$question.question}</a>
                {* {include file="views/companies/components/company_name.tpl" object=$banner} *}
            </td>

            <td class="nowrap row-status {$no_hide_input} mobile-hide">
                {$question.author}
            </td>

        </tr>
    {/foreach}
    {* {foreach from=$questions item=question}
    <tr class="cm-row-status-{$question.status|lower}">
        {assign var="allow_save" value=$question|fn_allow_save_object:"questions"}

        {if $allow_save}
            {assign var="no_hide_input" value="cm-no-hide-input"}
        {else}
            {assign var="no_hide_input" value=""}
        {/if}

        <td class="left mobile-hide">
            <input type="checkbox" name="question_ids[]" value="{$question.question_id}" class="cm-item {$no_hide_input}" /></td>
        <td class="{$no_hide_input}" data-th="{__("question")}">
            <a class="row-status" href="{"banners.update?banner_id=`$banner.banner_id`"|fn_url}">{$banner.banner}</a>
            {include file="views/companies/components/company_name.tpl" object=$banner}
        </td>
        <td class="nowrap row-status {$no_hide_input} mobile-hide">
            {hook name="banners:manage_banner_type"}
            {if $banner.type == "G"}{__("graphic_banner")}{else}{__("text_banner")}{/if}
            {/hook}
        </td>

        {hook name="banners:manage_data"}
        {/hook}

        <td class="mobile-hide">
            {capture name="tools_list"}
                <li>{btn type="list" text=__("edit") href="banners.update?banner_id=`$banner.banner_id`"}</li>
            {if $allow_save}
                <li>{btn type="list" class="cm-confirm" text=__("delete") href="banners.delete?banner_id=`$banner.banner_id`" method="POST"}</li>
            {/if}
            {/capture}
            <div class="hidden-tools">
                {dropdown content=$smarty.capture.tools_list}
            </div>
        </td>
        <td class="right" data-th="{__("status")}">
            {include file="common/select_popup.tpl" id=$banner.banner_id status=$banner.status hidden=true object_id_name="banner_id" table="banners" popup_additional_class="`$no_hide_input` dropleft"}
        </td>
    </tr>
    {/foreach} *}
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id="pagination_contents_banners"}

{capture name="buttons"}
    {capture name="tools_list"}
        {if $questions}
            <li>{btn type="delete_selected" dispatch="dispatch[banners.m_delete]" form="banners_form"}</li>
        {/if}
    {/capture}
    {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
{/capture}
{capture name="adv_buttons"}
    {hook name="banners:adv_buttons"}
    {include file="common/tools.tpl" tool_href="banners.add" prefix="top" hide_tools="true" title=__("add_banner") icon="icon-plus"}
    {/hook}
{/capture}

</form>

{/capture}


{* side bar section *}
{capture name="sidebar"}
    {hook name="faq_page:manage_sidebar"}
    {include file="common/saved_search.tpl" dispatch="banners.manage" view_type="banners"}
    {include file="addons/banners/views/banners/components/banners_search_form.tpl" dispatch="banners.manage"}
    {/hook}
{/capture}

{* block header section *}
{hook name="faq_page:manage_mainbox_params"}
    {$page_title = __("faq")}
    {$select_languages = true}
{/hook}

{include file="common/mainbox.tpl" title=$page_title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=$select_languages sidebar=$smarty.capture.sidebar}

{** ad section **}
