"""Example of using an aspect to collect information from dependencies.

For more information about aspects, see the documentation:
  https://docs.bazel.build/versions/master/skylark/aspects.html
"""

FileCollector = provider(
    fields = {"files": "collected files"},
)

def _file_collector_aspect_impl(target, ctx):
    # This function is executed for each dependency the aspect visits.

    # Collect files from the srcs
    direct = [
        f
        for f in ctx.rule.files.srcs
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
    },
    implementation = _file_collector_aspect_impl,
)
