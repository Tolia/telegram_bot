module TelegramBot
  class OutMessage
    include Virtus.model
    attribute :chat, Channel
    attribute :text, String
    attribute :keyboard, Array

    def send_with(bot)
      bot.send_message(self)
    end

    def chat_friendly_name
      chat.friendly_name
    end

    def to_h
      hash = {
        text: text,
        chat_id: chat.id
      }

      unless keyboard.empty?
        hash[:reply_markup] = {
          keyboard: keyboard,
          one_time_keyboard: true
        }.to_json
      end

      hash
    end
  end
end
