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
(setq +format-with-lsp nil)

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
(which-key-mode -1)
(setq projectile-indexing-method 'native)

;; org

(add-hook! 'org-mode-hook #'org-bullets-mode)
