# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
Rails.application.config.filter_parameters << lambda do |_, value|
  if value.class == String && value.length > 1024
    value.replace(value.truncate(1024))
  end
end
