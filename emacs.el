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
(setq whitespace-line-column 72)
(setq indent-tabs-mode nil)
(setq tab-width 2)
(setq tab-stop-list (number-sequence 2 120 2))
(setq evil-shift-width 2)
(global-whitespace-mode t)


;; No backup files
(setq make-backup-files nil)


;; Autosave directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/tmp/auto-save" t)))


;; Save history
(savehist-mode 1)
(setq savehist-file "~/.emacs.d/tmp/history")


;; Load package manager, add registries
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


;; Bootstrap use-package, install if required
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


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

  (use-package evil-magit
    :ensure t
    :config

    (evil-leader/set-key
      "gb" 'magit-blame
      "gs" 'magit-status))

  (use-package evil-indent-textobject :ensure t))
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
    "fh" 'counsel-recentf
    "fl" 'counsel-locate
    "fs" 'counsel-ag
    "ft" 'counsel-etags-list-tag
    "fy" 'counsel-yank-pop
    "hf" 'counsel-describe-function
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
(use-package yasnippet
  :ensure t
  :config

  (yas-global-mode 1)
  (use-package yasnippet-snippets
    :ensure t))
;;
;; Load tree view package
;;
(use-package neotree
  :ensure t
  :config

  (evil-leader/set-key
    "m" 'neotree-toggle
    "n" 'neotree-project-dir)

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
;;
;; Syntax and language modes
;;
(use-package web-mode
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex" . web-mode))

  (use-package company-web
    :ensure t
    :config
    (require 'company-web-html)))

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode))

(use-package ruby-mode
  :ensure t
  :config
  (setq ruby-insert-encoding-magic-comment nil))

(use-package elm-mode
  :ensure t)

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

(use-package elixir-mode
  :ensure t)

(use-package csv-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package pdf-tools
  :ensure t)

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


;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(package-selected-packages
   '(yasnippet origami counsel-projectile tidal org-plus-contrib pdf-tools org-mode org-link-minor-mode elixir-mode counsel ivy-explorer yaml-mode elm-mode solarized-theme neotree use-package projectile evil-surround evil-leader evil-indent-textobject)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "xos4 Terminus" :foundry "xos4" :slant normal :weight normal :height 180 :width normal)))))
