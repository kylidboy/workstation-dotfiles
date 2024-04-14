;;; lang/solidity/doctor.el -*- lexical-binding: t; -*-

(when (and (modulep! +lsp)
           (not (executable-find "nomicfoundation-solidity-language-server")))
  (warn! "Couldn't find nomicfoundation-solidity-language-server."))
