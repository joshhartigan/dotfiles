require 'rubygems'
require 'irb/completion'

# interactive_editor: use vim within irb
begin
  require 'interactive_editor'
rescue LoadError => err
  warn "couldn't load interactive_editor: #{err}"
end

# awesome print
begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError => err
  warn "couldn't load awesome_print: #{err}"
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :AUTO_INDENT => true,          # turn auto indentation mode on
  :PROMPT_I    => '>> ',         # normal prompt
  :PROMPT_S    => '"> ',         # continuated prompt (strings)
  :PROMPT_C    => '*> ',         # continuated prompt (statements)
}

IRB.conf[:PROMPT_MODE] = :CUSTOM

