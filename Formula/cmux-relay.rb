class CmuxRelay < Formula
  desc "Connects the cmux Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/cmux-android"
  version "0.2.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/cmux-android/releases/download/0.2.0/cmux-relay-0.2.0-darwin-arm64.tar.gz"
    sha256 "534b5cf891c4660ae9818d054dd1e726a5a143ceb6741409f441ca503790b16a"
  else
    url "https://github.com/gantoine/cmux-android/releases/download/0.2.0/cmux-relay-0.2.0-darwin-amd64.tar.gz"
    sha256 "22dd02cad65f505a33f8199bc139a5873779c9d4019712dda7621412402b2760"
  end

  depends_on :macos

  def install
    bin.install "cmux-relay"
  end

  def caveats
    <<~EOS
      Set up the relay:
        cmux-relay install
        tailscale serve --bg --https=8765 http://127.0.0.1:8765
        cmux-relay doctor
        cmux-relay pair

      After upgrading, run `cmux-relay install` again to restart the relay on the new version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/cmux-relay version").strip
  end
end
