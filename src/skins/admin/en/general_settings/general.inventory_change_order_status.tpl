{* vim: set ts=2 sw=2 sts=2 et: *}

{**
 * Currently not used; saved for future
 *
 * @author    Creative Development LLC <info@cdev.ru>
 * @copyright Copyright (c) 2011 Creative Development LLC <info@cdev.ru>. All rights reserved
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @link      http://www.litecommerce.com/
 * @since     1.0.0
 *
 * @ListChild (list="general_settings.general.parts", weight="400")
 *}

{*if:option.name=#inventory_change_order_status#}
<select name="{option.name}">
  <option FOREACH="getInventoryOrderStatuses(),status,label" value="{status}" selected="{option.value=status}">{label:h}</option>
</select>
{end:*}
