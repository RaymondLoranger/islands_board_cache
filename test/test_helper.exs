defmodule TestHelper do
  use PersistConfig

  @spec doctests(module) :: [Macro.Env.name_arity()]
  def doctests(test_module) when is_atom(test_module) do
    get_env(:doctests, %{})[test_module] || []
  end

  @spec excluded_tags :: [atom]
  def excluded_tags do
    get_env(:excluded_tags, [])
  end
end

# Disables file logging for tests so only dev startup is reported.
Application.put_env(:file_only_logger, :level, :none, persistent: true)

ExUnit.configure(exclude: TestHelper.excluded_tags())
ExUnit.start()
