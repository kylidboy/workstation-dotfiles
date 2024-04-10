;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kyli Bing"
      user-mail-address "kylidboy@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Mono" :size 23 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 23))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'doom-city-lights)
;; (setq doom-theme 'doom-nord-aurora)
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'macchiato) ;; or 'frappe, 'latte, or 'mocha

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(use-package! org-modern
  :config
  (progn
    (add-hook 'org-mode-hook #'org-modern-mode)
    (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! yul-mode
  :hook (yul-mode . lsp!))

(after! eglot
  (add-to-list 'eglot-server-programs
               '(toml-mode . ("taplo" "lsp" "stdio"))
               '(solidity-mode . ("nomicfoundation-solidity-language-server" "--stdio"))))

(after! lsp-mode
  ;; https://github.com/emacs-lsp/lsp-mode/issues/3577#issuecomment-1709232622
  (delete 'lsp-terraform lsp-client-packages)
  (setq lsp-go-use-gofumpt t)
  (add-to-list 'lsp-language-id-configuration '(solidity-mode . "solidity"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("nomicfoundation-solidity-language-server" "--stdio"))
                    :activation-fn (lsp-activate-on "solidity")
                    :priority 1000
                    :server-id 'solidity-language-server)))

(after! projectile
  (add-to-list 'projectile-project-root-files "foundry.toml"))

(after! solidity-mode
  (setq solidity-comment-style 'slash)
  (set-docsets! 'solidity-mode "Solidity")
  (when (modulep! :tools lsp)
    (add-hook 'solidity-mode-hook #'lsp! 'append))
  (when (modulep! :tools tree-sitter)
    (add-hook 'solidity-mode-hook #'tree-sitter! 'append)))

(after! sql-mode
  :config
  (when (modulep! :tools tree-sitter)
    (add-hook 'sql-mode-hook #'tree-sitter! 'append)))

(use-package! toml-mode
  :config
  (progn
    (when (modulep! :tools lsp)
      (add-hook 'toml-mode-hook #'lsp! 'append))
    (when (modulep! :tools tree-sitter)
      (add-hook 'toml-mode-hook #'tree-sitter! 'append))))

;; (use-package! treesit-auto
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   (treesit-extra-load-path (list (expand-file-name "treesit-modules" doom-user-dir)))
;;   (treesit-font-lock-level 4)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))

;; (when (require 'eglot nil :noerror)
;;   (setq eglot-autoshutdown t)
;;   (add-to-list 'eglot-server-programs
;;                '(toml-ts-mode . ("taplo" "lsp" "stdio")))
;;   (add-hook 'rust-ts-mode-hook #'eglot-ensure)
;;   (add-hook 'toml-ts-mode-hook #'eglot-ensure))

(setq vterm-shell "/bin/fish")
(setq flycheck-rust-executable "rust-analyzer")

;; (use-package! lsp-bridge
;;   :config
;;   (setq lsp-bridge-enable-log nil)
;;   (setq lsp-bridge-inlay-hint t)
;;   (map!
;;    :leader (:prefix "c" (:desc "LSP:rename" "r" #'lsp-bridge-rename)
;;                     (:desc "LSP:action" "a" #'lsp-bridge-code-action)
;;                     (:desc "LSP:format" "F" #'lsp-bridge-code-format)))
;;   (map! :desc "" :nv "S-k" #'lsp-bridge-popup-documentation)
;;   (map!
;;    :prefix "g" :desc "LSP:find def" :n "d" #'lsp-bridge-find-def
;;    :prefix "g" :desc "LSP:find def other" :n "D" #'lsp-bridge-find-def-other-window
;;    :prefix "g" :desc "LSP:find ref" :n "r" #'lsp-bridge-find-references
;;    :prefix "g" :desc "LSP:peek" :n "p" #'lsp-bridge-peek
;;    :prefix "g" :desc "LSP:find impl" :n "i" #'lsp-bridge-find-impl
;;    :prefix "g" :desc "LSP:find impl" :n "I" #'lsp-bridge-find-impl-other-window
;;    :prefix "g" :desc "LSP:find type def" :n "t" #'lsp-bridge-find-type-def
;;    :prefix "g" :desc "LSP:find type def other" :n "T" #'lsp-bridge-find-type-def-other-window)

;;   (map! :mode lsp-bridge-ref-mode :nv "q" #'lsp-bridge-ref-quit "RET" #'lsp-bridge-ref-open-file-and-stay "<return>" #'lsp-bridge-ref-open-file-and-stay)
;;   (map! :mode lsp-bridge-peek-mode :nv "M-q" #'lsp-bridge-peek-abort)
;;   (global-lsp-bridge-mode))

;; (use-package! acm-terminal
;;   :after (acm)
;;   :if (not (display-graphic-p))
;;   :requires (lsp-bridge))
;;
;; Or:
;;
;; (unless (display-graphic-p)
;;   (use-package! acm-terminal
;;     :after (acm)))
