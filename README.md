# Octos Challenge

Difficulty: ⭐☆☆☆☆

______________________________________________________________

# Api

## Setup Instructions

### Installing Elixir

Using [MacOS](https://elixir-lang.org/install.html#:~:text=Using-,Homebrew,-%3A):

```
brew install elixir
```

Using [Windows](https://elixir-lang.org/install.html#windows):

```
https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.2/elixir-websetup.exe
```

Using [Linux](https://elixir-lang.org/install.html#gnulinux):

```
Follow the instructions to your Linux distribution
```

### Verifying Elixir and Erlang version

```
elixir -v
```

### Clone repository

```
git clone git@github.com:patric-vinicios/octos.git
```

**Enter into the repository:**

```
cd octos
```

### Installing [Phoenix](https://hexdocs.pm/phoenix/up_and_running.html)

```
mix archive.install hex phx_new
```

### Starting Phoenix Server

```
docker compose -f docker-compose.dev.yml up -d
docker compose -f docker-compose.test.yml up -d
```

**then run:**

```
mix deps.get
mix ecto.setup
```

**Then run:**

`iex -S mix phx.server`

Now you can visit [`http://localhost:4000/dashboard`](http://localhost:4000/dashboard) from your browser.

___________________________________________________________________________

