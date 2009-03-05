-- my own hand-rolled lua testing framework, just coz
-- i feel like it. here's the api:
suite = {
  -- we can have a description so it prints out all nice
  description = 'testing the test runner',
   -- the setup method is run once before each test, and
  -- whatever the function returns is passed in as an arg
  -- for each test method as the fixture
  setup = function()
    print('setting up coz i said so') -- debug yay
    return 'a string'
  end,
  -- and, yeah, clean up the fixture if required, too
  teardown = function(fixture)
    print('burning down, hot topic' .. fixture) -- debug yay
  end,
  tests = {
    {
      description = 'it is a string',
      test = function(fixture)
        -- return true or false, false indicates a failure
        -- and true indicates a pass, nice!
        -- i know this is limited, but i'll add more complicated
        -- usage and debugging and crap once i've got some more
        -- understanding of what is possible with lua, i think
        -- this is a good start to get started with!
        return type(fixture) == 'string'
      end
    },
    {
      description = 'it has a value of: a string',
      test = function(fixture)
        return fixture == 'a string'
      end
    },
    {
      description = 'this fails, hehe',
      test = function(fixture)
        return false -- oh how i miss ruby's implicit return :)
      end
    }
  },
  run = function()
    -- use meta tables or something to run self in a runner?
    -- or something?
    -- gah!
  end
}
-- output should look something like this:
-- test 'testing the rest runner': .......... done.
-- OK.
-- when all is well, or:
-- test 'testing the rest runner': .....!.!!.  done.
--  - 'test that it is a string' FAILED
-- yeah yeah i know, it's not very helpful, we'll get there

-- questions that need answering:
-- can i return multiple args and pass em in to the test functions?
-- should i use assert instead?
-- what happens when there is no setup/teardown?
-- what happens when there is?
-- should i verify the tables are marked up correctly?

runner = {
  run = function(suite)
    print('Suite: ' .. suite.description)
    for n, test in ipairs(suite.tests) do
      print('  Test: ' .. test.description)
      -- set the fixture if there is a setup for the suite
      if suite.setup then fixture = suite.setup() end
      -- if a function has no args, and you pass em
      -- in, it just ignores the args, is all, and
      -- if you call a var or wtf it is, and it is
      -- not set, it'll just return nil
      -- so, call the test, and if it passes, yay, or not
      if test.test(fixture) then
        print '    PASS'
      else
        print '    FAIL'
      end
      -- if there is a setup and a teardown, then teardown the fixture
      if suite.setup and suite.teardown then suite.teardown(fixture) end
    end
    print 'Done.'
  end
}

runner.run(suite)

-- more more more !!!

runner.run({
  description = 'Concatenating strings.',
  setup = function()
    return 'Monster'
  end,
  tests = {
    {
      description = 'Adding handbag to the fixture.',
      test = function(fixture)
        return (fixture .. ' Handbag') == 'Monster Handbag'
      end
    },
    {
      description = 'A failing test.',
      test = function()
        return false
      end
    }
  }
})
