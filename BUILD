load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "lib",
    srcs = [
        "lib.cc",
        "lib.h",
    ],
)

cc_binary(
    name = "app",
    srcs = [
        "app.cc",
    ],
    deps = ["lib"],
)
