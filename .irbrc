require 'rubygems'

begin
  require 'progressbar'
rescue LoadError => e
  puts "progressbar gem not found. Try typing 'gem install progressbar' to get super-fancy output"
end

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


def put_errors_for(ar_model)
  unless ar_model.kind_of?(ActiveRecord::Base)
    puts "Argument is not a kind of ActiveRecord::Base" 
  else
    model_errors = []
    model.errors.each { |attr, err| model_errors << err }
    model_errors
  end
end#put_errors_for
