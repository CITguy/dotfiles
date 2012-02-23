require 'rubygems'

class String
  def bitsize; return (self.bytesize * 8); end;
  def octetsize; return self.bytesize; end;
end

begin
  require 'progressbar'
rescue LoadError => e
  puts "progressbar gem not found. Try typing 'gem install progressbar' to get super-fancy output"
end

#begin
#  require 'libxml'
#rescue LoadError => e
#  puts "libxml-ruby gem not found."
#end

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
