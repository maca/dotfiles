;; Disable graphical elements
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


(when (member "Noto Color Emoji" (font-family-list))
  (set-fontset-font
   t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend))

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
 '(ansi-color-names-vector
   ["#f4eedb" "#cc1f24" "#778c00" "#a67c00" "#007ec4" "#c42475" "#11948b" "#88999b"])
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(create-lockfiles nil)
 '(cua-global-mark-cursor-color "#11948b")
 '(cua-normal-cursor-color "#596e76")
 '(cua-overwrite-cursor-color "#a67c00")
 '(cua-read-only-cursor-color "#778c00")
 '(custom-safe-themes
   '("76b4632612953d1a8976d983c4fdf5c3af92d216e2f87ce2b0726a1f37606158" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(display-line-numbers-type 'relative)
 '(fci-rule-color "#f4eedb")
 '(global-display-line-numbers-mode t)
 '(highlight-changes-colors '("#c42475" "#5e65b6"))
 '(highlight-symbol-colors
   '("#ed7ddb24b29e" "#cd82e29fd17d" "#fc9acae0b444" "#d974d4beddd6" "#df08dfc6b349" "#f76ccd6eaf2a" "#d132db92e15a"))
 '(highlight-symbol-foreground-color "#5d737a")
 '(highlight-tail-colors
   '(("#f4eedb" . 0)
     ("#a8b84b" . 20)
     ("#66c1b3" . 30)
     ("#6fa5e7" . 50)
     ("#d6a549" . 60)
     ("#ed6e3e" . 70)
     ("#f46495" . 85)
     ("#f4eedb" . 100)))
 '(hl-bg-colors
   '("#d6a549" "#ed6e3e" "#ff6243" "#f46495" "#837bdf" "#6fa5e7" "#66c1b3" "#a8b84b"))
 '(hl-fg-colors
   '("#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9"))
 '(hl-paren-colors '("#11948b" "#a67c00" "#007ec4" "#5e65b6" "#778c00"))
 '(lsp-ui-doc-border "#5d737a")
 '(nrepl-message-colors
   '("#cc1f24" "#bb3e06" "#a67c00" "#4f6600" "#a8b84b" "#005797" "#11948b" "#c42475" "#5e65b6"))
 '(package-selected-packages
   '(restclient diminish rainbow-mode twilight-bright-theme atomic-chrome ## enh-ruby-mode yasnippet origami counsel-projectile tidal org-plus-contrib pdf-tools org-mode org-link-minor-mode elixir-mode counsel ivy-explorer yaml-mode elm-mode solarized-theme neotree use-package projectile evil-surround evil-leader evil-indent-textobject))
 '(pos-tip-background-color "#f4eedb")
 '(pos-tip-foreground-color "#5d737a")
 '(safe-local-variable-values '((hello . test)))
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#778c00" "#f4eedb" 0.2))
 '(term-default-bg-color "#fffce9")
 '(term-default-fg-color "#596e76")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#cc1f24")
     (40 . "#bbbc5a0718b8")
     (60 . "#b1cf6c680f6e")
     (80 . "#a67c00")
     (100 . "#980682770000")
     (120 . "#906085330000")
     (140 . "#887187c90000")
     (160 . "#802a8a3b0000")
     (180 . "#778c00")
     (200 . "#69798ef83f8d")
     (220 . "#5f60904453a3")
     (240 . "#51b991a1669e")
     (260 . "#3d7993107928")
     (280 . "#11948b")
     (300 . "#1b098bdaa289")
     (320 . "#1963876fadf4")
     (340 . "#129982fcb95b")
     (360 . "#007ec4")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#fffce9" "#f4eedb" "#990001" "#cc1f24" "#4f6600" "#778c00" "#785700" "#a67c00" "#005797" "#007ec4" "#93004d" "#c42475" "#006d68" "#11948b" "#596e76" "#88999b"))
 '(xterm-color-names
   ["#f4eedb" "#cc1f24" "#778c00" "#a67c00" "#007ec4" "#c42475" "#11948b" "#002b37"])
 '(xterm-color-names-bright
   ["#fffce9" "#bb3e06" "#98a6a6" "#88999b" "#596e76" "#5e65b6" "#5d737a" "#00212b"]))


(put 'narrow-to-region 'disabled nil)

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
(diminish 'global-whitespace-mode)


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


;; Hide mode lighters
(use-package diminish :ensure t)


;; load theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))


(use-package twilight-bright-theme :ensure t)


;; bind key
(use-package bind-key)


(defun toggle-theme ()
  (interactive)
  (if (eq (car custom-enabled-themes) 'twilight-bright)
    (progn
      (disable-theme 'twilight-bright)
      (enable-theme 'solarized-dark))
    (progn
      (disable-theme 'solarized-dark)
      (enable-theme 'twilight-bright))))
(load-theme 'leuven t 'f)
(global-set-key [f5] 'toggle-theme)


(defun set-bigger-font-size (size)
  (interactive)
  (set-face-attribute 'default (selected-frame) :height 170))



;; (set-frame-font "Inconsolata 12" nil t)

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
    (evil-commentary-mode)
    (diminish 'evil-commentary-mode))

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

  (use-package git-timemachine
    :ensure t
    :config

    (evil-define-minor-mode-key 'normal 'git-timemachine-mode
      "\C-k" 'git-timemachine-show-previous-revision
      "\C-j" 'git-timemachine-show-next-revision
      "q" 'git-timemachine-quit
      "gs" 'git-timemachine-show-nth-revision
      "gf" 'git-timemachine-show-revision-fuzzy
      "gy" 'git-timemachine-kill-abbreviated-revision
      "gY" 'git-timemachine-kill-revision
      "gb" 'git-timemachine-blame
      "gc" 'git-timemachine-show-commit)

    (evil-leader/set-key "gr" 'git-timemachine-toggle)

    (diminish 'git-timemachine-mode
              '(:propertize " GTM" face '(:foreground "red"))))

  (use-package git-time-metric
    :ensure t
    :config
    (add-hook 'after-save-hook 'git-time-metric-record))

  (use-package vimish-fold
    :ensure
    :after evil)

  (use-package evil-vimish-fold
    :ensure
    :after vimish-fold
    :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode)
    :config (diminish 'evil-vimish-fold-mode))

  (use-package evil-collection
    :ensure t
    :after evil magit
    :config
    (evil-collection-init 'magit)
    (evil-collection-init 'elisp-mode))

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
    "uu" 'undo-tree-visualize)

  (diminish 'undo-tree-mode))
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
  ;; (push '(company-etags company-keywords) company-backends)

  (define-key company-active-map [tab] 'company-complete-common-or-cycle)

  (add-hook 'after-init-hook 'global-company-mode)

  (diminish 'company-mode))
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
;; Parenthesis auto close
;;
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1)
  (require 'smartparens-config)

  (diminish 'smartparens-mode))
;;
;; Color matching parens
;;
(use-package rainbow-delimiters
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))
;;
;; Show colors
;;
(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (diminish 'rainbow-mode))

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

(use-package restclient :ensure t)

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


(defvar elm-live-mode-vars nil)
(setq elm-live-mode-vars nil)


(define-minor-mode elm-live-mode
  nil
  :lighter " eml-live"
  (if elm-live-mode
      (progn
        (unless (elm-live--get-project-var 'elm-live-mode)
          (elm-live--set-defaults))

        (add-hook 'after-save-hook (lambda () (elm-live-mode-compile)) t t)
        (setq compilation-finish-functions #'elm-live-mode--compilation-finish)

        (elm-live-server-start)
        (elm-live-mode-compile))
    (elm-live-server-stop)
    (elm-live--set-project-var 'elm-live-mode nil)
    (remove-hook 'elm-mode-hook #'elm-live-elm-mode-hook)))


(defun elm-live-elm-mode-hook ()
  (when (elm-live--get-project-var 'elm-live-mode) (elm-live-mode)))


(defun elm-live--set-defaults ()
  (let* ((build-dir (file-name-as-directory
                     (concat (temporary-file-directory)
                             (md5 (elm-live-project-root)))))
         (index (concat build-dir "index.html")))

    (elm-live-set-build-directory build-dir)
    (elm-live--set-project-var 'elm-live-mode 1)
    (elm-live-set-compile-module "src/Main.elm")
    (elm-live-set-output index)
    (elm-live-set-index index)
    (add-hook 'elm-mode-hook #'elm-live-elm-mode-hook)))


(defun elm-live-mode-toggle-debug ()
  (interactive)
  (let ((debug (not (elm-live--get-project-var 'debug))))
    (elm-live--set-project-var 'debug debug)
    (elm-live-mode-compile)
    (message (concat "Elm compile debug " (if debug "enabled" "disabled")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File and Directory utils
(defun elm-live-mode--set-path-var (var path)
  (let ((default-directory (elm-live-project-root)))
    (elm-live--set-project-var var (expand-file-name path))
    (elm-live-server-stop)
    (elm-live-server-start)))


(defun elm-live-set-compile-module (&optional path)
  "Set Elm module PATH to be compiled."
  (interactive
   (unless current-prefix-arg
     (list (read-file-name "Elm module to compile: "))))
  (elm-live-mode--set-path-var 'elm-compile-module path))


(defun elm-live-set-index (&optional path)
  "Set server index PATH."
  (interactive
   (unless current-prefix-arg
     (list (read-file-name "Server index: " (elm-live-project-root)))))
  (elm-live-mode--set-path-var 'index path))


(defun elm-live-set-output (&optional path)
  "Set server output PATH."
  (interactive
   (unless current-prefix-arg
     (list
      (read-file-name "Elm compile output: "
                      (elm-live--get-project-var 'build-directory)))))
  (let ((output (elm-live--get-project-var 'elm-compile-output)))
    (when output (delete-file output)))
  (elm-live-mode--set-path-var 'elm-compile-output path))


(defun elm-live-set-build-directory (&optional path)
  "Set server build directory PATH."
  (interactive
   (unless current-prefix-arg
     (list (read-directory-name "Server build directory: "))))
  (elm-live-mode--set-path-var 'build-directory path))


(defun elm-live-project-root ()
  (expand-file-name (elm--find-dependency-file-path)))


(defun elm-live--serve-directories ()
  `(,(elm-live--get-project-var 'build-directory)
    ,(elm-live-project-root)))
;; File and Directory utils
;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun elm-live-mode--compilation-finish (buffer outstr)
  (unless (string-match "finished" outstr)
    (switch-to-buffer-other-window buffer)))


(defun elm-live-mode-compile ()
  (interactive)
  (setq-local elm-compile-arguments
              (if (elm-live--get-project-var 'debug) '("--debug") '()))

  (elm-compile--file
   (elm-live--get-project-var 'elm-compile-module)
   (elm-live--get-project-var 'elm-compile-output)))


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


(defun elm-live--server-process-filter (proc string)
  (save-match-data
    (when (string-match "Local: \\(.*\\)" string)
      (elm-live--set-project-var 'url (match-string 1 string))))

  (when (buffer-live-p (process-buffer proc))
    (with-current-buffer (process-buffer proc)
      (goto-char (process-mark proc))
      (insert string)
      (set-marker (process-mark proc) (point)))))


(defun elm-live-server-start ()
  "Run elm server on the background"
  (interactive)

  (unless (process-live-p (elm-live--get-project-var 'process))
    (let ((cmd
           (flatten-list
            `("browser-sync" "start" "-s"
              "--no-open"
              "--single"
              "--files" ,(elm-live--serve-directories)
              "--ss" ,(elm-live--serve-directories)
              "--no-ui" "--reload-debounce" "500"))))

      (elm-live--set-project-var
       'process
       (make-process :name "elm-server"
                     :buffer "*elm-server*"
                     :command cmd
                     :filter #'elm-live--server-process-filter)))))


(defun elm-live-server-stop ()
  "Stop running elm server"
  (interactive)

  (when (process-live-p (elm-live--get-project-var 'process))
    (delete-process (elm-live--get-project-var 'process))))


(defun elm-live-open-in-browser ()
  "Open server url in browser"
  (interactive)
  (when (process-live-p (elm-live--get-project-var 'process))
    (browse-url (elm-live--get-project-var 'url))))


(defun elm-live--set-project-var (name value)
  (setf
   (alist-get
    `(,(elm-live-project-root) ,name) elm-live-mode-vars nil 'remove #'equal)
   value))


(defun elm-live--get-project-var (name)
  (alist-get
   `(,(elm-live-project-root) ,name) elm-live-mode-vars nil nil #'equal))


(diminish 'auto-revert-mode)
(diminish 'eldoc-mode)
