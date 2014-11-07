require 'rest_client'
require 'json'
require 'forwardable'

module GAssign
  DATA_DIR = "#{ENV['HOME']}/.g-assign"
  HOME_DIR = "#{ENV['HOME']}/Projects/gSchool"
  ASSIGNMENTS_DIR = "#{HOME_DIR}/assignments"
end

require_relative "api"
require_relative "data_accessor"
require_relative "authenticator"
require_relative "assignments"
require_relative "cli/setup"
require_relative "cli/fetch"
