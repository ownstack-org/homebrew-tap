# OwnStack Homebrew tap

Install the [OwnStack](https://ownstack.org) CLI via Homebrew (macOS / Linux):

```sh
brew install ownstack-org/tap/ownstack
```

This installs the compiled Go CLI (no toolchain, no source). After install:

```sh
ownstack login        # authenticate
ownstack whatami      # full command reference
```

The formula ships per-platform binaries from `s3://ownstack-cli` (the same
source-protected release artifacts the `curl … | bash` installer uses). To
upgrade, `brew upgrade ownstack`.

> Maintainers: bump `version` + the four `url`/`sha256` pairs in
> `Formula/ownstack.rb` on each CLI release (the `ownstack-cli-go-<os>-<arch>-<sha>.tar.gz`
> artifacts and their checksums are produced by the CLI repo's `release.sh`).
