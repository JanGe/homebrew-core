require "language/go"

class Rclone < Formula
  desc "rsync for cloud storage"
  homepage "http://rclone.org"
  url "https://github.com/ncw/rclone/archive/v1.32.tar.gz"
  sha256 "9b29478188f183a33252e00a2bb63eb21d6f9dc415fbdaa0865a31a524147466"

  depends_on "go" => :build

  go_resource "golang.org/x/oauth2" do
    url "https://go.googlesource.com/oauth2.git",
     :revision => "1364adb2c63445016c5ed4518fc71f6a3cda6169"
  end

  go_resource "golang.org/x/net" do
    url "https://go.googlesource.com/net.git",
      :revision => "6a513affb38dc9788b449d59ffed099b8de18fa0"
  end

  go_resource "golang.org/x/tools" do
    url "https://go.googlesource.com/tools.git",
      :revision => "9e7459099f9afd6a15464d69d93c6eed49bb545d"
  end

  go_resource "google.golang.org/api" do
    url "https://code.googlesource.com/google-api-go-client.git",
      :revision => "fa0566afd4c8fdae644725fdf9b57b5851a20742"
  end

  go_resource "google.golang.org/cloud" do
    url "https://code.googlesource.com/gocloud.git",
      :revision => "30fab6304c9888af49f1884cf4eddad7027e2e7b"
  end

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git",
      :revision => "bc89c496413265e715159bdc8478ee9a92fdc265"
  end

  go_resource "golang.org/x/text" do
    url "https://go.googlesource.com/text.git",
      :revision => "2910a502d2bf9e43193af9d68ca516529614eed3"
  end

  go_resource "github.com/kisielk/errcheck" do
    url "https://github.com/kisielk/errcheck.git",
     :revision => "50ffcb6f3595daac70aff9e63afe8b8b277b1a1a"
  end

  go_resource "github.com/golang/lint" do
    url "https://github.com/golang/lint.git",
      :revision => "c7bacac2b21ca01afa1dee0acf64df3ce047c28f"
  end

  go_resource "github.com/tsenart/tb" do
    url "https://github.com/tsenart/tb.git",
      :revision => "19f4c3d79d2bd67d0911b2e310b999eeea4454c1"
  end

  go_resource "github.com/stacktic/dropbox" do
    url "https://github.com/stacktic/dropbox.git",
      :revision => "58f839b21094d5e0af7caf613599830589233d20"
  end

  go_resource "github.com/spf13/pflag" do
    url "https://github.com/spf13/pflag.git",
      :revision => "1560c1005499d61b80f865c04d39ca7505bf7f0b"
  end

  go_resource "github.com/skratchdot/open-golang" do
    url "https://github.com/skratchdot/open-golang.git",
      :revision => "75fb7ed4208cf72d323d7d02fd1a5964a7a9073c"
  end

  go_resource "github.com/Unknwon/goconfig" do
    url "https://github.com/Unknwon/goconfig.git",
      :revision => "5f601ca6ef4d5cea8d52be2f8b3a420ee4b574a5"
  end

  go_resource "github.com/VividCortex/ewma" do
    url "https://github.com/VividCortex/ewma.git",
      :revision => "8b9f1311551e712ea8a06b494238b8a2351e1c33"
  end

  go_resource "github.com/aws/aws-sdk-go" do
    url "https://github.com/aws/aws-sdk-go.git",
      :revision => "3b8c171554fc7d4fc53b87e25d4926a9e7495c2e"
  end

  go_resource "github.com/mreiferson/go-httpclient" do
    url "https://github.com/mreiferson/go-httpclient.git",
      :revision => "31f0106b4474f14bc441575c19d3a5fa21aa1f6c"
  end

  go_resource "github.com/ncw/go-acd" do
    url "https://github.com/ncw/go-acd.git",
      :revision => "0bd73ce86fffd8afeafe4e46f419f1a8ce6324b9"
  end

  go_resource "github.com/ncw/swift" do
    url "https://github.com/ncw/swift.git",
      :revision => "b964f2ca856aac39885e258ad25aec08d5f64ee6"
  end

  go_resource "github.com/pkg/errors" do
    url "https://github.com/pkg/errors.git",
      :revision => "1d2e60385a13aaa66134984235061c2f9302520e"
  end

  go_resource "github.com/google/go-querystring" do
    url "https://github.com/google/go-querystring.git",
      :revision => "9235644dd9e52eeae6fa48efd539fdc351a0af53"
  end

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/ncw/"
    ln_s buildpath, buildpath/"src/github.com/ncw/rclone"
    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", bin/"rclone"
  end

  test do
    (testpath/"file1.txt").write "Test!"
    system "#{bin}/rclone", "copy", testpath/"file1.txt", testpath/"dist"
    assert_match File.read(testpath/"file1.txt"), File.read(testpath/"dist/file1.txt")
  end
end