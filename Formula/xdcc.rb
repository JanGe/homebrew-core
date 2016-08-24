require "language/haskell"

class Xdcc < Formula
  include Language::Haskell::Cabal

  desc "Wget-like utility for retrieving files from XDCC bots on IRC"
  homepage "https://github.com/JanGe/xdcc"
  url "https://hackage.haskell.org/package/xdcc-1.1.2/xdcc-1.1.2.tar.gz"
  sha256 "d3268b0e1ffc28dabd33ffdc8c5f2e632b114002b5b3cc1d6836faa2d640b35d"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build

  def install
    install_cabal_package
  end

  test do
    system "#{bin}/xdcc", "--help"
  end
end
