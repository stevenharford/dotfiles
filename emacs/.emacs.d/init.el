;; Package management.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Save customizations outside the primary initialization file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Don't create backup files.
(setq make-backup-files nil)

;; Don't display the splash screen.
(setq inhibit-splash-screen t)

;; Remove unnecessary widgets.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Handle windows more conveniently.
(winner-mode 1)

;; Easily move between windows using windmove and make it work in
;; org-mode.
(windmove-default-keybindings)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Display line numbers in all programming modes.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; The fringe.
(setq-default indicate-buffer-boundaries 'left)

;; Disable cursor blinking on the terminal and on a graphical display.
(setq visible-cursor nil)
(blink-cursor-mode 0)

;; Tab and space preferences.
(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)
(setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)

;; Highlight any empty lines at the start/end of a buffer and any
;; trailing blanks at the end of a line.
(global-whitespace-mode 1)
(setq-default whitespace-style '(face empty trailing))

;; Mode line setup.
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config (setq column-number-mode t))

;; Configure Ivy.
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Settings for the stupendous Org mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-startup-indented t)
(setq org-log-repeat nil)
(setq org-agenda-files (file-expand-wildcards "~/organizer/*.org"))

(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((elixir . t)
   (sh . t)))

;; Use my (current) favourite programming font.
(add-to-list 'default-frame-alist
             '(font . "Hack-12"))

;; Use my (current) favourite color theme.
(load-theme 'gruvbox t)

;; Settings for editing web templates using web-mode.
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))

;; Disable compile on save in scss-mode.
(setq scss-compile-at-save nil)

;; Write HTML and CSS in a flash using emmet-mode.
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; In elm-mode, apply elm-format to the current buffer on every save.
(setq elm-format-on-save t)
