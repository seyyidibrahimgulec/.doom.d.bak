;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-snazzy)

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

;; Helm Projectile
(use-package helm-projectile
  :bind ("C-x f" . helm-projectile))
