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

;; Configure line numbers (in programming modes only).
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq-default display-line-numbers-width 3)

;; Disable cursor blinking.
(blink-cursor-mode 0)

;; Tab and space preferences.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Highlight any empty lines at the start/end of a buffer and any
;; trailing blanks at the end of a line.
(global-whitespace-mode 1)
(setq-default whitespace-style '(face empty trailing))

;; Just scroll by one line when moving past the top or bottom of the screen.
(setq scroll-conservatively most-positive-fixnum)

;; Use my (current) favourite programming font.
(add-to-list 'default-frame-alist '(font . "Hack-12"))

;; Make text more comfortable to read.
(setq-default line-spacing 2)

;; Handle windows more conveniently.
(winner-mode 1)

;; Make sure to have nice icons.
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :init
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t)))

;; Python development setup.
(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

;; Completion framework settings.
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode t))

(use-package company-anaconda
  :ensure t
  :after (company anaconda-mode)
  :config
  (add-to-list 'company-backends 'company-anaconda))

;; Handle Dockerfiles.
(use-package dockerfile-mode
  :ensure t)

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
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; Configure Ivy, Counsel and Swiper.
(use-package ivy
  :ensure t
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x b"   . ivy-switch-buffer)
   ("C-c v"   . ivy-push-view)
   ("C-c V"   . ivy-pop-view))
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
  (("C-x t t" . treemacs)
   ("M-0"     . 'treemacs-select-window)))

;; Improve web template editing.
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-engines-alist
        '(("django" . "templates/.*\\.html\\'"))))

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

;; Reduce typing with snippets.
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
