class Admin::BaseController < ApplicationController
  layout "admin"
  http_basic_authenticate_with(
    name: ENV.fetch("ADMIN_NAME"),
    password: ENV.fetch("ADMIN_PASSWORD")
  )
end
