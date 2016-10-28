;;; package --- init golang
;;; Commentary:
;;; Code:

(use-package go-mode :ensure t)
(use-package company-go :ensure t)
(use-package go-eldoc :ensure t)
(use-package go-guru :ensure t)
(use-package go-dlv :ensure t)
(use-package flycheck-gometalinter
  :ensure t
  :config
  (progn
    (flycheck-gometalinter-setup)))

(setq company-tooltip-limit 20)
(setq company-idle-delay .3)
(setq company-echo-delay 0)
(setq company-begin-commands '(self-insert-command))

(custom-set-faces
 '(company-preview
   ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common
   ((t (:inherit company-preview))))
 '(company-tooltip
   ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((t (:background "steelblue" :foreground "white"))))
 '(company-tooltip-common
   ((((type x)) (:inherit company-tooltip :weight bold))
    (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :weight bold))
    (t (:inherit company-tooltip-selection)))))

(add-hook 'go-mode-hook (lambda ()
                          (go-eldoc-setup)
                          (setq gofmt-command "goimports")
                          (local-set-key (kbd "M-.") 'godef-jump)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq flycheck-gometalinter-fast t)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)
                          ))

(provide 'init-go)

;;; end
