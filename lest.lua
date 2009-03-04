-- my own hand-rolled lua testing framework, just coz
-- i feel like it. here's the api:
suite = {
  -- we can have a description so it prints out all nice
  description = 'testing the test runner',
   -- the setup method is run once before each test, and
  -- whatever the function returns is passed in as an arg
  -- for each test method as the fixture
  setup = function()
    return 'a string'
  end,
  -- and, yeah, clean up the fixture if required, too
  teardown = function(fixture)
    -- do any clean up on fixture
  end,
  tests = {
    {
      description = 'it is a string',
      run = function(fixture)
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
      run = function(fixture)
        return fixture == 'a string'
      end
    },
    {
      description = 'this fails, hehe',
      run = function(fixture)
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
