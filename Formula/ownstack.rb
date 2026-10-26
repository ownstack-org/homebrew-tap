class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.10.25.3"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.10.25.3.tar.gz"
      sha256 "9c0abe7e647c435f7561a904d930752c2de4587f2cba315130d59a27a6e5bb74"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.10.25.3.tar.gz"
      sha256 "3cda39dd3809d23f38a4f59d589f5f81403c9d833ac8659ee590b878901f831b"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.10.25.3.tar.gz"
      sha256 "c00de148242735d2d8d9643293f3f6ddb7bd589029fb8c89de53c1e3861836fe"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.10.25.3.tar.gz"
      sha256 "a1e7a9c7afa7d17a6bb74467f80f855d64ea8537db4451e83165f2158546ab0d"
    end
  end

  def install
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
