puts "Test pid: #{Process.pid}"
puts "Test group: #{Process.getpgid(0)}"
puts "Test parent: #{Process.ppid}"
puts "Test parent group: #{Process.getpgid(Process.ppid)}"

interrupt_count = 0
trap 'INT' do
  interrupt_count += 1
end

Thread.new do
  loop do
    sleep 1
    if interrupt_count > 0
      puts "interrupt_count: #{interrupt_count}"
      exit
    end
  end
end


describe 'interrupt' do
  it 'should interrupt' do
    sleep 5
  end
end