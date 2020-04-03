{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}

<form name="faq_page_search_form" action="{""|fn_url}" method="get" class="{$form_meta}">

    {if $smarty.request.redirect_url}
        <input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
    {/if}

    {if $selected_section != ""}
        <input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
    {/if}

    {if $put_request_vars}
        {array_to_fields data=$smarty.request skip=["callback"]}
    {/if}

    {$extra nofilter}

    {capture name="simple_search"}
        <div class="sidebar-field">
            <label for="elm_name">{__("faq_page.question")}</label>
            <div class="break">
                <input type="text" name="name" id="elm_name" value="{$search.name}" />
            </div>
        </div>

        {hook name="faq_page:search_form"}
        {/hook}

        <div class="sidebar-field">
            <label for="elm_status">{__("status")}</label>
            {assign var="items_status" value=""|fn_get_default_statuses:false}
            <div class="controls">
                <select name="status" id="elm_status">
                    <option value="">{__("all")}</option>
                    {foreach from=$items_status key=key item=status}
                        <option value="{$key}" {if $search.status == $key}selected="selected"{/if}>{$status}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        {include file="common/period_selector.tpl" period=$period display="form"}

    {/capture}

    {include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="faq_page"}

</form>

{if $in_popup}
    </div></div>
{else}
    </div><hr>
{/if}
