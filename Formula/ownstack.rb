class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.8.6.2"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.8.6.2.tar.gz"
      sha256 "11e24281a1c610802fc025887f5244697a9102144a55843f340f243d95c6b118"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.8.6.2.tar.gz"
      sha256 "677c94ec7f0becf89f8c75dac5d6d8a9143ca0a0de6e3d9c74938245ed2cdad5"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.8.6.2.tar.gz"
      sha256 "eedffb339535f208ab4cc534d9c48d9a730a6bbc1b525bc9de9c86cb694d2024"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.8.6.2.tar.gz"
      sha256 "0ac6ee39b80d190651206c231a30f607c82bceeb8a010f832afc1747e7363a6b"
    end
  end

  def install
    # Tarball expands to cli/{bin,templates,completions,docs.yml}; Homebrew
    # strips the single top-level dir, so the contents land at the staging
    # root. Handle both layouts. Install the whole layout under libexec so the
    # binary finds templates/docs.yml by walking up from its own location.
    libexec.install(Dir["cli"].any? ? Dir["cli/*"] : Dir["*"])
    bin.install_symlink libexec/"bin/ownstack"

    if (libexec/"completions/ownstack.bash").exist?
      bash_completion.install libexec/"completions/ownstack.bash" => "ownstack"
    end
    if (libexec/"completions/_ownstack").exist?
      zsh_completion.install libexec/"completions/_ownstack"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ownstack --version")
    assert_match "OwnStack", shell_output("#{bin}/ownstack --help")
    assert_match "rails", shell_output("#{bin}/ownstack list")
  end
end
