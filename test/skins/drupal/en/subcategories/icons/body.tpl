{* vim: set ts=2 sw=2 sts=2 et: *}

{**
 * ____file_title____
 *  
 * @author    Creative Development LLC <info@cdev.ru> 
 * @copyright Copyright (c) 2010 Creative Development LLC <info@cdev.ru>. All rights reserved
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @version   SVN: $Id$
 * @link      http://www.litecommerce.com/
 * @since     3.0.0
 *}
<ul class="lc-subcategory-icons" IF="category.getSubcategories()">
  <li FOREACH="category.getSubcategories(),subcategory">
    {* FF2 requires an extra div in order to display "inner-blocks" properly *}
    <div>
      <a href="{buildURL(#category#,##,_ARRAY_(#category_id#^subcategory.category_id))}" class="lc-subcategory-icon">
        <widget class="XLite_View_Image" image="{subcategory.getImage()}" maxWidth="{getIconWidth()}" maxHeight="{getIconHeight()}" alt="{subcategory.name.name}" IF="subcategory.hasImage()" />
        <img src="images/no_image.gif" width="{getIconWidth()}" height="{getIconHeight()}" alt="{subcategory.name}" IF="!subcategory.hasImage()" />
      </a>
      <a href="{buildURL(#category#,##,_ARRAY_(#category_id#^subcategory.category_id))}" class="lc-subcategory-name">{subcategory.name}</a>
    </div>
  </li>
</ul>
