require "janky"
require "janky/chat_service/irc"

ENV["JANKY_BASE_URL"]="http://localhost/"
ENV["JANKY_BUILDER_DEFAULT"]="http://build.aeon.cerner.corp/"
ENV["JANKY_CONFIG_DIR"]="/Users/dh015921/notCerner/janky/config"
ENV["JANKY_HUBOT_USER"]="janky"
ENV["JANKY_HUBOT_PASSWORD"]="janky"

ENV["JANKY_GITHUB_USER"]="TODOTODO"
ENV["JANKY_GITHUB_PASSWORD"]="TODOTODO"
ENV["JANKY_GITHUB_HOOK_SECRET"]="TODOTODO"

ENV["JANKY_CHAT_DEFAULT_ROOM"]="#janky"
ENV["JANKY_GITHUB_API_URL"]="http://github.cerner.com/api/v3/"
ENV["RACK_ENV"]="production"
ENV["DATABASE_URL"]="postgres://localhost:5432/janky"
ENV["JANKY_CHAT"]="irc"
ENV["JANKY_CHAT_IRC_SERVER"]="localhost"
ENV["JANKY_CHAT_IRC_PORT"]="6667"
ENV["JANKY_CHAT_IRC_CHANNEL"]="#janky"

Janky.setup(ENV)
run Janky.app
