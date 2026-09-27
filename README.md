# Repro: Cldr clause heads overflow the stack when parsing Hologram's runtime

This is [`hologram_skeleton`](https://github.com/bartblast/hologram_skeleton) at `16fe18d` (Hologram 0.11.1), plus `ex_cldr_dates_times` and a Cldr backend. See the second commit. No page uses Cldr.

```sh
mix deps.get
HOLOGRAM_START=1 mix compile

# The runtime has the clause heads of Cldr.Validity.U.encode_key/2 (about 239 KB of nested guards)
grep -o 'defineFunctionClauseHeads("Cldr[^"]*","[a-z_]*",[0-9]' priv/static/hologram/runtime-*.js

# Parsing it (without running it) needs about 868 KB of stack. Without ex_cldr it needs about 48 KB.
node --stack-size=700 -e "new (require('vm').Script)(require('fs').readFileSync(process.argv[1], 'utf8'))" priv/static/hologram/runtime-*.js
# => RangeError: Maximum call stack size exceeded
```

Toolchain: Elixir 1.20.2, OTP 29.0.3 (`.tool-versions`) and Node 26.

---



# Hologram Skeleton

This repository contains a bare-bones skeleton application for the Hologram web framework, built on top of Phoenix. It provides a minimal starting point for:

- Experimenting with Hologram
- Reproducing issues for bug reports
- Learning the basics of Hologram development
- Creating new Hologram applications

## Getting Started

To start your Hologram application:

1. Clone this repository
   ```bash
   git clone https://github.com/bartblast/hologram_skeleton.git
   cd hologram_skeleton
   ```

2. Install dependencies
   ```bash
   mix setup
   ```

3. Start the Phoenix server
   ```bash
   mix phx.server
   ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to see the Hologram application running.

## File Organization

Hologram follows a convention of placing page and component files in the `app` directory. However, you can place your files in any directory that is compiled by the Elixir compiler, such as the `lib` directory.

## Database Configuration

To enable database functionality, uncomment the `HologramSkeleton.Repo` line in `lib/hologram_skeleton/application.ex`:

```elixir
children = [
  HologramSkeletonWeb.Telemetry,
  HologramSkeleton.Repo,  # Uncomment this line
  # ...
]
```

## Learn More

Visit the official Hologram website at [https://hologram.page](https://hologram.page) for comprehensive documentation and guides.

## License

This project is licensed under the same license as Hologram itself.
