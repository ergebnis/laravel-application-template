<?php

declare(strict_types=1);

namespace Tests\Unit;

use App\Example;
use Ergebnis\DataProvider;
use PHPUnit\Framework;

#[Framework\Attributes\CoversClass(Example::class)]
final class ExampleTest extends Framework\TestCase
{
    #[Framework\Attributes\DataProviderExternal(DataProvider\StringProvider::class, 'arbitrary')]
    public function testFromStringReturnsExample(string $value): void
    {
        $example = Example::fromString($value);

        self::assertSame($value, $example->toString());
    }
}
