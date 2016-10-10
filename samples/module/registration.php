<?php
/**
 * Demo_HelloWorld extension
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the MIT License
 * that is bundled with this package in the file LICENSE
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/mit-license.php
 *
 * @category  Demo
 * @package   Demo_HelloWorld
 * @copyright 2016 Tushar Rawal
 * @license   http://opensource.org/licenses/mit-license.php MIT License
 * @author    Tushar Rawal
 */
\Magento\Framework\Component\ComponentRegistrar::register(
    \Magento\Framework\Component\ComponentRegistrar::MODULE,
    'Demo_HelloWorld',
    __DIR__
);