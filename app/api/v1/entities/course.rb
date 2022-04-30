module V1
  module Entities
    class Course < Entities::Base

      expose :id
      expose :subject
      expose :price
      expose :currency
      expose :launch
      expose :url
      expose :description
      expose :expire_day
      expose :category, using: Entities::Category

    end
  end
end