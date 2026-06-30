class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.6.30"

  on_macos do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-4842dcf.tar.gz"
      sha256 "fd8627c560699291471254006f85687ad0c92796021be3140caf68d8525edf03"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-4842dcf.tar.gz"
      sha256 "00ce706c939f691d7a0ffc0d5c4b360f4e1097c06336559234abc056b3c22301"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-4842dcf.tar.gz"
      sha256 "65af41fdf6bcc8f6115f25f6fc024723691255b87b4b35df5a634ecb06a9b7db"
    end
    on_intel do
      url "https://ownstack-cli.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-4842dcf.tar.gz"
      sha256 "b61e2cdf036bff5e1ae0d773994e4727e96fa0c7bfe0199d6f597d81e0a1d2dd"
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
    assert_match "OwnStack", shell_output("#{bin}/ownstack --help")
    assert_match "rails", shell_output("#{bin}/ownstack list")
  end
end
