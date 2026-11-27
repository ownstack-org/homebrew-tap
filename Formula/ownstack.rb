class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.11.27.1"

  depends_on "yq"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.11.27.1.tar.gz"
      sha256 "3064bbffc885147fc2afe67e749f6a205a88135a571b1fdc11c0796079d9b444"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.11.27.1.tar.gz"
      sha256 "fc252f12e7a6c5429ea538844dec2974525936466a529aa1c0d628ba920c1d57"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.11.27.1.tar.gz"
      sha256 "42837a60b82a3b4b69d6ec36683cea659bbdc1800f5f39ae362984b4a6f6051a"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.11.27.1.tar.gz"
      sha256 "72111ed47558113a2bcaae5987753fa7c2127c1e81cf1569fbe55b01a187d612"
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
