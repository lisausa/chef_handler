require 'hipchat'

module HipChat
  class NotifyRoom < Chef::Handler

    def initialize(api_token, room_name, notify_users=false)
      @api_token = api_token
      @room_name = room_name
      @notify_users = notify_users
    end

    def report
      msg = "Failure on #{node.name}: #{run_status.formatted_exception}"

      client = HipChat::Client.new(@api_token)
      client[@room_name].send('Chef', msg, :notify => @notify_users)
    end
  end
end