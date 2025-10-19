# lest

A minimalist testing framework for Lua.

## Overview

**lest** is a simple, hand-rolled testing framework for Lua that provides a clean API for organizing and running tests. It supports test suites with setup/teardown fixtures, nested suites, and straightforward pass/fail assertions.

## Features

- Simple, declarative test suite definition
- Setup and teardown fixtures for test isolation
- Support for nested test suites (planned)
- Clean, readable test output
- Minimal dependencies

## Installation

Copy `lest.lua` into your project directory or Lua path.

## Usage

### Basic Example

```lua
test = require('lest')

test.run({
  my_test_suite = {
    tests = {
      simple_test = function()
        return true  -- test passes
      end,
      another_test = function()
        return 1 + 1 == 2  -- test passes
      end
    }
  }
})
```

### With Setup and Teardown

```lua
test = require('lest')

test.run({
  string_concatenation = {
    setup = function()
      -- Setup runs before each test
      -- Return value is passed as fixture to tests
      return 'Monster'
    end,
    teardown = function(fixture)
      -- Teardown runs after each test
      -- Receives the fixture from setup
      print('Cleaning up: ' .. fixture)
    end,
    tests = {
      test_concatenation = function(fixture)
        return (fixture .. ' Handbag') == 'Monster Handbag'
      end,
      test_length = function(fixture)
        return #fixture == 7
      end
    }
  }
})
```

### API Structure

A test suite is defined as a table with the following structure:

```lua
{
  suite_name = {
    -- Optional: Runs once before each test
    setup = function()
      return fixture  -- fixture is passed to tests
    end,

    -- Optional: Runs once after each test
    teardown = function(fixture)
      -- Clean up resources
    end,

    -- Required: Table of test functions
    tests = {
      test_name = function(fixture)
        return true or false  -- true = pass, false = fail
      end
    }
  }
}
```

### Test Functions

Test functions should return:
- `true` if the test passes
- `false` if the test fails

The fixture parameter is optional and will be `nil` if no setup function is defined.

## Planned Features

From the TODO list and API examples in the code:

- Nested test suites with cascading setup/teardown
- Enhanced error reporting with stack traces
- Better output formatting
- Exit codes for CI/CD integration
- Error catching with `pcall`/`xpcall`

## Example from Legacy API

The current implementation also supports the older API format:

```lua
runner = require('lest')

suite = {
  description = 'testing the test runner',
  setup = function()
    return 'a string'
  end,
  teardown = function(fixture)
    -- cleanup
  end,
  tests = {
    {
      description = 'it is a string',
      test = function(fixture)
        return type(fixture) == 'string'
      end
    }
  }
}

runner.run(suite)
```

## Running Tests

```bash
lua your_test_file.lua
```

Or for the self-test:

```bash
lua lest_test.lua
```

## Development Status

This is an early-stage project. The basic functionality works, but several features are planned (see TODO file). Contributions welcome!

## License

MIT License - see MIT-LICENSE file for details.

Copyright (c) 2009 Ryan Allen

## Why "lest"?

A play on "test" and "less" - a minimalist testing framework that gives you just what you need, lest you need more.
