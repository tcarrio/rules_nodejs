"Shows how you might create a macro for the autogenerated Jest rule"

load("@npm//jest-cli:index.bzl", _jest_test = "jest_test")

def jest_test(name, srcs, deps, jest_config, **kwargs):
    "A macro around the autogenerated jest_test rule"
    templated_args = [
        "--no-cache",
        "--no-watchman",
        "--ci",
        "--colors",
    ]
    templated_args.extend(["--config", "$(rootpath %s)" % jest_config])
    for src in srcs:
        templated_args.extend(["--runTestsByPath", "$(rootpath %s)" % src])

    data = [jest_config] + srcs + deps
    _jest_test(
        name = name,
        data = data,
        templated_args = templated_args,
        **kwargs
    )
