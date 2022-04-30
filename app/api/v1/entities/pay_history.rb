module V1
  module Entities
    class PayHistory < Entities::Base

      expose :total_price
      expose :currency
      expose :pay_type
      expose :pay_time, format_with: :iso8601

    end
  end
end