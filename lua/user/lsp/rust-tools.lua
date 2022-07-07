local handler = require("user.lsp.handlers")
require("rust-tools").setup({ server = { on_attach = handler.on_attach } })
