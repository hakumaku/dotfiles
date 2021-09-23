return {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--header-insertion=iwyu",
    "--inlay-hints",
    "--clang-tidy"
  },
  filetypes = {"c", "cpp", "h", "hpp", "cxx", "tpp", "objc", "objcpp"},
  init_option = {fallbackFlags = {"--std=c++20"}}
}
