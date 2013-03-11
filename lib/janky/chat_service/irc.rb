require "IRC"

module Janky
  module ChatService
    class Irc
      def initialize(settings)
        server = get_required_setting(settings, "JANKY_CHAT_IRC_SERVER")
        port = get_required_setting(settings, "JANKY_CHAT_IRC_PORT")
        nick = settings["JANKY_CHAT_IRC_NICK"] || "janky"
        @channel = get_required_setting(settings, "JANKY_CHAT_IRC_CHANNEL")

        @client = IRC.new @nick, server, port, "janky"    
        @client_thread = Thread.new do
          @client.connect
        end
      end

      def get_required_setting(settings, setting)
        value = settings[setting]
        if value.nil? || value.empty?
          raise Error, "#{setting} setting is required"
        end
        value
      end

      def speak(message, room_id, options = {})
        @client.send_message room_id, message
      end

      def rooms
        @client.join(@channel)
        @rooms ||= @client.channels.map do |channel|
          Room.new(channel.name, channel.name)
        end
      end
    end
  end

  register_chat_service "irc", ChatService::Irc
end
