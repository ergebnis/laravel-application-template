<?php

declare(strict_types=1);

namespace Tests;

use Illuminate\Foundation;

abstract class TestCase extends Foundation\Testing\TestCase
{
    use CreatesApplication;
}
