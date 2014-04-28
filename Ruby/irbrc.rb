require 'irb/completion'
require 'pp'
require 'cgi'
require 'base64'
#require 'aws-sdk'

IRB.conf[:AUTO_INDENT] = true
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

# irb history
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irb_history")

# List only methods on an object that are likely to be pertienent
# from Ruby Cookbook section:10.3
class Object
    def my_methods_only
        my_super = self.class.superclass
        return my_super ? methods - my_super.instance_methods : methods
    end
end


