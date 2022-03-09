;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Patrick Jiang"
      user-mail-address "patrickjiang0530@gmail.com")

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

(setq doom-font (font-spec :family "MesloLGS NF" :size 12)
      ;; doom-variable-pitch-font (font-spec :family "MesloLGS NF") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "MesloLGS NF" :size 12)
      doom-big-font (font-spec :family "MesloLGS NF" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-flatwhite)
(if (not (display-graphic-p))
      (setq doom-theme 'doom-one)
  (setq doom-theme 'doom-flatwhite))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 't)

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

(scroll-bar-mode -1)

;; (if (display-graphic-p)
;;     (progn
;;       (setq initial-frame-alist
;;             '(
;;               (tool-bar-lines . 0)
;;               (width . 170) ; chars
;;               (height . 50) ; lines
;;               (left . 35)
;;               (top . 35)))
;;       (setq default-frame-alist
;;             '(
;;               (tool-bar-lines . 0)
;;               (width . 170)
;;               (height . 50)
;;               (left . 35)
;;               (top . 35))))
;;   (progn
;;     (setq initial-frame-alist '( (tool-bar-lines . 0)))
;;     (setq default-frame-alist '( (tool-bar-lines . 0)))))

;; (if (display-graphic-p) (toggle-frame-maximized))
(toggle-frame-maximized)

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor"))

(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "vendor"))

(after! lsp-mode
  (setq +lsp-company-backends
        '(:separate company-capf company-yasnippet)))

;; (after! exwm
;;   (set-frame-parameter (selected-frame) 'alpha 90)
;;   (add-to-list 'default-frame-alist '(alpha . 90)))

(after! lsp-mode
  (lsp-register-custom-settings
   '(("gopls.experimentalWorkspaceModule" t t)))
  )

(after! lsp-mode
  (setq +lsp-company-backends
        '(:separate company-capf company-yasnippet)))

;; _ - as a part of word
(defadvice evil-inner-word (around symbol-as-word activate)
   (let ((table (copy-syntax-table (syntax-table))))
     (modify-syntax-entry ?_ "w" table)
     (modify-syntax-entry ?- "w" table)
     (with-syntax-table table
       ad-do-it)))

(global-visual-line-mode t)

;; (setq neo-window-width 35)
;; (add-hook 'neotree-mode-hook
;;        (lambda ()
;;          (visual-line-mode -1)
;;          (setq truncate-lines t)))
;; (add-hook 'projectile-after-switch-project-hook #'neotree)

;; (setq projectile-project-search-path '("~/LBProject" "~/Projects"))

(setq magit-branch-read-upstream-first :fallback)

;; delete not yank
(defun bb/evil-delete (orig-fn beg end &optional type _ &rest args) (apply orig-fn beg end type ?_ args))
(advice-add 'evil-delete :around 'bb/evil-delete)

;; wakatime
(exec-path-from-shell-copy-env "WAKATIME_API_KEY")
(exec-path-from-shell-copy-env "WAKATIME_CLI_PATH")
(exec-path-from-shell-copy-env "LBHOME")
(exec-path-from-shell-copy-env "GHHOME")

(setq wakatime-api-key (getenv "WAKATIME_API_KEY"))
(setq wakatime-cli-path (getenv "WAKATIME_CLI_PATH"))
(global-wakatime-mode)
