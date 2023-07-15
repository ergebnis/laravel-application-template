<?php

declare(strict_types=1);

namespace Tests;

use Illuminate\Contracts;
use Illuminate\Foundation;

trait CreatesApplication
{
    public function createApplication(): Foundation\Application
    {
        $app = require __DIR__.'/../bootstrap/app.php';

        $app->make(Contracts\Console\Kernel::class)->bootstrap();

        return $app;
    }
}
