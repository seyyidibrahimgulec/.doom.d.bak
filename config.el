;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Seyyid İbrahim Güleç"
      user-mail-address "seyyidibrahimgulec@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (use-package color-theme-sanityinc-tomorrow)
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Full Screen on Startup
;; (toggle-frame-fullscreen)
(setq ns-auto-hide-menu-bar t)
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))



;; Macos Key Bindings
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Some Extra Keybindings
;; source: spacemacs' better default layer
(defun backward-kill-word-or-region ()
  "Calls `kill-region' when a region is active and
	  `backward-kill-word' otherwise."
  (interactive)
  (if (region-active-p)
	    (call-interactively 'kill-region)
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;; Use shell-like backspace C-h, rebind help to C-?
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-u") 'winner-undo)
(global-set-key (kbd "M-U") 'winner-redo)


;; Expand Region
(use-package expand-region
  :init
  (setq expand-region-fast-keys-enabled nil
	      expand-region-subword-enabled t)
  :bind (("C-t" . er/expand-region)))


;; Multiple Cursors
(use-package multiple-cursors
  :init (setq mc/always-run-for-all t)
  :bind (("C-M-n" . mc/mark-next-like-this)
	 ("C-M-p" . mc/mark-previous-like-this)
	 ("C-M-S-n" . mc/skip-to-next-like-this)
	 ("C-M-S-p" . mc/skip-to-previous-like-this)
	 ("C-S-n" . mc/unmark-previous-like-this)
	 ("C-S-p" . mc/unmark-next-like-this)
	 ("C-M-<mouse-1>" . mc/add-cursor-on-click)))

;; Counsel Projectile
(use-package! counsel-projectile
  :bind ("C-x f" . counsel-projectile))

;; Agressive indent
(use-package! aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))

;; Pyright
(use-package! lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

;; (use-package! helm-ag)

(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-file-watch-threshold 500000))

(setq tab-always-indent t)

(use-package turkish)

(use-package org
  :defer t
  :config
  (set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))

  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org-indent
  :defer t
  :after org
  :config
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch)))


(use-package org-tempo
  :defer t
  :after org
  :config
  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("json" . "src json")))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))
