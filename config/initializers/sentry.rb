Sentry.init do |config|
  config.dsn = 'https://838c0012edd8407fb80b5d1c80439c48@o1223030.ingest.sentry.io/6367136'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
