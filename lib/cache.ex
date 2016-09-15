defmodule Cache do
  @moduledoc false

  require Application
  require File
  require JSX
  require Path

  def get(key) do
    file = get_file(key)
    {:ok, contents} = read(file, File.regular?(file))
    result = JSX.decode(contents)
    result
  end

  def read(file, true) do
    result = File.read(file)
    result
  end

  def read(_file, false) do
    result = {:ok, "null"}
    result
  end

  def set(key, value) do
    file = get_file(key)
    result = JSX.encode(value, [{:space, 1}, {:indent, 4}])
    result = write(file, result)
    result
  end

  def write(file, {:ok, contents}) do
    result = File.write(file, contents, [:utf8, :write])
    result
  end

  def write(_file, {:error, reason}) do
    result = {:error, reason}
    result
  end

  def get_file(arguments) do
    file = Path.join([Application.get_env(:cache, :path)] ++ arguments)
    directory = Path.dirname(file)
    file = get_file(directory, file, File.dir?(directory))
    file
  end

  def get_file(_directory, file, :true) do
    file
  end

  def get_file(directory, file, :false) do
    :ok = File.mkdir_p(directory)
    :ok = File.chmod(directory, 00755)
    file
  end
end
