class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.3.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.3.0/muxer-0.3.0-darwin-arm64.tar.gz"
    sha256 "a2459f5cf4e094166bfcc493635b9ae4f1fcee3e51aafddc5dcc11014113e6aa"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.3.0/muxer-0.3.0-darwin-amd64.tar.gz"
    sha256 "bfa1e730316f8eaa642f7766c1843dc14ecd4db4edd070ed80e1290a9e277fde"
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
