require 'rubygems'  
require 'daemons'

LOG_ROOT = File.dirname(File.expand_path(__FILE__))

Daemons.run_proc("main.rb.daemon") do  
  log_file = "${LOG_ROOT}/daemon.log"  
  work(log_file)  
end 

def work(log_file)  
  i = 1  
  begin  
    file = File.open(log_file, "w+")  
    loop do  
      file.puts "Ti říkam po #{i+=1}té, že nespím!"  
      file.flush  
      sleep(5)  
    end  
  ensure  
    if file  
      file.puts "Já končím."  
      file.close  
    end  
  end  
end

