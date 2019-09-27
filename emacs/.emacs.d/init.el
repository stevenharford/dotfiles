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

;; Use my (current) favourite programming font.
(add-to-list 'default-frame-alist '(font . "Hack-11"))

;; Handle windows more conveniently.
(winner-mode 1)

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
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (setq size-indication-mode t)
  (setq column-number-mode t))

;; Use my (current) favourite colour theme.
(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-one t)
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; Configure Ivy, Counsel and Swiper.
(use-package ivy
  :ensure t
  :bind
  ("C-c C-r" . ivy-resume)
  ("C-x b"   . ivy-switch-buffer)
  ("C-c v"   . ivy-push-view)
  ("C-c V"   . ivy-pop-view)
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :ensure t
  :bind
  (("M-x"     . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-c t"   . counsel-load-theme)
   ("C-c c"   . counsel-compile)
   ("C-c g"   . counsel-git)
   ("C-c j"   . counsel-git-grep)
   ("C-c L"   . counsel-git-log)
   ("C-x l"   . counsel-locate)
   ("C-c J"   . counsel-file-jump)
   ("C-c m"   . counsel-linux-app))
  :config
  (setq counsel-git-log-cmd "env GIT_PAGER=cat git log --grep '%s'"))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper-isearch))

;; Settings for the stupendous Org mode.
(use-package org
  :bind
  (("C-c a" . 'org-agenda)
   ("C-c b" . 'org-switchb)
   ("C-c l" . 'org-store-link))
  :config
  (setq org-startup-indented t)
  (setq org-log-repeat nil)
  (setq org-agenda-files (file-expand-wildcards "~/organizer/*.org"))
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t))))

;; Set up a file explorer.
(use-package treemacs
  :ensure t
  :bind
  ("C-x t t" . treemacs)
  ("M-0"     . 'treemacs-select-window))

;; Improve key binding discovery.
(use-package which-key
  :ensure t
  :init (which-key-mode))

;; Easily move between windows.
(use-package winum
  :ensure t
  :bind
  (:map winum-keymap
        ("M-1" . 'winum-select-window-1)
        ("M-2" . 'winum-select-window-2)
        ("M-3" . 'winum-select-window-3)
        ("M-4" . 'winum-select-window-4)
        ("M-5" . 'winum-select-window-5)
        ("M-6" . 'winum-select-window-6)
        ("M-7" . 'winum-select-window-7)
        ("M-8" . 'winum-select-window-8)
        ("M-9" . 'winum-select-window-9))
  :init
  (winum-mode))

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
