return {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--clang-tidy-checks=clang-analyzer-*,cppcoreguidelines-interfaces-global-init,cppcoreguidelines-narrowing-conversions,cppcoreguidelines-pro-type-member-init,cppcoreguidelines-pro-type-static-cast-downcast,cppcoreguidelines-slicing,google-default-arguments,google-explicit-constructor,google-runtime-operator,hicpp-exception-baseclass,hicpp-multiway-paths-covered,modernize-avoid-bind,modernize-concat-nested-namespaces,modernize-deprecated-headers,modernize-deprecated-ios-base-aliases,modernize-loop-convert,modernize-make-shared,modernize-make-unique,modernize-pass-by-value,modernize-raw-string-literal,modernize-redundant-void-arg,modernize-replace-auto-ptr,modernize-replace-disallow-copy-and-assign-macro,modernize-replace-random-shuffle,modernize-return-braced-init-list,modernize-shrink-to-fit,modernize-unary-static-assert,modernize-use-auto,modernize-use-bool-literals,modernize-use-emplace,modernize-use-equals-default,modernize-use-equals-delete,modernize-use-nodiscard,modernize-use-noexcept,modernize-use-nullptr,modernize-use-override,modernize-use-transparent-functors,modernize-use-uncaught-exceptions,misc-*,bugprone-*,performance-*,readability-*"
  },
  filetypes = {"c", "cpp", "h", "hpp", "cxx", "tpp", "objc", "objcpp"},
  init_option = {fallbackFlags = {"--std=c++20"}}
}