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
      "C-c s" #'lsp-ui-sideline-toggle-symbols-info
      "C-c C-r" #'lsp-rename
      "C-c L" #'lsp-ui-flycheck-list
      "<f8>" #'treemacs
      "C-j" #'emmet-expand-line)
;; Tooltips

(setq company-tooltip-align-annotations t)

;; Prettier

(add-hook! 'js2-mode-hook
           'js-mode-hook
           'rjsx-mode-hook
           'web-mode-hook
           'typescript-mode-hook #'prettier-js-mode)

;; Font

(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 15)
      doom-unicode-font (font-spec :family "Input Mono Narrow" :size 15))
