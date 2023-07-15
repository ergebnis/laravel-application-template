<?php

declare(strict_types=1);

namespace App;

final readonly class Example
{
    private function __construct(private string $value)
    {
    }

    public static function fromString(string $value): self
    {
        return new self($value);
    }

    public function toString(): string
    {
        return $this->value;
    }
}
