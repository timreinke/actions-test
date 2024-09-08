require 'pty'

quiet = ARGV.include?("--quiet")
no_rake = ARGV.include?("--no-rake")

lines = []


PTY.spawn('bash -i -l') do |r, w, pid|
  Thread.new do
    begin 
      while line = r.gets
        puts "> #{line}" unless quiet
        lines << line
      end
    rescue Errno::EIO 

    rescue
      # platform specific error is thrown when the pty is closed
      # Errno::EIO on Linux/BSD probably?
      puts "PTY probably closed: #{e.message}"
    end
  end

  unless quiet
    puts "Shell pid: #{pid}"
    puts "Shell group: #{Process.getpgid(pid)}"
  end

  if !no_rake
    w.write "bundle exec rake rspec\n"
  else
    w.write "bundle exec parallel_rspec\n"
  end
  
  sleep 3
  w.write "\x03" # Ctrl-C, interrupt test
  sleep 1
  w.write "\x04" # Ctrl-D, logout bash
  
  Process.wait(pid)
end

puts lines.find { |line| line.include?("interrupt_count") }