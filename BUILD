load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load(":file_collector.bzl", "file_collector_extensions_setting")

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

file_collector_extensions_setting(
    name = "extensions",
    build_setting_default = [],
)
