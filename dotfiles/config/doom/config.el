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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Maple Mono NF" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Maple Mono NF" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-bluloco-dark)
;; (setq doom-theme 'doom-winter-is-coming-dark-blue)
;; (setq doom-theme 'doom-gruvbox-light)
;; (setq doom-theme 'doom-laserwave)
;; (setq doom-theme 'doom-wilmersdorf)
;; (setq doom-theme 'doom-ayu-dark)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'mocha) ;; or 'frappe, 'latte, or 'macchiato

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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


(when (treesit-available-p)
  (setq treesit-font-lock-level 4)
  (setq major-mode-remap-alist '(
                                 (js2-mode . js-ts-mode)
                                 (typescript-mode . typescript-ts-mode)))
  ;; (solidity-mode . solidity-ts-mode)))
  ;; (push "/Users/kyli/Codes/github.com/kylidboy/solidity-ts-mode/" load-path)
  (setq treesit-extra-load-path (list (expand-file-name "tree-sitter" doom-user-dir))))

;; For javascript/typescript
(after! typescript-mode
  ;; (set-formatter! 'jsts-fmt '("dprint" "fmt" "--stdin") :modes '(typescript-ts-mode typescript-mode javascript-mode rjsx-mode))
  (when (modulep! :tools lsp)
    (add-hook 'typescript-mode-hook #'lsp! 'append)
    (add-hook 'typescript-tsx-mode-hook #'lsp!)))
;; (setq-hook! 'typescript-mode +format-with-lsp nil)
;; (setq-hook! 'rjsx-mode +format-with-lsp nil)


(use-package! yul-mode)


(after! lsp-mode
  ;; https://github.com/emacs-lsp/lsp-mode/issues/3577#issuecomment-1709232622
  (delete 'lsp-terraform lsp-client-packages)
  (setq lsp-auto-guess-root t)
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-rust-all-features t)
  (setq lsp-inlay-hint-enable t)
  (setq lsp-go-use-gofumpt t)
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil)
  (setq lsp-disabled-clients '(taplo))
  (add-to-list 'lsp-disabled-clients 'semgrep-ls)

  (map! :leader (:prefix "c" :desc "lsp-ui imenu" "m" #'lsp-ui-imenu)))

(after! eglot
  ;; (add-hook 'rustic-mode-hook eglot-inlay-hints-mode)
  ;; (add-hook 'rustic-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs '(toml-mode . ("tombi-cli" "lsp")))
  (add-hook 'toml-mode-hook #'eglot-ensure))


;; (when (modulep! :tools tree-sitter)
;;   (add-hook 'sql-mode-hook #'tree-sitter! 'append))


(use-package! toml-mode
  :config
  (progn
    (when (modulep! :tools lsp)
      (add-hook 'toml-mode-hook #'lsp! 'append))
    (when (modulep! :tools tree-sitter)
      (add-hook 'toml-mode-hook #'tree-sitter! 'append))))

(use-package! mermaid-mode)

(setq flycheck-rust-executable "rust-analyzer")
(setq rust-mode-treesitter-derive t)
(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist '(solidity move go))
  (global-treesit-auto-mode))

;; lsp-booster
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

(use-package! eglot-booster
  :after eglot
  :config
  (eglot-booster-mode))

;; (use-package! lsp-bridge
;;   :config
;;   (add-to-list 'lsp-bridge-default-mode-hooks 'move-ts-mode-hook)
;;   (add-to-list 'lsp-bridge-single-lang-server-mode-list '((move-ts-mode move-mode) . "move-analyzer"))
;;   (after! lookup
;;     (set-lookup-handlers! 'lsp-bridge-mode
;;       :definition #'lsp-bridge-find-def
;;       :references #'lsp-bridge-find-references
;;       :type-definition #'lsp-bridge-find-type-def
;;       :implementations #'lsp-bridge-find-impl))
;;   (global-lsp-bridge-mode))

;; Setup exactly as go-mode for go-ts-mode
(use-package! flycheck-golangci-lint
  :when (and (modulep! :checkers syntax)
             (not (modulep! :checkers syntax +flymake)))
  :hook (go-ts-mode . flycheck-golangci-lint-setup))
(after! go-ts-mode
  (set-docsets! 'go-ts-mode "Go")
  (set-repl-handler! 'go-ts-mode #'gorepl-run)
  (set-lookup-handlers! 'go-ts-mode
    :documentation #'godoc-at-point)

  (add-hook 'go-ts-mode-hook #'lsp! 'append)

  (map! :map go-ts-mode-map
        :localleader
        "a" #'go-tag-add
        "d" #'go-tag-remove
        "e" #'+go/play-buffer-or-region
        "i" #'go-goto-imports      ; Go to imports
        (:prefix ("h" . "help")
                 "." #'godoc-at-point)    ; Lookup in godoc
        (:prefix ("ri" . "imports")
                 "a" #'go-import-add)
        (:prefix ("b" . "build")
         :desc "go run ." "r" (cmd! (compile "go run ."))
         :desc "go build" "b" (cmd! (compile "go build"))
         :desc "go clean" "c" (cmd! (compile "go clean")))
        (:prefix ("t" . "test")
                 "t" #'+go/test-rerun
                 "a" #'+go/test-all
                 "s" #'+go/test-single
                 "n" #'+go/test-nested
                 "f" #'+go/test-file
                 "g" #'go-gen-test-dwim
                 "G" #'go-gen-test-all
                 "e" #'go-gen-test-exported
                 (:prefix ("b" . "bench")
                          "s" #'+go/bench-single
                          "a" #'+go/bench-all))))

;; we recommend using use-package to organize your init.el
;; (use-package codeium
;;   ;; if you use straight
;;   ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
;;   ;; otherwise, make sure that the codeium.el file is on load-path

;;   :init
;;   ;; use globally
;;   (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
;;   ;; or on a hook
;;   ;; (add-hook 'python-mode-hook
;;   ;;     (lambda ()
;;   ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

;;   ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
;;   ;; (add-hook 'python-mode-hook
;;   ;;     (lambda ()
;;   ;;         (setq-local completion-at-point-functions
;;   ;;             (list (cape-capf-super #'codeium-completion-at-point #'lsp-completion-at-point)))))
;;   ;; an async company-backend is coming soon!

;;   ;; codeium-completion-at-point is autoloaded, but you can
;;   ;; optionally set a timer, which might speed up things as the
;;   ;; codeium local language server takes ~0.2s to start up
;;   ;; (add-hook 'emacs-startup-hook
;;   ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

;;   ;; :defer t ;; lazy loading, if you want
;;   :config
;;   (setq use-dialog-box nil) ;; do not use popup boxes

;;   ;; if you don't want to use customize to save the api-key
;;   ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

;;   ;; get codeium status in the modeline
;;   (setq codeium-mode-line-enable
;;         (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
;;   (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
;;   ;; alternatively for a more extensive mode-line
;;   ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

;;   ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
;;   (setq codeium-api-enabled
;;         (lambda (api)
;;           (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
;;   ;; you can also set a config for a single buffer like this:
;;   ;; (add-hook 'python-mode-hook
;;   ;;     (lambda ()
;;   ;;         (setq-local codeium/editor_options/tab_size 4)))

;;   ;; You can overwrite all the codeium configs!
;;   ;; for example, we recommend limiting the string sent to codeium for better performance
;;   (defun my-codeium/document/text ()
;;     (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
;;   ;; if you change the text, you should also change the cursor_offset
;;   ;; warning: this is measured by UTF-8 encoded bytes
;;   (defun my-codeium/document/cursor_offset ()
;;     (codeium-utf8-byte-length
;;      (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
;;   (setq codeium/document/text 'my-codeium/document/text)
;;   (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))
