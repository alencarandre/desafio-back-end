namespace :processing do
  desc 'Keep Reading from save data queue and process received messages'
  task polling: :environment do
    trap("INT") { puts "Shutting down."; Kernel.exit! }

    SAVE_DATA_QUEUE_URL = ENV['SAVE_DATA_QUEUE_URL']
    queue_processor_service = QueueProcessorService.new(SAVE_DATA_QUEUE_URL)

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
