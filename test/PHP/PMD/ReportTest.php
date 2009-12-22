<?php
/**
 * This file is part of PHP_PMD.
 *
 * PHP Version 5
 *
 * Copyright (c) 2009, Manuel Pichler <mapi@pdepend.org>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *
 *   * Neither the name of Manuel Pichler nor the names of his
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * @category  PHP
 * @package   PHP_PMD
 * @author    Manuel Pichler <mapi@pdepend.org>
 * @copyright 2009 Manuel Pichler. All rights reserved.
 * @license   http://www.opensource.org/licenses/bsd-license.php  BSD License
 * @version   SVN: $Id$
 * @link      http://www.pdepend.org/pmd
 */

require_once dirname(__FILE__) . '/AbstractTest.php';

require_once 'PHP/PMD/Report.php';

/**
 * Test case for the report class.
 *
 * @category  PHP
 * @package   PHP_PMD
 * @author    Manuel Pichler <mapi@pdepend.org>
 * @copyright 2009 Manuel Pichler. All rights reserved.
 * @license   http://www.opensource.org/licenses/bsd-license.php  BSD License
 * @version   Release: @package_version@
 * @link      http://www.pdepend.org/pmd
 */
class PHP_PMD_ReportTest extends PHP_PMD_AbstractTest
{
    /**
     * Tests that the report returns a linear/sorted list of all rule violation
     * files.
     *
     * @return void
     * @covers PHP_PMD_Report
     * @group phpmd
     * @group unittest
     */
    public function testReportReturnsAListWithAllRuleViolations()
    {
        $report = new PHP_PMD_Report();

        $report->addRuleViolation($this->getRuleViolationMock('foo.txt'));
        $report->addRuleViolation($this->getRuleViolationMock('bar.txt'));
        $report->addRuleViolation($this->getRuleViolationMock('foo.txt'));
        $report->addRuleViolation($this->getRuleViolationMock('foo.txt'));
        $report->addRuleViolation($this->getRuleViolationMock('bar.txt'));

        $actual = array();
        foreach ($report->getRuleViolations() as $violation) {
            $this->assertType('PHP_PMD_RuleViolation', $violation);
            $actual[] = $violation->getFileName();
        }

        $expected = array('bar.txt', 'bar.txt', 'foo.txt', 'foo.txt', 'foo.txt');

        $this->assertSame($expected, $actual);
    }

    /**
     * Tests that the report returns the result by the violation line number.
     *
     * @return void
     * @covers PHP_PMD_Report
     * @group phpmd
     * @group unittest
     */
    public function testReportSortsResultByLineNumber()
    {
        $report = new PHP_PMD_Report();

        $report->addRuleViolation($this->getRuleViolationMock('foo.txt', 4, 5));
        $report->addRuleViolation($this->getRuleViolationMock('foo.txt', 1, 2));
        $report->addRuleViolation($this->getRuleViolationMock('foo.txt', 3, 6));
        $report->addRuleViolation($this->getRuleViolationMock('foo.txt', 2, 3));
        $report->addRuleViolation($this->getRuleViolationMock('bar.txt', 2, 3));
        $report->addRuleViolation($this->getRuleViolationMock('bar.txt', 1, 2));

        $actual = array();
        foreach ($report->getRuleViolations() as $violation) {
            $actual[] = array($violation->getFileName(),
                              $violation->getBeginLine(),
                              $violation->getEndLine());
        }

        $expected = array(
            array('bar.txt', 1, 2),
            array('bar.txt', 2, 3),
            array('foo.txt', 1, 2),
            array('foo.txt', 2, 3),
            array('foo.txt', 3, 6),
            array('foo.txt', 4, 5),
        );

        $this->assertSame($expected, $actual);
    }

    /**
     * Tests that the timer method returns the expected result.
     *
     * @return void
     * @covers PHP_PMD_Report
     * @group phpmd
     * @group unittest
     */
    public function testReportTimerReturnsMilliSeconds()
    {
        $start = microtime(true);

        $report = new PHP_PMD_Report();
        $report->start();
        usleep(50000); // 50 Milli Seconds
        $report->end();

        $time = ceil((microtime(true) - $start) * 1000.0);

        $this->assertGreaterThanOrEqual(50.0, $report->getElapsedTimeInMillis());
        $this->assertLessThanOrEqual($time, $report->getElapsedTimeInMillis());
    }
}