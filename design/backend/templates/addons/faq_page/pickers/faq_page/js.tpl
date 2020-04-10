{if $question_id == "0"}
    {assign var="question" value=$default_name}
{else}
    {assign var="question" value=$question_id|fn_get_faq_page_question_name|default:"`$ldelim`question`$rdelim`"}
{/if}

<tr {if !$clone}id="{$holder}_{$question_id}" {/if}class="cm-js-item{if $clone} cm-clone hidden{/if}">
    {if $position_field}
        <td>
            <input type="text" name="{$input_name}[{$question_id}]" value="{math equation="a*b" a=$position b=10}" size="3" class="input-micro" {if $clone}disabled="disabled"{/if} />
        </td>
    {/if}
    <td><a href="{"faq_page.update?question_id=`$question_id`"|fn_url}">{$question}</a></td>
    <td>
        {capture name="tools_list"}
            {if !$hide_delete_button && !$view_only}
                <li><a onclick="Tygh.$.cePicker('delete_js_item', '{$holder}', '{$question_id}', 'b'); return false;">{__("delete")}</a></li>
            {/if}
        {/capture}
        <div class="hidden-tools">
            {dropdown content=$smarty.capture.tools_list}
        </div>
    </td>
</tr>