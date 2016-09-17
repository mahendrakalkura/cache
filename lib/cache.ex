defmodule Cache do
  @moduledoc false

  require Application
  require File
  require JSX
  require Path

  def get(key) do
    file = get_file(key)
    result =
      case File.regular?(file) do
        true ->
          contents = File.read!(file)
          contents = JSX.decode!(contents)
          {:ok, contents}
        false ->
          {:error, nil}
      end
    result
  end

  def set(key, value) do
    file = get_file(key)
    contents = JSX.encode!(value, [{:space, 1}, {:indent, 4}])
    :ok = File.write!(file, contents, [:utf8, :write])
    :ok
  end

  def get_file(arguments) do
    file = Path.join([Application.get_env(:cache, :path)] ++ arguments)
    directory = Path.dirname(file)
    unless File.dir?(directory) do
      :ok = File.mkdir_p!(directory)
      :ok = File.chmod!(directory, 00755)
    end
    file
  end
end
