class Ownstack < Formula
  desc "Heroku-style ergonomics on infrastructure you own (OwnStack control-plane CLI)"
  homepage "https://ownstack.org"
  version "2026.8.21.1"

  on_macos do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-arm64-2026.8.21.1.tar.gz"
      sha256 "2b9f981426b98162ac8a92e21ffcdf68f49ead88cf82dbfb78424ded6568f705"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-darwin-amd64-2026.8.21.1.tar.gz"
      sha256 "fd8ec192cfc9b8a322930557727fab1cd41ac06940d2569471ad874ae1c68d7b"
    end
  end

  on_linux do
    on_arm do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-arm64-2026.8.21.1.tar.gz"
      sha256 "8f8ad4a532880f25d301eb21093a0348c49347da415185e3ff186886f0c2419e"
    end
    on_intel do
      url "https://ownstack-cli-releases.s3.us-west-2.amazonaws.com/ownstack-cli-go-linux-amd64-2026.8.21.1.tar.gz"
      sha256 "bea034f74a413e979b1e793c4f718f7a11b206654deb9de7c67aaa1530a675ba"
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
