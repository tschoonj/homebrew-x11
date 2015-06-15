class Prooftree < Formula
  desc "A program for proof-tree visualization"
  homepage "http://askra.de/software/prooftree"
  url "http://askra.de/software/prooftree/releases/prooftree-0.12.tar.gz"
  sha256 "952ca2efec290808ffac093abe7ac9b10ae471f5d8cd9ef66db3dd02a431d723"

  bottle do
    cellar :any
    sha1 "686cb57124632efd5dcc72b9b3821c64c105ffd4" => :mavericks
    sha1 "c4707a4ddd9da81e2527ba693de96f47340e1307" => :mountain_lion
    sha1 "ebabfe1c7299976f037adfae5d2b90fb4878b186" => :lion
  end

  depends_on "lablgtk"

  # these changes in the comments were necessary to get things compiling.
  # did not manage to contact the authors regarding this.
  patch :DATA

  def install
    system "./configure", "--prefix", prefix
    system "make", "-j1"
    system "make", "install"
  end

  test do
    # I have no idea how this program works.
    # it seems to read from stdin but I don't know which format it expects
    system "#{bin}/prooftree", "-help"
  end
end
__END__
diff --git a/input.ml b/input.ml
index 934943c..ed4aa9a 100644
--- a/input.ml
+++ b/input.ml
@@ -27,7 +27,7 @@
 
 (*****************************************************************************
  *****************************************************************************)
-(** {2 Communition Protocol with Proof General}
+(* {2 Communition Protocol with Proof General}
 
     The communication protocol with Proof General is almost one-way
     only: Proof General sends display messages to Prooftree and
@@ -55,7 +55,7 @@
 
     In the following list 
     of commands, ``%d'' stands for a positive integer and %s for a string
-    which contains no white space. ``\{cheated|not-cheated\}'' denotes
+    which contains no white space. ``cheated|not-cheated'' denotes
     the alternative of either ``cheated'' or ``not-cheated''. An
     integer following the keyword state is a state number. An integer
     following some xxx-bytes denotes the number of bytes of the next
@@ -79,7 +79,7 @@
     the first message. 
     }
     {-  {v current-goals state %d current-sequent %s \
-    {cheated|not-cheated} {new-layer|current-layer} proof-name-bytes %d \
+    cheated|not-cheated {new-layer|current-layer} proof-name-bytes %d \
      command-bytes %d sequent-text-bytes %d additional-id-bytes %d \
      existential-bytes %d\n\
     <data-proof-name>\n\
@@ -162,7 +162,7 @@
     {- Full name of the proof}
     }
     }
-    {- {v branch-finished state %d {cheated|not-cheated} \
+    {- {v branch-finished state %d cheated|not-cheated \
     proof-name-bytes %d command-bytes %d existential-bytes %d\n\
     <data-proof-name>\n\
     <data-command>\n\
@@ -440,7 +440,7 @@ let parse_configure com_buf =
 
 (******************************************************************************
  ******************************************************************************
- * current-goals state %d current-sequent %s {cheated|not-cheated} \
+ * current-goals state %d current-sequent %s cheated|not-cheated \
  * {new-layer|current-layer}
  * proof-name-bytes %d command-bytes %d sequent-text-bytes %d \
  * additional-id-bytes %d existential-bytes %d\n\
@@ -625,7 +625,7 @@ let parse_switch_goal com_buf =
 
 
 (******************************************************************************
- * branch-finished state %d {cheated|not-cheated} \
+ * branch-finished state %d cheated|not-cheated \
  * proof-name-bytes %d command-bytes %d existential-bytes %d\n\
  * <data-proof-name>\n\
  * <data-command>\n\

