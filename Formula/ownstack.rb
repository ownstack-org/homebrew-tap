class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.7.11.1"

  on_macos do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.7.11.1.tar.gz"
      sha256 "a4e59f5664ae768998477e84384ed02aa644efa2eb38895e933fb88c287f2e87"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.7.11.1.tar.gz"
      sha256 "a4e59f5664ae768998477e84384ed02aa644efa2eb38895e933fb88c287f2e87"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.7.11.1.tar.gz"
      sha256 "a4e59f5664ae768998477e84384ed02aa644efa2eb38895e933fb88c287f2e87"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.7.11.1.tar.gz"
      sha256 "a4e59f5664ae768998477e84384ed02aa644efa2eb38895e933fb88c287f2e87"
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
