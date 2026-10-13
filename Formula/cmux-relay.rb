class CmuxRelay < Formula
  desc "Connects the cmux Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/cmux-android"
  version "0.1.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/cmux-android/releases/download/0.1.0/cmux-relay-0.1.0-darwin-arm64.tar.gz"
    sha256 "f791fbc8deb00c24f4ce236c3f82a5bbd400feca54288a5709f9fff168dcfd12"
  else
    url "https://github.com/gantoine/cmux-android/releases/download/0.1.0/cmux-relay-0.1.0-darwin-amd64.tar.gz"
    sha256 "4b02db6b6d5b851befa7caecd1cbec112519c9a84004b00e11d0f68d6adfd3cb"
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
