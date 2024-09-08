task :demo do
  sh("ruby exercise_pty.rb --quiet")
  puts "\n\n"
  sh("ruby exercise_pty.rb --quiet --no-rake")
end

task :rspec do
  sh("parallel_rspec spec")
end