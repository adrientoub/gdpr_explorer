#! /usr/bin/env ruby

require_relative './common/common'
require_relative './facebook/parser'
require_relative './messages/analyse'

def print_help
  puts "Usage: #{__FILE__ } [path_to_inbox] [output_directory]"
  puts "  'path_to_inbox' is the path to the Facebook Archive folder named 'messages/inbox'"
  puts "  'output_directory' is the directory where you want the script to output its work"
  exit 1
end

if ARGV.length < 2
  print_help
end
force = Common.get_force_from_argv

path_to_inbox, output_directory = ARGV

index = Common.read_from_index(Common::MESSAGES_TYPE, output_directory) unless force
index ||= FacebookParser.parse(path_to_inbox, output_directory)

MessagesAnalyse.analyse(index, output_directory, force)
