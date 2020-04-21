{if !$smarty.request.extra}
<script type="text/javascript">
(function(_, $) {
    _.tr('text_items_added', '{__("text_items_added")|escape:"javascript"}');

    $.ceEvent('on', 'ce.formpost_questions_form', function(frm, elm) {

        var questions = {};

        if ($('input.cm-item:checked', frm).length > 0) {
            $('input.cm-item:checked', frm).each( function() {
                var id = $(this).val();
                questions[id] = $('#question_' + id).text();
            });

            {literal}
            $.cePicker('add_js_item', frm.data('caResultId'), questions, 'b', {
                '{question_id}': '%id',
                '{question}': '%item'
            });
            {/literal}

            $.ceNotification('show', {
                type: 'N', 
                title: _.tr('notice'), 
                message: _.tr('text_items_added'), 
                message_state: 'I'
            });
        }

        return false;
    });

}(Tygh, Tygh.$));
</script>
{/if}
</head>

{include file="addons/faq_page/views/faq_page/components/faq_page_search_form.tpl" dispatch="faq_page.picker" extra="<input type=\"hidden\" name=\"result_ids\" value=\"pagination_`$smarty.request.data_id`\">" put_request_vars=true form_meta="cm-ajax" in_popup=true}

<form action="{$smarty.request.extra|fn_url}" data-ca-result-id="{$smarty.request.data_id}" method="post" name="questions_form" enctype="multipart/form-data">

{include file="addons/faq_page/views/faq_page/components/faq_page_questions_list.tpl" questions=$questions form_name="questions_form"}

{if $questions}
<div class="buttons-container">
    {include file="buttons/add_close.tpl" but_text=__("faq_page.add_questions") but_close_text=__("faq_page.add_questions_and_close") is_js=$smarty.request.extra|fn_is_empty}
</div>
{/if}

</form>
