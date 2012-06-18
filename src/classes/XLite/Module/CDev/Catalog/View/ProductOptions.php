<?php
// vim: set ts=4 sw=4 sts=4 et:

/**
 * LiteCommerce
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to licensing@litecommerce.com so we can send you a copy immediately.
 *
 * PHP version 5.3.0
 *
 * @category  LiteCommerce
 * @author    Creative Development LLC <info@cdev.ru>
 * @copyright Copyright (c) 2011 Creative Development LLC <info@cdev.ru>. All rights reserved
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @link      http://www.litecommerce.com/
 * @see       ____file_see____
 * @since     1.0.0
 */

namespace XLite\Module\CDev\Catalog\View;

/**
 * Product options list
 *
 * @see   ____class_see____
 * @since 1.0.0
 *
 * @LC_Dependencies ("CDev\ProductOptions")
 */
abstract class ProductOptions extends \XLite\Module\CDev\ProductOptions\View\ProductOptions implements \XLite\Base\IDecorator
{
    /**
     * Register CSS files
     *
     * @return array
     * @see    ____func_see____
     * @since  1.0.0
     */
    public function getCSSFiles()
    {
        $list = parent::getCSSFiles();

        $list[] = 'modules/CDev/Catalog/product.css';

        return $list;
    }

    /**
     * Get product options
     *
     * @return array
     * @see    ____func_see____
     * @since  1.0.0
     */
    public function getOptions()
    {
        $list = parent::getOptions();

        foreach ($list as $k => $optionGroup) {
            if (\XLite\Module\CDev\ProductOptions\Model\OptionGroup::GROUP_TYPE != $optionGroup->getType()) {
                unset($list[$k]);
            }
        }

        return $list;
    }

    /**
     * Get template name by option group
     *
     * @param \XLite\Module\CDev\ProductOptions\Model\OptionGroup $option Option group
     *
     * @return string
     * @see    ____func_see____
     * @since  1.0.0
     */
    public function getTemplateNameByOption(\XLite\Module\CDev\ProductOptions\Model\OptionGroup $option)
    {
        return 'modules/CDev/ProductOptions/display/radio.tpl';
    }
}