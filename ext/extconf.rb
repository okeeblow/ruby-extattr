#!ruby
#vim: set fileencoding:utf-8

raise "require ruby-1.9.3+" unless RUBY_VERSION >= "1.9.3"

require "mkmf"

#$CFLAGS << " -std=c99"

case
when have_header("sys/extattr.h")

when have_header("attr/xattr.h")
  $CPPFLAGS << " -DLINUX_XATTR_H=\\<attr/xattr.h\\>"

when have_header("sys/xattr.h")
  $CPPFLAGS << " -DLINUX_XATTR_H=\\<sys/xattr.h\\>"

when have_header("winnt.h") && have_header("ntdef.h") && have_header("psapi.h") &&
     have_header("ddk/ntifs.h") && have_header("ddk/winddk.h") &&
     have_library("ntoskrnl") && have_library("ntdll") && have_library("psapi")

else
  $stderr.puts <<EOM
#$0: not supported target.
\tmust be available either ddk/ntifs.h, sys/extattr.h or attr/xattr.h on your system.
EOM
  exit 1
end

#$CFLAGS << " -std=c99"

create_makefile "extattr"
