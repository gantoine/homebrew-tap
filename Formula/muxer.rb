class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.3.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.3.1/muxer-0.3.1-darwin-arm64.tar.gz"
    sha256 "cdc1ba0ea8a5c2ccb667d5fdb2303129b766a386b047c79ba7c9ad6f823e3623"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.3.1/muxer-0.3.1-darwin-amd64.tar.gz"
    sha256 "30907202da5ce28a4c14c596c7cba1426dee3a83502bd128b3469f1daf8232f9"
  end

  depends_on :macos

  def install
    bin.install "muxer"
  end

  def caveats
    <<~EOS
      Set up the relay:
        muxer install
        tailscale serve --bg --https=8765 http://127.0.0.1:8765
        muxer doctor
        muxer pair

      After upgrading, run `muxer install` again to restart the relay on the new version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/muxer version").strip
  end
end
