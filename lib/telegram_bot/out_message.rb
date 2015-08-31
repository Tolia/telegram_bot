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

      hash[:reply_markup] = if keyboard.flatten.empty?
                              {
                                hide_keyboard: true
                              }
                            else
                              {
                                keyboard: keyboard,
                                one_time_keyboard: true
                              }
                            end.to_json

      hash
    end
  end
end
