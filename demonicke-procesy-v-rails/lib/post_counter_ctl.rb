require 'rubygems'  
require 'daemons'  

dir = File.dirname(__FILE__)  
log = File.join(dir, '..', 'log')  

opts = {  
  :app_name => "post_counter_daemon", # název démona  
  :dir_mode => :normal, # interpretuj :dir jako normální cestu  
  :dir => log, # logy a výstup ukládej sem  
  :log_output => false, # zahazuj výstup skriptu  
  :backtrace => true, # pokud sript spadna zaloguj vyjímku  
  :multiple => false, # pouze jedna instance  
  :monitor => true # pokud spadne spusť jej znovu  
}  

counter = File.join(dir, "post_counter.rb")  
Daemons.run(counter, opts)  
