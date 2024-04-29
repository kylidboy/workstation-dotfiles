;;; lang/solidity/config.el -*- lexical-binding: t; -*-

(defun wake-lsp-command (port)
  (list "wake" "--debug" "lsp" "--port" port))

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
  (when (and (modulep! +lsp) (modulep! :tools lsp))
    (add-hook 'solidity-mode-hook #'lsp!)
    (setq-hook! 'solidity-mode-hook +format-with-lsp nil))
  (when (and (modulep! +tree-sitter) (modulep! :tools tree-sitter))
    (add-hook 'solidity-mode-hook #'tree-sitter!)))

;; The newest lsp-mode has already got Solidity covered.
;;
;; (after! lsp-mode
;;   (lsp-register-client (make-lsp-client
;;                         :language-id 'solidity
;;                         :add-on? t
;;                         :new-connection (lsp-tcp-connection #'wake-lsp-command)
;;                         :activation-fn (lsp-activate-on "solidity" "sol")
;;                         :priority 1000
;;                         :server-id 'solidity-wake
;;                         :library-folders-fn (lambda (_workspace) '("/lib/" "/node_module/"))
;;                         )))

(after! eglot
  ;; (add-to-list 'eglot-server-programs '(solidity-mode . wake-lsp-command))
  (add-to-list 'eglot-server-programs '(solidity-mode . solidity-lsp-command)))
