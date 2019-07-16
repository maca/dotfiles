;; disable graphical elements
(menu-bar-mode -1) 
(scroll-bar-mode -1)
(tool-bar-mode -1) 


;; line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)



;; load package manager, add registries
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


;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; load theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))


;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)


;; server
(load "server")
(unless (server-running-p) (server-start))


;; load evil
(use-package evil
  :ensure t ;; install the evil package if not installed
  :config ;; tweak evil after loading itglobal-display-line-numbers-mode
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

  (use-package evil-indent-textobject :ensure t))


;; load helm
(use-package helm
  :ensure t
  :config
  (helm-mode))


(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))


;; load projectile
(use-package projectile
  :ensure t ;; install the evil package if not installed
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

  (use-package helm-projectile
    :bind (("C-S-P" . helm-projectile-switch-project)
	   :map evil-normal-state-map
	   ("C-p" . helm-projectile))
    :ensure t
    :config
    (evil-leader/set-key
      "ps" 'helm-projectile-ag
      "pa" 'helm-projectile-find-file-in-known-projects)))


(use-package neotree
  :ensure t
  :config

  (evil-leader/set-key
    "m"  'neotree-toggle
    "n"  'neotree-project-dir)

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


;; load elm-mode
(use-package elm-mode
  :ensure t)


;; generated configuration
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
