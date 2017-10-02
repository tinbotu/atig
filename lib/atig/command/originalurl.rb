# -*- mode:ruby; coding:utf-8 -*-

require 'atig/command/command'

module Atig
  module Command
    class OriginalUrl < Atig::Command::Command
      def initialize(*args)
        super
      end

      def command_name; %w(url u) end

      def action(target, mesg, command, args)
        if args.empty?
          yield "/me #{command} <ID>"
          return
        end
        tid, num = args
        if entry = Info.find_status(db, tid) then
		  yield sprintf("https://twitter.com/%s/statuses/%s", entry.user.screen_name, entry.status.id_str)
        else
          yield "No such ID : #{tid}"
        end
      end
    end
  end
end
