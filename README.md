# Demo of using Starlark Build Flags with Starlark Aspects

[Starlark Aspects](https://docs.bazel.build/versions/main/skylark/aspects.html) can use
[Starlark Build
Settings](https://docs.bazel.build/versions/main/skylark/config.html#user-defined-build-settings)
to configure themselves.

This repo takes the example aspect from
[bazelbuild/examples/rules/aspect](https://github.com/bazelbuild/examples/blob/main/rules/aspect),
updates it to be useful at the top level, and adds a command-line flag for
configuration.

Sample:
```
$ bazel build //:app --//file_collector:extensions=h,cc --aspects=//file_collector:defs.bzl%collector
DEBUG: /usr/local/google/home/jcater/repos/aspect-flag/file_collector/defs.bzl:30:10: depset([<source file lib.cc>, <source file lib.h>])
DEBUG: /usr/local/google/home/jcater/repos/aspect-flag/file_collector/defs.bzl:30:10: depset([<source file lib.cc>, <source file lib.h>, <source file app.cc>])
INFO: Analyzed target //:app (32 packages loaded, 139 targets configured).
INFO: Found 1 target...
Aspect //file_collector:defs.bzl%collector of //:app up-to-date (nothing to build)
INFO: Elapsed time: 0.528s, Critical Path: 0.01s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
```

