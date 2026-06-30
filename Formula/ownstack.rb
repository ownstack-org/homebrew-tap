class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.6.30.2"

  on_macos do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.6.30.2.tar.gz"
      sha256 "dcec04b0a123f15c4f226e08313fd3e585832d860fc13d28e011d389ebe6da34"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.6.30.2.tar.gz"
      sha256 "047cee87650efaaaf72bd5a550b06cd8b3bf4dded12bc3dd4316fed03a4f44b9"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.6.30.2.tar.gz"
      sha256 "b2ee6fbe3d93a71144cc8cdbea59babc808bc211b1d9e1f45b5875af18358b1a"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.6.30.2.tar.gz"
      sha256 "0126f7e2d3aa20f5522d589cfc119240c7a8835fd561ae2365331f392b4fa79d"
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
