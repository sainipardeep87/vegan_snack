# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, 'log/whenever.log'

every :day, :at => '12:20am', :roles => [:app] do
  rake "push_order_to_hub:push_order"
end


every :hour, :roles => [:app] do
    rake "block_subscription:block_expired_subscriptions"
    rake "notification:notify_customer_and_admin"
end


every :hour, :roles => [:app] do
    rake "block_subscription:block_expired_subscriptions"
    rake "notification:notify_customer_and_admin"
end
