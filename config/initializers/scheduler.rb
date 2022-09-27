require 'rufus-scheduler'
require 'rake'

scheduler = Rufus::Scheduler.new

# ...

scheduler.cron '0 0 * * MON' do
  Rails.application.load_tasks
  Rake::Task['disbursement:generate'].invoke
end
