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
 * @category   LiteCommerce
 * @package    Tests
 * @subpackage Classes
 * @author     Creative Development LLC <info@cdev.ru>
 * @copyright  Copyright (c) 2010 Creative Development LLC <info@cdev.ru>. All rights reserved
 * @license    http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @link       http://www.litecommerce.com/
 * @see        ____file_see____
 * @since      1.0.0
 */

/**
 * XLite_Tests_Core_Session 
 *
 * @see   ____class_see____
 * @since 1.0.13
 */
class XLite_Tests_Core_Session extends XLite_Tests_TestCase
{
    /**
     * testConstruct
     *
     * @return void
     * @see    ____func_see____
     * @since  1.0.13
     */
    public function testConstruct()
    {
        $session = \XLite\Core\Session::getInstance();

        $session->aaa = 123;
        $this->assertTrue(isset($session->aaa), 'check value exists');
        $this->assertEquals(123, $session->aaa, 'check value');

        unset($session->aaa);
        $this->assertNull($session->aaa, 'check empty value');

        // Check DEPRECATED methods
        $session->set('aaa', 123);
        $this->assertEquals(123, $session->get('aaa'), 'check value (deprecated)');
    }

    /**
     * testRestart
     *
     * @return void
     * @see    ____func_see____
     * @since  1.0.13
     */
    public function testRestart()
    {
        $session = \XLite\Core\Session::getInstance();

        $id = $session->getID();

        $session->aaa = 123;
        $this->assertNotNull($session->aaa, 'check value');

        $session->restart();

        $this->assertNotEquals($id, $session->getID(), 'check id');
        $this->assertEquals(123, $session->aaa, 'check value #2');
    }

    /**
     * testGetName
     *
     * @return void
     * @see    ____func_see____
     * @since  1.0.13
     */
    public function testGetName()
    {
        $this->assertEquals('xid', \XLite\Core\Session::getInstance()->getName(), 'check argument name');
    }

    /**
     * testGetID
     *
     * @return void
     * @see    ____func_see____
     * @since  1.0.13
     */
    public function testGetID()
    {
        $this->assertTrue(
            \XLite\Core\Database::getRepo('XLite\Model\Session')->isPublicSessionIdValid(\XLite\Core\Session::getInstance()->getID()),
            'check id'
        );
    }

    /**
     * testCreateFormId
     *
     * @return void
     * @see    ____func_see____
     * @since  1.0.13
     */
    public function testCreateFormId()
    {
        $session = \XLite\Core\Session::getInstance();

        $fid = $session->createFormId();

        $this->assertRegExp('/^[a-z0-9]{32}$/Ssi', $fid, 'check form id format');

        $fid2 = $session->createFormId();

        $this->assertEquals($fid, $fid2, 'check dumplicate form id');

        $session->restart();

        $fid3 = $session->createFormId();

        $this->assertNotEquals($fid, $fid3, 'check dumplicate form id #2');
    }
}
