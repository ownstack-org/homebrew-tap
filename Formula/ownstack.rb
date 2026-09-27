class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.9.26.1"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.9.26.1.tar.gz"
      sha256 "c8238a42b0b317cf8fe89ad046e616f3246b90203e8ad164e02daae9838d600d"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.9.26.1.tar.gz"
      sha256 "2b68f050b9bcfd7510183f79fbdcd3066440c1dc1d84ccba64c5f726360c6890"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.9.26.1.tar.gz"
      sha256 "42b587e5b6048d87fbbf4bbc983f75f96c1c77f35ef98ff008fe41473d711933"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.9.26.1.tar.gz"
      sha256 "d5c4cf150e3df4672a9bfa2c1c0e3b8b59a51c4345a2b13194ae899a5a5f251b"
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
