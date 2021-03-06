<?php

/**
 * Created by IntelliJ IDEA.
 *
 * PHP version 7.3
 *
 * @category docker-registry-cli
 * @author   Oleg Tikhonov <to@toro.one>
 */

declare(strict_types=1);

namespace Traff\Registry;

/**
 * Interface ImageInterface.
 *
 * @package Traff\Registry
 */
interface ImageInterface extends \Stringable
{
    public function getName(): string;

    public function createTag(string $name): TagInterface;
}
