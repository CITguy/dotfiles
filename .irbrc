require 'rubygems'

Dir["/home/ryan/BIN/rb/irb_helpers/*.rb"].each{ |helper| require helper }

begin
  require "ap"
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
rescue LoadError => e
  puts "ap gem not found.  Try typing 'gem install awesome_print' to get super-fancy output."
end

