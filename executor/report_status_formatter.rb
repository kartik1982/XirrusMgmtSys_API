module EXECUTOR
  class ReportStatusFormatter
    RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed
  
    def initialize(out)
      @out = out
    end
  
    def example_finished(notification)
      example = notification.example
#      @out.puts "finishing up test: #{example.metadata[:description]}"
      result = example.execution_result
      $test_count =$test_count + 1
#      $execution_time = $execution_time + result.run_time
#      @out.puts "   result #{result.inspect}"
      stat = result.status.to_s
      @out.puts "   result status #{stat}"
      if stat == "passed"
        $pass_count = $pass_count +1
      elsif stat == "failed" 
        $fail_count= $fail_count+1
      elsif stat == "pending"
        $pending_count = $pending_count +1
      end
    end
    alias example_passed example_finished
    alias example_pending example_finished
    alias example_failed example_finished
  end
end
