class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.9.30.1"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.9.30.1.tar.gz"
      sha256 "cca86834f93263dad1425122e9d0daa33701a42a07d8d93e60769d1efd398166"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.9.30.1.tar.gz"
      sha256 "618ce359d16f32a200df43a539d501f6a9327f14a7f8c7a5da4170f69de66ae8"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.9.30.1.tar.gz"
      sha256 "58a88311176a630d5acd1c048a779021706903d2bc0dc7ddcda3fdd2f5e253d0"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.9.30.1.tar.gz"
      sha256 "5d6259ad3d7182a9370813c5d7652ebdba68042151c68975bba7c50251c5e763"
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
