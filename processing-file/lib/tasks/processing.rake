namespace :processing do
  desc 'Keep Reading from processing queue and process receive message'
  task polling: :environment do
    trap("INT") { puts "Shutting down."; Kernel.exit! }

    PROCESSING_QUEUE_URL = ENV['PROCESSING_QUEUE_URL']
    queue_processor_service = QueueProcessorService.new(PROCESSING_QUEUE_URL)

    loop do
      begin
        queue_processor_service.call
      rescue Exception => e
        puts e.message  
        puts e.backtrace.inspect  
      end
    end
  end
end
