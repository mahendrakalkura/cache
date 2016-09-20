defmodule Cache do
  @moduledoc false

  def get(key) do
    file = get_file(key)
    case File.regular?(file) do
      true ->
        contents = File.read!(file)
        contents = JSX.decode!(contents)
        {:ok, contents}
      false ->
        {:error, nil}
    end
  end

  def set(key, value) do
    file = get_file(key)
    contents = JSX.encode!(value, [{:space, 1}, {:indent, 4}])
    File.write!(file, contents, [:write])
  end

  def get_file(key) do
    file = Path.join([Application.get_env(:cache, :path)] ++ key)
    directory = Path.dirname(file)
    unless File.dir?(directory) do
      :ok = File.mkdir_p!(directory)
      :ok = File.chmod!(directory, 0o755)
    end
    file
  end
end
