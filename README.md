# spg: master password, in bash

Using the same password for multiple accounts is very **unsafe**. If one of
those sites gets compromised, every account that shares the password is
exposed, which can lead to identity theft.

The idea is to memorise one reasonably long, secure **master password** and
derive a distinct, non-dictionary password for each site from it. Nothing is
stored and nothing leaves your machine.

This is the command-line version of [pass.luc.sh](https://pass.luc.sh)
([source](https://github.com/lucsh/master-password)) and produces the same
passwords for the same inputs.

## Usage

```sh
./spg.sh -s admin@service-environment
```

You are prompted for the master password (input is hidden), and the result
goes to your clipboard (`pbcopy`, `wl-copy`, `xclip`, `xsel` or `clip.exe`).
If no clipboard is available, the password is printed highlighted
white-on-white: select it to read it.

| Option | Meaning |
| --- | --- |
| `-s, --seed SEED` | seed, e.g. `admin@service-environment` |
| `-p, --pass PASS` | master password (avoid: it ends up in shell history and `ps`) |
| `-l, --length N` | length, 1–64 (default 15) |
| `-c, --no-caps` | no uppercase section |
| `-e, --no-symbols` | no symbols |
| `-o, --stdout` | print the password instead of copying it |
| `-z, --header` | show the banner |
| `-h, --help` | help |

Requirements: bash 3.2+ (the macOS default works), `iconv`, and one of
`sha256sum`, `shasum` or `openssl`.

## Tests

```sh
tests/compat.sh   # requires jq
```

`tests/password-fixtures.json` is a verbatim copy of the website's
compatibility fixtures. The algorithm deliberately reproduces the website's
legacy quirks, so never change expected values to make a test pass: any
algorithm change has to be versioned on the website first.
