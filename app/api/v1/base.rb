module V1
  class Base < Grape::API
    version 'v1', using: :path

    helpers V1::Helpers

    mount Users
    mount Courses
    mount Purchase
  end
end