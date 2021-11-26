import Config

case config_env() do
  :dev ->
    config :file_only_logger, log?: true
    config :log_reset, levels: :none

  :prod ->
    config :file_only_logger, log?: true
    config :log_reset, levels: :none

  :test ->
    config :file_only_logger, log?: true
    config :log_reset, levels: :none

  _ ->
    config :file_only_logger, log?: true
    config :log_reset, levels: :all
end
