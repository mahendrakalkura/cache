How to install?
===============

Step 1
------

Add `:cache` to `def application()` in your `mix.exs`.

```
def application() do
  [
    applications: [
      ...
      :cache,
      ...
    ]
  ]
end
```

Step 2
------

Add `:cache` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:cache, git: "https://github.com/mahendrakalkura/cache.git"},
    ...
  ]
end
```

Step 3
------

Add `:cache` section in your `config/config.exs`.

```
config :cache,
  path: "/home/.../cache/"
```

Step 4
------

Execute `mix deps.get`.

How to use?
===========

```
$ iex -S mix
iex(1)> Cache.get(["...{namespace}...", "...{key}..."])
{:error, nil}
iex(2)> Cache.set(["...{namespace}...", "...{key}..."], "...{value}...")
:ok
iex(3)> Cache.get(["...{namespace}...", "...{key}..."])
{:ok, "...{value}..."}
```
