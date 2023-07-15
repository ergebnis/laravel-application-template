<?php

declare(strict_types=1);

namespace Tests\Feature;

// use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http;
use PHPUnit\Framework;
use Tests\TestCase;

#[Framework\Attributes\CoversNothing]
final class ExampleTest extends TestCase
{
    public function test_the_application_returns_a_successful_response(): void
    {
        $response = $this->get('/');

        $response->assertStatus(Http\Response::HTTP_OK);
    }
}
