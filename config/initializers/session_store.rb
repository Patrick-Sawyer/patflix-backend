if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_patflix", domain: "www.disco-computer.com"
else
  Rails.application.config.session_store :cookie_store, key: "_patflix"
end
