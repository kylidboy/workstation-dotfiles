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
    (set-formatter! 'forge-fmt '("forge" "fmt" "-r" "-") :modes '(solidity-mode)))
  (setq-hook! 'solidity-mode-hook
    +format-with-lsp nil)
  (when (and (modulep! +tree-sitter) (modulep! :tools tree-sitter))
    (add-hook 'solidity-mode-hook #'tree-sitter!))

  (if (and (modulep! +lsp) (modulep! :tools lsp))
      (progn
        (after! eglot
          ;; (add-to-list 'eglot-server-programs '(solidity-mode . ("wake" "--debug" "lsp" "--port" :autoport)))
          (add-to-list 'eglot-server-programs '(solidity-mode . solidity-lsp-command)))
        (add-hook 'solidity-mode-hook #'lsp!))
    (progn
      (set-company-backend! 'solidity-mode 'company-solidity)
      (set-formatter! 'prettier-solidity '(npx "prettier" "--stdin-filepath" filepath "--parser=solidity") :modes '(solidity-mode))
      (use-package! solidity-flycheck  ; included with solidity-mode
        :when (and (modulep! :checkers syntax)
                   (not (modulep! :checkers syntax +flymake)))
        :config
        (setq flycheck-solidity-solc-addstd-contracts t)
        (when (funcall flycheck-executable-find solidity-solc-path)
          (add-to-list 'flycheck-checkers 'solidity-checker nil #'eq))
        (when (funcall flycheck-executable-find solidity-solium-path)
          (add-to-list 'flycheck-checkers 'solium-checker nil #'eq)))
      (use-package! company-solidity
        :when (modulep! :completion company)
        :config (delq! 'company-solidity company-backends)))))
