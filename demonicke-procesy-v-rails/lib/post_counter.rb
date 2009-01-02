#!/usr/bin/ruby  

# pokud není nastavený environment tak nastav na development  
ENV['RAILS_ENV'] ||= 'development'  
# načtení environmentu - prakticky nám nabootuje Rails  
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')  

log_file = File.join(File.dirname(__FILE__), '..', 'log', 'post_count.txt')  
begin  
  file = File.open(log_file, 'w+')  
  loop do  
    count = Post.count  
    file.puts "V systému je #{count} článků."  
    file.flush  
    sleep(60)  
  end  
ensure  
  file.close if file  
end

