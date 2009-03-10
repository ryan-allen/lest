test = require('lest')

test.run({
  my_ace_suite = {
    tests = {
      a_test = function()
        return true
      end,
      another_test = function()
        return true
      end
    }
  }
})
})
