import Config

case config_env() do
  :dev ->
    config :file_only_logger, level: :all
    config :log_reset, levels: :all

  :prod ->
    config :file_only_logger, level: :all
    config :log_reset, levels: :none

  :test ->
    config :file_only_logger, level: :all
    config :log_reset, levels: :none

  _ ->
    config :file_only_logger, level: :all
    config :log_reset, levels: :all
end
