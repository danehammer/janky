require 'net/yail'

module Janky
  module ChatService
    class Irc
      def initialize(settings)
        server = get_required_setting(settings, "JANKY_CHAT_IRC_SERVER")
        port = get_required_setting(settings, "JANKY_CHAT_IRC_PORT")
        nick = settings["JANKY_CHAT_IRC_NICK"] || "janky"
        @channel = get_required_setting(settings, "JANKY_CHAT_IRC_CHANNEL")

        @client = Net::YAIL.new(
          :address    => server,
          :username   => 'janky',
          :realname   => 'janky',
          :nicknames  => [nick, "#{nick}_", "#{nick}__"]
        )

        @rooms = [Room.new(@channel, @channel)]

        @client.on_invite { |event|
          @client.join(event.channel)
          @rooms << Room.new(event.channel, event.channel)
        }

        @client.start_listening
        @client.join @channel
      end

      def get_required_setting(settings, setting)
        value = settings[setting]
        if value.nil? || value.empty?
          raise Error, "#{setting} setting is required"
        end
        value
      end

      def speak(message, room_id, options = {})
        @client.msg room_id, message
      end

      def rooms
        @rooms
      end
    end
  end

  register_chat_service "irc", ChatService::Irc
end
