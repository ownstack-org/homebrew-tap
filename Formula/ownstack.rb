class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.7.9.1"

  on_macos do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.7.9.1.tar.gz"
      sha256 "6c89683fc44a7e33691a8129316d493f63f31e043116a90a11b5c63d5f24a534"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.7.9.1.tar.gz"
      sha256 "1ab2bbf6f86140b527200ef36835f108856431bb8bb591d2914007645a894733"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.7.9.1.tar.gz"
      sha256 "31abb8d1ba70f44ac8554dcf2d7e2d9f2b93f1e81ab8ef85fa664cb6390fe82e"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.7.9.1.tar.gz"
      sha256 "72006b6f266816bc388986e6d16c4db8eab2608a5b5db26851ac3c12c902d71e"
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
