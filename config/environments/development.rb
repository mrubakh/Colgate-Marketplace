Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  config.active_storage.service = :test

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_caching = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.assets.compile = true
  
  config.web_console.whitelisted_ips = '69.204.8.105'

  # Suppress logger output for asset requests.
  config.assets.quiet = true
  config.action_mailer.perform_deliveries = true
  # ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD'],
    domain: "smtp.gmail.com",
    openssl_verify_mode: "none",
  }
  # config.action_mailer.smtp_settings = {
  #   :address              => "smtp.gmail.com",
  #   :port                 => 587,
  #   :domain               => "smtp.gmail.com",
  #   :user_name            => ENV['GMAIL_USERNAME'],
  #   :password             => ENV['GMAIL_PASSWORD'],
  #   :authentication       => "plain",
  #   :enable_starttls_auto => true,
  #   :openssl_verify_mode => "none"
  # }

  config.action_mailer.default_url_options = { host: '41e81f201ccf4ef7ae2cc76de19eb154.vfs.cloud9.us-east-1.amazonaws.com'}
  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.hosts << "b0e039c9a0a5492b96a19f83a6c53d34.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "8b35d34d5db44622b5394745a18cff1b.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "41e81f201ccf4ef7ae2cc76de19eb154.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "79d7873481b94c4d8c9d6428428b578d.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "a39ad15c1554449c8dc41e6e9e51d34e.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "8c427698965a4826b30b2f9efe2e260a.vfs.cloud9.us-east-1.amazonaws.com"
end
