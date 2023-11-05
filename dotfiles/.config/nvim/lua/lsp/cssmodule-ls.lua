return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss"
  },
  on_attach = function(client)
    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
    -- custom_on_attach(client)
  end
}
