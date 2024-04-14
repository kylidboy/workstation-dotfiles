;;; lang/solidity/config.el -*- lexical-binding: t; -*-

(defun wake-lsp-command (port)
  (list "wake" "lsp" "--port" port))

(defun solidity-lsp-command (_a1)
  (list "nomicfoundation-solidity-language-server" "--stdio"))

(use-package! solidity-mode
  :config
  (after! projectile
    (add-to-list 'projectile-project-root-files "foundry.toml"))
  (setq solidity-comment-style 'slash)
  (set-docsets! 'solidity-mode "Solidity")
  (when (modulep! +forge-fmt)
    (set-formatter! 'forge-fmt '("forge" "fmt" "-r" "-") :modes '(solidity-mode))
    )
  (when (and (modulep! +lsp) (modulep! :tools lsp))
    (add-hook 'solidity-mode-hook #'lsp!))
  (setq-hook! 'solidity-mode-hook
    +format-with-lsp nil)
  (when (and (modulep! +tree-sitter) (modulep! :tools tree-sitter))
    (add-hook 'solidity-mode-hook #'tree-sitter!)))

(after! eglot
  ;; (add-to-list 'eglot-server-programs '(solidity-mode . ("wake" "--debug" "lsp" "--port" :autoport)))
  ;; (add-hook 'solidity-mode-hook #'lsp!)
  (add-to-list 'eglot-server-programs '(solidity-mode . solidity-lsp-command)))
