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
 * @since     1.0.15
 */

namespace XLite\Module\CDev\GoSocial\View\Product\Details\Customer\Page;

/**
 * Main product page
 * 
 * @see   ____class_see____
 * @since 1.0.15
 */
abstract class Main extends \XLite\View\Product\Details\Customer\Page\Main implements \XLite\Base\IDecorator
{
    /**
     * Register Meta tags
     *
     * @return array
     * @see    ____func_see____
     * @since  1.0.0
     */
    public function getMetaTags()
    {
        $list = parent::getMetaTags();
        $list[] = $this->getProduct()->getOpenGraphMetaTags();

        return $list;
    }

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
        $list[] = 'modules/CDev/GoSocial/product.css';

        return $list;
    }

    /**
     * Register Meta tags
     *
     * @return array
     * @see    ____func_see____
     * @since  1.0.0
     */
    public function getNamespaces()
    {
        $list = parent::getNamespaces();
        $list['og'] = 'http://ogp.me/ns#';
        $list['fb'] = 'http://www.facebook.com/2008/fbml';

        return $list;
    }
}
