# Ruby Exercise Template

This is a blank project you can use to craft your own Ruby projects for exercises
and assessments.

#### Gems

It only comes with the 'rspec' gem for testing. It also comes with files that
set the ruby version and the gemset. Once you pull down this project once, and
bundle gems, you shouldn't have to do it again. Your computer should just know
which Ruby and gemset to use.

## Getting Started

1. `bundle` to get your gems
2. Write tests:
    * Create new files in your spec directory. If they end with '\_spec.rb', rspec
    will run them
    * Write 'require "spec_helper"' on the top of your file
    * Start writing specs for your code
    * If you need to add helper functions, or fixture data, there is a support
    directory. Any file that you include will be required.
3. Write code: The lib directory is hanging out just waiting for you to write some
code and put it there. Files in that directory will be automatically required in your
tests.
