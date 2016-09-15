defmodule Cache do
  @moduledoc false

  require Application
  require File
  require IO
  require JSX
  require Kernel
  require Path

  def select(key) do
    file = get_file(key)
    result = select(file, File.regular?(file))
    result
  end

  def select(file, true) do
    {:ok, device} = File.open(file, [:utf8, :read])
    contents = IO.read(device, :all)
    :ok = File.close(device)
    result = JSX.decode(contents)
    result
  end

  def select(_file, false) do
    result = {:error, nil}
    result
  end

  def insert(key, value) when Kernel.is_list(key) do
    file = get_file(key)
    result = JSX.encode(value, [{:space, 1}, {:indent, 4}])
    result = insert(file, result)
    result
  end

  def insert(file, {:ok, contents}) do
    {:ok, device} = File.open(file, [:utf8, :write])
    :ok = IO.write(device, contents)
    :ok = File.close(device)
    result = {:ok, contents}
    result
  end

  def insert(_file, {:error, reason}) do
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
