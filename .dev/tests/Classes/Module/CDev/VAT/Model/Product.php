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

class XLite_Tests_Module_CDev_VAT_Model_Product extends XLite_Tests_TestCase
{
    public function testGetListPrice()
    {
        $tax = \XLite\Core\Database::getRepo('XLite\Module\CDev\VAT\Model\Tax')->find(1);
        foreach ($tax->getRates() as $rate) {
            \XLite\Core\Database::getEM()->remove($rate);
        }
        $tax->getRates()->clear();

        $tax->setEnabled(true);

        $rate = new \XLite\Module\CDev\VAT\Model\Tax\Rate;
        $rate->setValue(10);
        $rate->setPosition(1);
        \XLite\Core\Database::getEM()->persist($rate);
        $tax->addRates($rate);
        $rate->setTax($tax);
        \XLite\Core\Database::getEM()->flush();

        $products = \XLite\Core\Database::getRepo('XLite\Model\Product')->findAll();
        $product = array_shift($products);

        $price = $product->getPrice();
        $this->assertEquals(
            $this->getVAT($price, 0.1, 0.1),
            \XLite::getInstance()->getCurrency()->formatValue($product->getListPrice()),
            'check tax cost 10%'
        );

        // 10%
        $rate = new \XLite\Module\CDev\VAT\Model\Tax\Rate;
        $rate->setValue(20);
        $rate->setPosition(2);
        \XLite\Core\Database::getEM()->persist($rate);
        $tax->addRates($rate);
        $rate->setTax($tax);
        \XLite\Core\Database::getEM()->flush();

        $this->assertEquals(
            $this->getVAT($price, 0.1, 0.1),
            \XLite::getInstance()->getCurrency()->formatValue($product->getListPrice()),
            'check tax cost 10% #2'
        );

        // 20%
        $rate->setPosition(0);
        $memberships = \XLite\Core\Database::getRepo('XLite\Model\Membership')->findAll();
        $membership = array_shift($memberships);
        $rate->setMembership($membership);
        $tax->setVATMembership($membership);
        \XLite\Core\Database::getEM()->flush();

        $this->assertEquals(
            $this->getVAT($price, 0.2, 0.1),
            \XLite::getInstance()->getCurrency()->formatValue($product->getListPrice()),
            'check tax cost 20%'
        );

        // Disabled tax
        $tax->setEnabled(false);
        \XLite\Core\Database::getEM()->flush();
        $this->assertEquals($price, $product->getListPrice(), 'check no-tax cost');
    }

    public function testGetIncludedTaxList()
    {
        $tax = \XLite\Core\Database::getRepo('XLite\Module\CDev\VAT\Model\Tax')->find(1);
        foreach ($tax->getRates() as $rate) {
            \XLite\Core\Database::getEM()->remove($rate);
        }
        $tax->getRates()->clear();

        $tax->setEnabled(true);

        $rate = new \XLite\Module\CDev\VAT\Model\Tax\Rate;
        $rate->setValue(10);
        $rate->setPosition(1);
        \XLite\Core\Database::getEM()->persist($rate);
        $tax->addRates($rate);
        $rate->setTax($tax);
        \XLite\Core\Database::getEM()->flush();

        $products = \XLite\Core\Database::getRepo('XLite\Model\Product')->findAll();
        $product = array_shift($products);

        $product->setPrice(10);

        // 10 - 10 / (1 + 0.1) = 0.91
        $this->assertEquals(
            array('VAT' => 0.91),
            $this->processTaxes($product->getIncludedTaxList(true)),
            'check list 10%'
        );

        $rate->setValue(100);
        \XLite\Core\Database::getEM()->flush();

        // 10 - 10 / (1 + 1) = 5
        $this->assertEquals(
            array('VAT' => 5),
            $this->processTaxes($product->getIncludedTaxList(true)),
            'check list 10%'
        );

        $rate->setValue(10);
        \XLite\Core\Database::getEM()->flush();





        $price = $product->getPrice();

        // 20%
        $rate = new \XLite\Module\CDev\VAT\Model\Tax\Rate;
        $rate->setValue(20);
        $rate->setPosition(0);
        \XLite\Core\Database::getEM()->persist($rate);
        $tax->addRates($rate);
        $rate->setTax($tax);
        \XLite\Core\Database::getEM()->flush();

        $this->assertEquals(
            array('VAT' => $this->getTax($price, 0.2, 0.2)),
            $this->processTaxes($product->getIncludedTaxList(true)),
            'check list 20%'
        );

        // Diff rates
        $memberships = \XLite\Core\Database::getRepo('XLite\Model\Membership')->findAll();
        $membership = array_shift($memberships);
        $rate->setMembership($membership);
        \XLite\Core\Database::getEM()->flush();

        $this->assertEquals(
            array('VAT' => $this->getTax($price, 0.2, 0.1)),
            $this->processTaxes($product->getIncludedTaxList(true)),
            'check list 20% #2'
        );

    }

    protected function getVAT($value, $percent, $tax)
    {
        $value -= ($value - $value / ( 1 + $percent));

        return \XLite::getInstance()->getCurrency()->formatValue($value * (1 + $tax));
    }

    protected function getTax($value, $percent, $tax)
    {
        $value -= ($value - $value / ( 1 + $percent));

        return \XLite::getInstance()->getCurrency()->formatValue($value * $tax);
    }

    protected function processTaxes(array $taxes)
    {
        foreach ($taxes as $k => $v) {
            $taxes[$k] = \XLite::getInstance()->getCurrency()->formatValue($v);
        }

        return $taxes;
    }
}