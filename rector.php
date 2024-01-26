<?php

declare(strict_types=1);

/**
 * Copyright (c) 2023 Andreas Möller
 *
 * For the full copyright and license information, please view
 * the LICENSE.md file that was distributed with this source code.
 *
 * @see https://github.com/ergebnis/laravel-application-template
 */

use Rector\Config;
use Rector\Php81;
use Rector\PHPUnit;
use Rector\ValueObject;

return static function (Config\RectorConfig $rectorConfig): void {
    $rectorConfig->cacheDirectory(__DIR__.'/.build/rector/');

    $rectorConfig->import(__DIR__.'/vendor/fakerphp/faker/rector-migrate.php');

    $rectorConfig->paths([
        __DIR__.'/app/',
        __DIR__.'/bootstrap/',
        __DIR__.'/config/',
        __DIR__.'/database/',
        __DIR__.'/resources/',
        __DIR__.'/routes/',
        __DIR__.'/tests/',
    ]);

    $rectorConfig->phpVersion(ValueObject\PhpVersion::PHP_83);

    $rectorConfig->rules([
        Php81\Rector\Property\ReadOnlyPropertyRector::class,
    ]);

    $rectorConfig->sets([
        PHPUnit\Set\PHPUnitSetList::PHPUNIT_100,
    ]);
};
