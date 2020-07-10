;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Mac modifiers

(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'control)

;; Clean UI

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-subword-mode 1)

;; Custom keybindings

(map! "<f7>" #'toggle-frame-fullscreen
      "C-x m" #'magit-status
      "C-c SPC" #'avy-goto-char-2
      "M-g M-g" #'avy-goto-line
      "\C-s" #'swiper
      "C-S-c C-S-c" #'mc/edit-lines
      "C-<" #'mc/mark-previous-like-this
      "C->" #'mc/mark-next-like-this
      "C-c C-<" #'mc/mark-all-like-this
      "M-o" #'ace-window
      "M-s M-s" #'ace-swap-window
      "C-c s" #'lsp-ui-sideline-toggle-symbols-info
      "C-c C-r" #'lsp-rename
      "C-c L" #'lsp-ui-flycheck-list
      "<f8>" #'treemacs
      "C-j" #'emmet-expand-line
      "C-S-R" #'sp-rewrap-sexp
      "C-S-U" #'sp-unwrap-sexp
      "C-<tab>" #'+fold/toggle)


;; Tooltips

(setq company-tooltip-align-annotations t)

;; Prettier

(add-hook! 'js2-mode-hook
           'js-mode-hook
           'rjsx-mode-hook
           'web-mode-hook
           'typescript-mode-hook #'prettier-js-mode)

;; Font

(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-unicode-font (font-spec :family "Input Mono Narrow" :size 14))

;; Disable irritating ts-mode smartparens behavior
(add-hook! 'typescript-mode-hook (local-unset-key "\'"))
(add-hook! 'typescript-mode-hook (local-unset-key "\""))
(add-hook! 'typescript-mode-hook (local-unset-key "("))

;; Company completion

(setq company-idle-delay 0)

;; angular lsp

;; linux
;; (setq lsp-clients-angular-language-server-command
;;   '("node"
;;     "/home/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules/@angular/language-server"
;;     "--ngProbeLocations"
;;     "/home/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules"
;;     "--tsProbeLocations"
;;     "/home/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules"
;;     "--stdio"))

;; mac
(setq lsp-clients-angular-language-server-command
  '("node"
    "/Users/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules/@angular/language-server"
    "--ngProbeLocations"
    "/Users/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules"
    "--tsProbeLocations"
    "/Users/mattpritchard/.nvm/versions/node/v10.16.2/lib/node_modules"
    "--stdio"))

;; projectile

(add-to-list 'projectile-globally-ignored-directories "*/node_modules/")

(defun shell-cmd (cmd)
  "Returns the stdout output of a shell command or nil if the command returned
   an error"
  (car (ignore-errors (apply 'process-lines (split-string cmd)))))

(defun reason-cmd-where (cmd)
  (let ((where (shell-cmd cmd)))
    (if (not (string-equal "unknown flag ----where" where))
      where)))

(let* ((refmt-bin (or (reason-cmd-where "refmt ----where")
                      (shell-cmd "which refmt")
                      (shell-cmd "which bsrefmt")))
       (merlin-bin (or (reason-cmd-where "ocamlmerlin ----where")
                       (shell-cmd "which ocamlmerlin")))
       (merlin-base-dir (when merlin-bin
                          (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
  ;; Add merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
  (when merlin-bin
    (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
    (setq merlin-command merlin-bin))

  (when refmt-bin
    (setq refmt-command refmt-bin)))

(require 'reason-mode)
(require 'merlin)
(add-hook 'reason-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(setq merlin-ac-setup t)
(after! which-key  (which-key-mode -1))
