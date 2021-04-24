;; Disable graphical elements
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; Disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)


;; Run server
(load "server")
(unless (server-running-p) (server-start))


;; Display relative lines
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


;; Display rows and columns at info bar
(setq column-number-mode t)


;; Highlight matching parenthesis
(show-paren-mode 1)


;; Highlight text over 80 cols, trailing whitespace and tabs
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 80)
(setq-default fill-column 80)
(setq indent-tabs-mode nil)
(setq tab-width 1)
(setq js-indent-level 2)
(setq evil-shift-width 2)
(global-whitespace-mode t)

(defun disable-indent-tabs-mode () (setq indent-tabs-mode nil))
(add-hook 'js-mode-hook #'disable-indent-tabs-mode)
(add-hook 'web-mode-hook #'disable-indent-tabs-mode)
(add-hook 'elm-mode-hook #'disable-indent-tabs-mode)
(add-hook 'emacs-lisp-mode-hook #'disable-indent-tabs-mode)


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
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)

  (evil-leader/set-key
    "tt" 'toggle-truncate-lines
    "tu" 'string-inflection-underscore
    "tc" 'string-inflection-camelcase
    "tk" 'string-inflection-kebab-case)

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

  (use-package magit
    :ensure t
    :config
    (add-hook 'after-save-hook 'magit-after-save-refresh-status t)

    (evil-leader/set-key
      "gb" 'magit-blame
      "gs" 'magit-status))

  (use-package vimish-fold
    :ensure
    :after evil)

  (use-package evil-vimish-fold
    :ensure
    :after vimish-fold
    :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode))

  (use-package evil-collection
    :ensure t
    :after evil magit
    :config
    (evil-collection-init 'magit))

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
    "uu" 'undo-tree-visualize))
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
    "fp" 'counsel-yank-pop
    "hf" 'counsel-describe-function
    "hl" 'counsel-find-library
    "hs" 'counsel-info-lookup-symbol
    "hu" 'counsel-unicode-char
    "hv" 'counsel-describe-variable)

  (use-package counsel :ensure t)
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
      "gt" 'counsel-etags-find-tag-at-point)))
;;
;; Autocomplete
;;
(use-package company
  :ensure t
  :config

  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (push '(company-etags company-keywords) company-backends)

  (define-key company-active-map [tab] 'company-complete-common-or-cycle)

  (add-hook 'after-init-hook 'global-company-mode))
;;
;; Snippets
;;
(defun emmet-hippie-try-expand-line (args)
  (interactive "P")
  (when emmet-mode (emmet-expand-line args)))


(defun elm-emmet-expand-line (args)
  (interactive "P")
  (when (eq major-mode 'elm-mode)
    (let* ((beg (emmet-find-left-bound))
           (beg-line (save-excursion (beginning-of-line) (point)))
           (indentation-level
            (save-excursion
              (goto-char beg)
              (re-search-backward "[^[:space:]]" beg-line t)
              (current-column))))

      (setq-local emmet-move-cursor-after-expanding nil)
      (emmet-expand-line args)
      (html-to-elm beg (point))

      (save-excursion
        (exchange-dot-and-mark)
        (forward-line 1)
        (indent-rigidly (region-beginning)
                        (region-end)
                        indentation-level)))))


(defun html-to-elm (&optional b e)
  (interactive "r")
  (shell-command-on-region b e "xargs -0 html-elm" (current-buffer) t))


(use-package hippie-exp
    :ensure nil
    :defer t
    :bind ("<C-return>" . hippie-expand)
    :config
    (setq-default hippie-expand-try-functions-list
                  '(yas-hippie-try-expand
                    emmet-hippie-try-expand-line
                    elm-emmet-expand-line)))


;; Add yasnippet support for all company backends
(defvar company-mode/enable-yas t "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas)
          (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(use-package yasnippet
  :ensure t
  :config

  (setq yas-snippet-dirs
        (append yas-snippet-dirs '("~/dotfiles/yasnippets")))
  (yas-global-mode 1)
  (yas-reload-all)

  (setq company-backends
        (mapcar #'company-mode/backend-with-yas company-backends))

  (unbind-key "TAB" yas-minor-mode-map)
  (unbind-key "<tab>" yas-minor-mode-map)

  (use-package yasnippet-snippets :ensure t)
  (use-package elm-yasnippets :ensure t))
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
;; Color matching parens
;;
(use-package rainbow-delimiters
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))
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
              (define-key evil-normal-state-local-map (kbd "C-p")
                'emmet-prev-edit-point)
              (define-key evil-insert-state-local-map (kbd "C-p")
                'emmet-prev-edit-point)
              (define-key evil-normal-state-local-map (kbd "C-n")
                'emmet-next-edit-point)
              (define-key evil-insert-state-local-map (kbd "C-n")
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
  (add-hook 'elm-mode-hook 'elm-format-on-save-mode))

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
;; Ligatures
;;
(use-package ligature
  :load-path "~/.emacs.d/ligature.el"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("-|" "-~" "---" "-<<" "-<" "--"
                                      "->" "->>" "-->" "///" "/="
                                      "/==" "/>" "//" "/*" "*>" "***"
                                      "*/" "<-" "<<-" "<=>" "<=" "<|"
                                      "<||" "<|||" "<|>" "<:" "<>"
                                      "<-<" "<<<" "<==" "<<=" "<=<"
                                      "<==>" "<-|" "<<" "<~>" "<=|"
                                      "<~~" "<~" "<$>" "<$" "<+>" "<+"
                                      "</>" "</" "<*" "<*>" "<->"
                                      "<!--" ":>" ":<" ":::" "::" ":?"
                                      ":?>" ":=" "::=" "=>>" "==>"
                                      "=/=" "=!=" "=>" "===" "=:="
                                      "==" "!==" "!!" "!=" ">]" ">:"
                                      ">>-" ">>=" ">=>" ">>>" ">-"
                                      ">=" "&&&" "&&" "|||>" "||>"
                                      "|>" "|]" "|}" "|=>" "|->" "|="
                                      "||-" "|-" "||=" "||" ".." ".?"
                                      ".=" ".-" "..<" "..." "+++" "+>"
                                      "++" "[||]" "[<" "[|" "{|" "??"
                                      "?." "?=" "?:" "##" "###" "####"
                                      "#[" "#{" "#=" "#!" "#:" "#_("
                                      "#_" "#?" "#(" ";;" "_|_" "__"
                                      "~~" "~~>" "~>" "~-" "~@" "$>"
                                      "^=" "]#"))
  (global-ligature-mode t))
;;
;; Org mode
;;
;; (use-package org-mode
;;   :ensure t
;;   :config)
;;
;;
;; Packages
;; ;; ;; ;; ;; ;; ;; ;; ;; ;; ;;


(make-variable-buffer-local
 (defvar elm-live-compile-output "build/elm-dev.js" "Elm compile output"))

(make-variable-buffer-local
 (defvar elm-live-serve-directory "build" "Serve directory path"))

(make-variable-buffer-local
 (defvar elm-live-index "index.html" "Server index html file path"))

(make-variable-buffer-local
 (defvar elm-live-compile-debug nil "Elm compile debug option"))

(make-variable-buffer-local (defvar elm-live--server-url nil))

(make-variable-buffer-local (defvar elm-live--server-process nil))


(defun elm-live-mode-toggle-debug ()
  (interactive)
  (setq-local elm-live-compile-debug (not elm-live-compile-debug))
  (message
   (concat "Elm compile debug "
           (if elm-live-compile-debug "enabled" "disabled")))
  (elm-live-mode-compile))


(defun elm-live-mode-compile ()
  (interactive)
  (setq-local elm-compile-arguments
              (if elm-live-compile-debug '("--debug") '()))
  (elm-compile-main elm-live-compile-output))


(defun elm-live-mode--save-hook ()
  (when (and elm-live-mode (eq major-mode 'elm-mode))
    (elm-live-mode-compile)))


(defun elm-live-mode--compilation-finish (buffer outstr)
  (unless (string-match "finished" outstr)
    (switch-to-buffer-other-window buffer)))


(define-minor-mode elm-live-mode
  nil
  :lighter " eml-live"
  (if elm-live-mode
      (progn
        (add-hook 'after-save-hook #'elm-live-mode--save-hook t)
        (setq compilation-finish-functions #'elm-live-mode--compilation-finish)
        (elm-live-server-start)
        (elm-live-mode-compile))
    (elm-live-server-stop)))


(defadvice compilation-start
    (around inhibit-display
            (command &optional mode name-function highlight-regexp))
  (if (and elm-live-mode (not (string-match "^\\(find\\|grep\\)" command)))
      (cl-letf ((display-buffer   #'ignore)
                (set-window-point #'ignoreco)
                (goto-char        #'ignore))
        (save-window-excursion ad-do-it))
    ad-do-it))

(ad-activate 'compilation-start)


(defun elm-live-server-filter (proc string)
  (save-match-data
    (when (string-match "Local: \\(.*\\)" string)
      (setq-local elm-live--server-url (match-string 1 string))))

  (when (buffer-live-p (process-buffer proc))
    (with-current-buffer (process-buffer proc)
      (goto-char (process-mark proc))
      (insert string)
      (set-marker (process-mark proc) (point)))))


(defun elm-live-server-start ()
  "Run elm server on the background"
  (interactive)
  (let ((cmd `("browser-sync" "start" "-s"
               "--ignore" "*.elm" "--files" "."
               "--no-open"
               "--ss" ,elm-live-serve-directory
               "--no-ui" "--reload-debounce" "500"))
        (default-directory (expand-file-name (elm--find-dependency-file-path))))

    (setq-local elm-live--server-process
                (make-process :name "elm-server"
                              :buffer "*elm-server*"
                              :command cmd
                              :filter #'elm-live-server-filter))))


(defun elm-live-server-stop ()
  "Stop running elm server"
  (interactive)
  (delete-process elm-live--server-process))


(defun elm-live-open-in-browser ()
  "Open server url in browser"
  (interactive)
  (when (process-live-p elm-live--server-process)
    (browse-url elm-live--server-url)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 143 :width normal))))
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
