require 'rubygems'

Dir["#{ENV['HOME']}/BIN/rb/irb_helpers/*.rb"].each{ |helper| require helper }

ENV.inspect

begin
  require "awesome_print"
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
rescue LoadError => e
  puts "awesome_print gem not found.  Try typing 'gem install awesome_print' to get super-fancy output."
end

