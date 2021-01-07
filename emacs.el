;; Disable graphical elements
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; Display relative lines
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


;; Display rows and columns at info bar
(setq column-number-mode t)


;; Highlight matching parenthesis
(show-paren-mode 1)



;; Highlight text over 73 cols, trailing whitespace and tabs
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 74)
(setq indent-tabs-mode nil)
(setq tab-width 1)
(setq tab-stop-list (number-sequence 2 120 2))
(setq js-indent-level 2)
(setq evil-shift-width 2)
(global-whitespace-mode t)

(add-hook 'js-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

(add-hook 'web-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))


;; No backup files or autosave
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)
(setq auto-save-default nil)


;; Autosave directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/tmp/auto-save" t)))


;; Save history
(savehist-mode 1)
(setq savehist-file "~/.emacs.d/tmp/history")


;; Load package manager, add registries
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "no ssl support"))

  (add-to-list 'package-archives
               (cons "melpa" (concat proto "://melpa.org/packages/")) t)

  (add-to-list 'package-archives
               (cons "melpa-stable"
                     (concat proto "://stable.melpa.org/packages/")) t))
(package-initialize)



;; Bootstrap use-package, install if required
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; bind key
(use-package bind-key)


;; load theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))


;; Disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)


;; Run server
(load "server")
(unless (server-running-p) (server-start))


(defun toggle-theme ()
  (interactive)
  (if (eq (car custom-enabled-themes) 'leuven)
    (progn
      (disable-theme 'leuven)
      (enable-theme 'solarized-dark))
    (progn
      (disable-theme 'solarized-dark)
      (enable-theme 'leuven))))
(load-theme 'leuven t 'f)
(global-set-key [f5] 'toggle-theme)

;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;
;; Packages
;;
;; Load evil!
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-commentary
    :ensure t
    :config
    (evil-commentary-mode))

  (use-package atomic-chrome
    :config
    (atomic-chrome-start-server)
    (setq atomic-chrome-buffer-open-style 'frame))

  (use-package evil-magit
    :ensure t
    :config

    (evil-leader/set-key
      "gb" 'magit-blame
      "gs" 'magit-status))

  (use-package evil-indent-textobject :ensure t))
;;
;; String manipulation
;;
(use-package string-inflection :ensure t)
;;
;; Undo tree
;;
(use-package undo-tree
  :ensure t
  :config

  (global-undo-tree-mode)
  ;; Save undo across sessions
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
        '(("." . "~/.emacs.d/tmp/undo")))

  (evil-leader/set-key
    "uv" 'undo-tree-visualize))
;;
;; Load project package
;;
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)

  (evil-leader/set-key
    "p" 'projectile-command-map)

  (use-package counsel-projectile
    :ensure t
    :config
    (counsel-projectile-mode)))
;;
;; File navigation
;;
(use-package ivy
  :ensure t
  :config

  (setq enable-recursive-minibuffers t)
  (setq ivy-use-virtual-buffers t)

  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)

  (evil-leader/set-key
    "fb" 'ivy-switch-buffer
    "ff" 'counsel-fzf
    "fg" 'counsel-git
    "fg" 'counsel-git-grep
    "fd" 'counsel-grep
    "fh" 'counsel-recentf
    "fl" 'counsel-locate
    "fs" 'counsel-ag
    "ft" 'counsel-etags-list-tag
    "fy" 'counsel-yank-pop
    "hf" 'counsel-describe-function
    "hl" 'counsel-find-library
    "hs" 'counsel-info-lookup-symbol
    "hu" 'counsel-unicode-char
    "hv" 'counsel-describe-variable)

  (use-package counsel-etags
    :ensure t

    :hook
    (prog-mode .
     (lambda ()
       (add-hook 'after-save-hook
                 'counsel-etags-virtual-update-tags 'append 'local)))

    :config
    ;; Don't ask before rereading the TAGS files if they have changed
    (setq tags-revert-without-query t)
    ;; Don't warn when TAGS files are large
    (setq large-file-warning-threshold nil)
    ;; How many seconds to wait before rerunning tags for auto-update
    (setq counsel-etags-update-interval 10)
    ;; Ignore build directories for tagging
    (add-to-list 'counsel-etags-ignore-directories "build")
    (add-to-list 'counsel-etags-ignore-filenames ".clang-format")

    (define-key evil-normal-state-map
      "gt" 'counsel-etags-find-tag-at-point))

  (use-package counsel :ensure t))
;;
;; Autocomplete
;;
(use-package company
  :ensure t
  :config

  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)

  (define-key company-active-map [tab]
    'company-complete-common-or-cycle)

  (add-hook 'after-init-hook 'global-company-mode))
;;
;; Snippets
;;
(defun emmet-hippie-try-expand-line (args)
  (interactive "P")
  (when emmet-mode
    (emmet-expand-line args)))

(use-package yasnippet
  :ensure t
  :config

  (setq yas-snippet-dirs
        (append yas-snippet-dirs
                '("~/dotfiles/yasnippets")))
  (yas-global-mode 1)
  (yas-reload-all)

  (unbind-key "TAB" yas-minor-mode-map)
  (unbind-key "<tab>" yas-minor-mode-map)

  (use-package yasnippet-snippets :ensure t)
  (use-package hippie-exp
    :ensure nil
    :defer t
    :bind ("<C-return>" . hippie-expand)
    :config
    (setq-default
     hippie-expand-try-functions-list
     '(yas-hippie-try-expand emmet-hippie-try-expand-line))))

;;
;; Load tree view package
;;
(use-package neotree
  :ensure t
  :config

  (evil-leader/set-key
    "m" 'neotree-toggle)

  (setq projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "q")
                'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "I")
                'neotree-hidden-file-toggle)
              (define-key evil-normal-state-local-map (kbd "z")
                'neotree-stretch-toggle)
              (define-key evil-normal-state-local-map (kbd "R")
                'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "m")
                'neotree-rename-node)
              (define-key evil-normal-state-local-map (kbd "c")
                'neotree-create-node)
              (define-key evil-normal-state-local-map (kbd "d")
                'neotree-delete-node)

              (define-key evil-normal-state-local-map (kbd "s")
                'neotree-enter-vertical-split)
              (define-key evil-normal-state-local-map (kbd "S")
                'neotree-enter-horizontal-split)

              (define-key evil-normal-state-local-map (kbd "RET")
                'neotree-enter))))
;;
;; Parenthesis auto close
;;
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1)
  (require 'smartparens-config))

;; fix parens for snippets
(defvar smartparens-mode-original-value)

(defun disable-sp-hippie-advice (&rest _)
  (setq smartparens-mode-original-value smartparens-mode)
  (setq smartparens-mode nil) t)

;; This advice could be added to other functions that usually insert
;; balanced parens, like `try-expand-list'.
(advice-add 'yas-hippie-try-expand :after-while #'disable-sp-hippie-advice)

(defun reenable-sp-hippie-advice (&rest _)
  (when (boundp 'smartparens-mode-original-value)
    (setq smartparens-mode smartparens-mode-original-value)
    (makunbound 'smartparens-mode-original-value)))

(advice-add 'hippie-expand :after #'reenable-sp-hippie-advice
            ;; Set negative depth to make sure we go after
            ;; `sp-auto-complete-advice'.
            '((depth . -100)))

;;
;; Syntax and language modes
;;
(add-hook 'find-file-hook
          (lambda ()
            (when (string= (file-name-extension buffer-file-name) "erb")
              (yas-activate-extra-mode 'erb-mode))))

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (add-to-list 'auto-mode-alist '("\\.html" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

  (use-package company-web
    :ensure t
    :config
    (require 'company-web-html)))

(use-package emmet-mode
  :ensure t

  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)

  (unbind-key "C-j" emmet-mode-keymap)
  (unbind-key "<C-return>" emmet-mode-keymap)

  (add-hook 'emmet-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "C-k")
                'emmet-prev-edit-point)
              (define-key evil-insert-state-local-map (kbd "C-k")
                'emmet-prev-edit-point)
              (define-key evil-normal-state-local-map (kbd "C-j")
                'emmet-next-edit-point)
              (define-key evil-insert-state-local-map (kbd "C-j")
                'emmet-next-edit-point))))

(use-package enh-ruby-mode
  :ensure t
  :config
  (setq ruby-insert-encoding-magic-comment nil))

(use-package go-mode
  :ensure t)

(use-package haml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.haml" . haml-mode)))

(use-package elm-mode
  :ensure t
  :config
  (elm-format-on-save-mode t))

(use-package haskell-mode
  :ensure t
  :config
  (setenv "PATH"
          (concat
           (getenv "HOME") "/.ghcup/bin" ":"
           (getenv "HOME") "/.cabal/bin" ":"
           (getenv "PATH"))))

(use-package tidal
  :ensure t
  :config
  (setq tidal-interpreter "/home/maca/.ghcup/bin/ghci"))

(use-package sclang)

(use-package sclang-extensions
  :ensure t)

(use-package elixir-mode
  :ensure t)

(use-package csv-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package git-time-metric
  :ensure t
  :config
  (add-hook 'after-save-hook 'git-time-metric-record))


;; (use-package pdf-tools
;;  :pin manual ;; manually update
;;  :config
;;  ;; initialise
;;  (pdf-tools-install)
;;  ;; open pdfs scaled to fit page
;;  (setq-default pdf-view-display-size 'fit-page)
;;  ;; automatically annotate highlights
;;  (setq pdf-annot-activate-created-annotations t)
;;  ;; use normal isearch
;;  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
;;  ;; turn off cua so copy works
;;  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
;;  ;; more fine-grained zooming
;;  (setq pdf-view-resize-factor 1.1)
;;  ;; keyboard shortcuts
;;  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
;;  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
;;  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete))

;;
;; Folding
;;
(use-package origami
  :ensure t
  :config
  (global-origami-mode 1))
;; (use-package org-mode
;;   :ensure t
;;   :config)
;;
;;
;; Packages
;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminus" :foundry "PfEd" :slant normal :weight normal :height 180 :width normal))))
 '(whitespace-tab ((t (:foreground "#003542" :background "white")))))

;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(create-lockfiles nil)
 '(custom-safe-themes
   '("00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(atomic-chrome ## enh-ruby-mode yasnippet origami counsel-projectile tidal org-plus-contrib pdf-tools org-mode org-link-minor-mode elixir-mode counsel ivy-explorer yaml-mode elm-mode solarized-theme neotree use-package projectile evil-surround evil-leader evil-indent-textobject))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(put 'narrow-to-region 'disabled nil)
