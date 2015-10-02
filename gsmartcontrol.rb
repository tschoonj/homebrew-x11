class Gsmartcontrol < Formula
  desc "A graphical user interface for smartctl"
  homepage "http://gsmartcontrol.sourceforge.net/home/index.php"
  url "https://downloads.sourceforge.net/project/gsmartcontrol/0.8.7/gsmartcontrol-0.8.7.tar.bz2"
  sha256 "708fa803243abb852ed52050fc82cd3592a798c02743342441996e77f19ffec6"
  revision 2

  bottle do
    sha256 "655cb81fca643ef4e8f0a049f528a03418f1592c78d3a190e5225dffb4ba6860" => :yosemite
    sha256 "a5bc7d15d727ac081d84dd230175600b575f7ac233bc9b01d1660a3aff18aaef" => :mavericks
    sha256 "0b98ddcecf9e9c300f6fa94306fe332215bd74bfce2786111e468fbd7d9f34f6" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "smartmontools"
  depends_on "gtkmm"
  depends_on "pcre"

  needs :cxx11

  # Fix bad includes with gtkmm-2.24.3
  # Check if this is still needed with new versions of gsmartcontrol and gtkmm
  patch :DATA

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/gsmartcontrol", "--version"
  end
end

__END__
diff --git a/src/applib/cmdex_sync_gui.cpp b/src/applib/cmdex_sync_gui.cpp
index d253a17..83b2e11 100644
--- a/src/applib/cmdex_sync_gui.cpp
+++ b/src/applib/cmdex_sync_gui.cpp
@@ -9,6 +9,7 @@
 /// \weakgroup applib
 /// @{

+#include <glibmm.h>
 #include <gtkmm/main.h>  // Gtk::Main

 #include "hz/fs_path.h"
diff --git a/src/gsc_init.cpp b/src/gsc_init.cpp
index 0ded7bc..6fb1bb7 100644
--- a/src/gsc_init.cpp
+++ b/src/gsc_init.cpp
@@ -15,6 +15,7 @@
 #include <cstdio>  // std::printf
 #include <vector>
 #include <sstream>
+#include <glibmm.h>
 #include <gtkmm/main.h>
 #include <gtkmm/messagedialog.h>
 #include <gtk/gtk.h>  // gtk_window_set_default_icon_name, gtk_icon_theme_*
