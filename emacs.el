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
(global-whitespace-mode t)


;; Load package manager, add registries
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives
;;              '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
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

  (use-package evil-indent-textobject :ensure t))
;;
;; Load project package
;;
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p")
    'projectile-command-map))
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
    "ff" 'counsel-fzf
    "fg" 'counsel-git
    "fb" 'ivy-switch-buffer
    "fg" 'counsel-git-grep
    "fl" 'counsel-locate
    "fs" 'counsel-ag
    "hl" 'counsel-find-library
    "hs" 'counsel-info-lookup-symbol
    "hf" 'counsel-describe-function
    "hu" 'counsel-unicode-char
    "hv" 'counsel-describe-variable)

  (use-package counsel-etags
    :ensure t
    :config

    (define-key evil-normal-state-map (kbd "gt")
      'counsel-etags-find-tag-at-point)

    ;; Don't ask before rereading the TAGS files if they have changed
    (setq tags-revert-without-query t)

    ;; Don't warn when TAGS files are large
    (setq large-file-warning-threshold nil)

    ;; Setup auto update now
    (add-hook 'prog-mode-hook
      (lambda ()
        (add-hook 'after-save-hook
                  'counsel-etags-virtual-update-tags 'append 'local)))))
;;
;; Autocomplete
;;
(use-package company
  :ensure t
  :config

  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)

  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (add-hook 'after-init-hook 'global-company-mode))
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
;; Syntax and language modes
;;
(use-package elm-mode
  :ensure t)
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
   '(elm-mode solarized-theme neotree use-package projectile evil-surround evil-leader evil-indent-textobject)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "xos4 Terminus" :foundry "xos4" :slant normal :weight normal :height 180 :width normal)))))
