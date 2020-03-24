{if $question}
    {assign var="id" value=$question.question_id}
{else}
    {assign var="id" value=0}
{/if}


{** banners section **}

{$allow_save = $question|fn_allow_save_object:"question"}
{$hide_inputs = ""|fn_check_form_permissions}
{* {assign var="b_type" value=$banner.type|default:"G"} *}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" class="form-horizontal form-edit
{if !$allow_save || $hide_inputs} cm-hide-inputs{/if}" 
name="banners_form" enctype="multipart/form-data">
<input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
<input type="hidden" class="cm-no-hide-input" name="question_id" value="{$id}" />

{capture name="tabsbox"}

    <div id="content_general">
        {* {hook name="banners:general_content"} *}
        <div class="control-group">
            <label for="elm_question_name" class="control-label cm-required">{__("faq_page.question")}</label>
            <div class="controls">
            <input type="text" name="question_data[question]" id="elm_question_name" value="{$question.question}" size="25" class="input-large" /></div>
        </div>

        {* {if "ULTIMATE"|fn_allowed_for}
            {include file="views/companies/components/company_field.tpl"
                name="question_data[company_id]"
                id="question_data_company_id"
                selected=$banner.company_id
            }
        {/if} *}

        <div class="control-group">
            <label class="control-label cm-required" for="elm_question_answer">{__("faq_page.answer")}</label>
            <div class="controls">
                <textarea id="elm_question_answer" name="question_data[answer]" cols="35" rows="8" class="cm-wysiwyg input-large">{$question.answer}</textarea>
            </div>
        </div>

        <div class="control-group">
            <label for="elm_question_author" class="control-label cm-required">{__("faq_page.author")}</label>
            <div class="controls">
            <input type="text" name="question_data[author]" id="elm_question_name" value="{$question.author}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group">
            <label for="elm_question_position" class="control-label">{__("position_short")}</label>
            <div class="controls">
                <input type="text" name="question_data[position]" id="elm_question_position" value="{$question.position|default:"0"}" size="3"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="elm_quesstion_timestamp_{$id}">{__("creation_date")}</label>
            <div class="controls">
            {include file="common/calendar.tpl" date_id="elm_question_timestamp_`$id`" date_name="question_data[timestamp]" date_val=$question.timestamp|default:$smarty.const.TIME start_year=$settings.Company.company_start_year}
            </div>
        </div>

        {include file="views/localizations/components/select.tpl" data_name="question_data[localization]" data_from=$question.localization}

        {include file="common/select_status.tpl" input_name="question_data[status]" id="elm_question_status" obj_id=$id obj=$question hidden=true}
        {* {/hook} *}
    <!--content_general--></div>

    <div id="content_addons" class="hidden clearfix">
        {* {hook name="banners:detailed_content"}
        {/hook} *}
    <!--content_addons--></div>

    {* {hook name="banners:tabs_content"}
    {/hook} *}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

{capture name="buttons"}
    {if !$id}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_target_form="questions_form" but_name="dispatch[faq_page.update]"}
    {else}
        {if "ULTIMATE"|fn_allowed_for && !$allow_save}
            {assign var="hide_first_button" value=true}
            {assign var="hide_second_button" value=true}
        {/if}
        {include file="buttons/save_cancel.tpl" but_name="dispatch[faq_page.update]" but_role="submit-link" but_target_form="questions_form" hide_first_button=$hide_first_button hide_second_button=$hide_second_button save=$id}
    {/if}
{/capture}

</form>

{/capture}

{notes}
    {hook name="banners:update_notes"}
    {__("banner_details_notes", ["[layouts_href]" => fn_url('block_manager.manage')])}
    {/hook}
{/notes}

{if !$id}
    {$title = __("faq_page.new_question")}
{else}
    {$title_start = __("faq_page.editing_question")}
    {$title_end = $question.question}
{/if}

{include file="common/mainbox.tpl"
    title_start=$title_start
    title_end=$title_end
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    select_languages=true}

{** banner section **}
