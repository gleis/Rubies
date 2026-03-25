# Rubies

A small collection of standalone Ruby scripts for networking, geocoding, key generation, host inspection, and MySQL-backed mail account provisioning.

This repository is not organized as a gem or application. Each file is an independent script with its own dependencies and assumptions.

## Contents

| File | Purpose |
| --- | --- |
| `create` | Creates virtual mail domains and users in a MySQL database for a Postfix-style virtual mailbox setup. |
| `socket_server.rb` | Simple threaded TCP server that logs inbound lines and echoes parsed numeric and alphabetic content. |
| `getip.rb` | Prints the local hostname and attempts to detect a MAC address. |
| `geo` | Geocodes one hardcoded street address and prints the result. |
| `geo2` | Geocodes one or more addresses from command-line arguments or standard input. |
| `ssl.rb` | Generates a 2048-bit RSA key pair and writes PEM files to the current directory. |

## Requirements

- Ruby
- RubyGems packages used by the scripts:
  - `mysql`
  - `docopt`
  - `geocoder`
  - `sysinfo`
- A reachable MySQL server for `create`
- Network access for `geo` and `geo2`

Example gem installation:

```bash
gem install mysql docopt geocoder sysinfo
```

## Usage

### `create`

The `create` script is intended for managing virtual domains and users in a mail database. Before running it, edit the connection settings in the script:

- `myHost`
- `myUser`
- `myPass`
- `myDB`

Examples:

```bash
ruby create --domain example.com
ruby create --user admin@example.com
ruby create --file users.txt
```

`users.txt` should contain one `user@domain` entry per line.

Notes:

- The target schema is expected to contain `virtual_domains` and `virtual_users`.
- The script assumes the domain already exists before creating a user.
- The script currently uses a fixed password value when inserting users, so it should be reviewed before use in any real environment.

### `socket_server.rb`

Starts a TCP server on the provided port, or on the next available port if none is given.

```bash
ruby socket_server.rb 4000
ruby socket_server.rb 4000 127.0.0.1
```

The server appends activity to `log.txt` in the current working directory.

### `getip.rb`

Prints the local hostname and then attempts to extract a MAC address from the host system:

```bash
ruby getip.rb
```

The MAC address lookup is platform-specific and currently only has explicit handling for macOS and Windows.

### `geo`

Geocodes a single hardcoded address:

```bash
ruby geo
```

This is mainly a short example script.

### `geo2`

Geocodes addresses from arguments:

```bash
ruby geo2 "1600 Pennsylvania Ave NW, Washington, DC 20500"
```

Or from standard input:

```bash
printf "Chicago, IL\nNew York, NY\n" | ruby geo2
```

### `ssl.rb`

Generates a new RSA key pair in the current directory:

```bash
ruby ssl.rb
```

Output files:

- `private_key.pem`
- `public_key.pem`

## Project Notes

- There is no `Gemfile`, lockfile, or automated setup.
- There are no tests.
- Some scripts are clearly experimental and may need cleanup before production use.
- The repository currently targets direct execution rather than packaging or reuse as a library.

## Review Highlights

During review, a few issues stood out:

- `socket_server.rb` contains a broken `quit` branch that can terminate the server unexpectedly.
- `create` includes placeholder database credentials and hardcoded password handling.
- `create` and the geocoding scripts depend on gems that are not declared in a Bundler setup.
- The existing scripts mix proof-of-concept code and utility code, so behavior should be validated before deployment.

## License

No license file is included in this repository.
