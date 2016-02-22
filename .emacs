;; Package management.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Don't create backup files.
(setq make-backup-files nil)

;; Don't display the splash screen.
(setq inhibit-splash-screen t)

;; Remove unnecessary widgets.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers, except in org mode.
;(global-linum-mode t)
;(defun turn-linum-mode-off () (global-linum-mode 0))
;(add-hook 'org-mode-hook 'turn-linum-mode-off)

;; The fringe.
(setq-default indicate-buffer-boundaries 'left)

;; Show line and column numbers in the mode line.
(line-number-mode 1)
(column-number-mode 1)

;; Disable cursor blinking.
(blink-cursor-mode 0)

;; Tab and space preferences.
(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)
(setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)

;; Highlight any empty lines at the start/end of a buffer and any
;; trailing blanks at the end of a line.
(global-whitespace-mode 1)
(setq-default whitespace-style '(face empty trailing))

;; Ensure buffer names are unique.
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Settings for the stupendous Org mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-startup-indented t)
(setq org-log-repeat nil)
(setq org-agenda-files (file-expand-wildcards "~/documents/organizer/*.org"))

(setq org-src-fontify-natively t)

;; Use my (current) favourite color theme.
(load-theme 'base16-monokai-dark t)

;; Settings for editing web templates using web-mode.
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;; Disable compile on save in scss-mode.
(setq scss-compile-at-save nil)

;; Write HTML and CSS in a flash using emmet-mode.
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
