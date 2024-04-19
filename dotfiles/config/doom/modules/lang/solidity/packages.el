;; -*- no-byte-compile: t; -*-
;;; lang/solidity/packages.el

(package! solidity-mode)

(when (and (modulep! :checkers syntax)
           (not (modulep! :checkers syntax +flymake)))
  (package! solidity-flycheck))
