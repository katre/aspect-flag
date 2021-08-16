"""Example of using an aspect to collect information from dependencies.

For more information about aspects, see the documentation:
  https://docs.bazel.build/versions/master/skylark/aspects.html
"""

FileCollector = provider(
    fields = {"files": "collected files"},
)

def _file_collector_aspect_impl(target, ctx):
    # This function is executed for each dependency the aspect visits.
    extensions = ctx.attr._extensions[_ExtensionsProvider].extensions

    # Collect files from the srcs
    direct = [
        f
        for f in ctx.rule.files.srcs
        if len(extensions) == 0 or f.extension in extensions
    ]

    # Combine direct files with the files from the dependencies.
    files = depset(
        direct = direct,
        transitive = [dep[FileCollector].files for dep in ctx.rule.attr.deps],
    )

    print(files)
    return [FileCollector(files = files)]

file_collector = aspect(
    attr_aspects = ["deps"],
    attrs = {
        "_extensions": attr.label(default = ":extensions"),
    },
    implementation = _file_collector_aspect_impl,
)

_ExtensionsProvider = provider(fields = ["extensions"])

def _file_collector_extensions_impl(ctx):
    extensions = ctx.build_setting_value
    return _ExtensionsProvider(extensions = extensions)

file_collector_extensions_setting = rule(
    implementation = _file_collector_extensions_impl,
    build_setting = config.string_list(flag = True),
)
