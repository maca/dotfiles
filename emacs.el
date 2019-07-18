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
(global-whitespace-mode t)
(setq whitespace-line-column 73)


;; Load package manager, add registries
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
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
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
;;
;; Load file autocomplete package
;;
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)

  (evil-leader/set-key
    "ff" 'counsel-fzf
    "fg" 'counsel-git
    "fg" 'counsel-git-grep
    "fl" 'counsel-locate
    "fs" 'counsel-ag
    "hl" 'counsel-find-library
    "hs" 'counsel-info-lookup-symbol
    "hu" 'counsel-unicode-char
    "hv" 'counsel-describe-variable))
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
;; Generated junk
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(package-selected-packages
   '(elm-mode solarized-theme helm-ag helm-projectile neotree use-package projectile helm evil-surround evil-leader evil-indent-textobject)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "xos4 Terminus" :foundry "xos4" :slant normal :weight normal :height 180 :width normal)))))
