class Yarp < Formula
  desc "Yet Another Robot Platform"
  homepage "http://yarp.it"
  url "https://github.com/robotology/yarp/archive/v2.3.63.tar.gz"
  sha256 "1ee3b237b8700f55deaaae9be46015bfb6d454135ab99d096d269cea6e3d7d3e"
  head "https://github.com/robotology/yarp.git"
  revision 1

  option "without-shared", "Build only static version of YARP libraries"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "ace"
  depends_on "gsl"
  depends_on "gtk+"
  depends_on "gtkmm"
  depends_on "libglademm"
  depends_on "sqlite"
  depends_on "readline"
  depends_on "jpeg"

  def install
    args = std_cmake_args +
           %W[
             -DCREATE_LIB_MATH=TRUE
             -DCREATE_GUIS=TRUE
             -DCREATE_YMANAGER=TRUE
             -DYARP_USE_SYSTEM_SQLITE=TRUE
             -DCREATE_OPTIONAL_CARRIERS=TRUE
             -DENABLE_yarpcar_mjpeg_carrier=TRUE
             -DENABLE_yarpcar_rossrv_carrier=TRUE
             -DENABLE_yarpcar_tcpros_carrier=TRUE
             -DENABLE_yarpcar_xmlrpc_carrier=TRUE
             -DENABLE_yarpcar_bayer_carrier=TRUE
             -DUSE_LIBDC1394=FALSE
             -DENABLE_yarpcar_priority_carrier=TRUE
             -DCREATE_IDLS=TRUE
             -DENABLE_yarpidl_thrift=TRUE
             -DCREATE_YARPVIEW=TRUE
             -DCREATE_YARPSCOPE=TRUE
             -DCREATE_GYARPMANAGER=TRUE
           ]

    if build.without? "shared"
      args << "-DCREATE_SHARED_LIBRARY:BOOL=FALSE"
    else
      args << "-DCREATE_SHARED_LIBRARY:BOOL=TRUE"
    end
    args << "."

    system "cmake", *args
    system "make", "install"
  end

  test do
    system "#{bin}/yarp", "check"
  end
end
