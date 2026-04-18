;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; auto install packages for when I move between computers and distros
(defvar my-packages '(evil magit rust-mode dashboard dracula-theme doom-modeline which-key ivy counsel hl-todo rainbow-delimiters company diff-hl pdf-tools))

(unless (cl-every #'package-installed-p my-packages)
  (package-refresh-contents)
  (mapc #'package-install my-packages))

;; theme
(load-theme 'dracula t)

;; bar
(require 'doom-modeline)
(doom-modeline-mode 1)

;; git diff in gutter
(require 'diff-hl)
(global-diff-hl-mode -1)
(diff-hl-margin-mode 1)
(setq diff-hl-margin-symbols-alist
	  '((insert . "+")
		(delete . "-")
		(change . "~")
		(unknown . "?")
		(ignored . "i")))
(global-diff-hl-mode 1)

(global-set-key (kbd "C-x g") 'magit-status)

(require 'rust-mode)
(require 'eglot)
(require 'which-key)

(add-hook 'rust-mode-hook #'eglot-ensure)

(setq rust-format-on-save t)

;; ivy/counsel
(require 'ivy)
(ivy-mode 1)
(require 'counsel)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)

;; hl-todo
(require 'hl-todo)
(global-hl-todo-mode 1)

;; company autocomplete
(require 'company)
(global-company-mode 1)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; disable backup file 
(setq make-backup-files nil)
(setq auto-save-default nil)

;; evil
(require 'evil)
(evil-mode 1)

;; settings
(setq select-enable-clipboard t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq eglot-ignored-server-capabilities '(:documentFormattingProvider))

(set-face-attribute 'default nil :height 140)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 8)

;; TAB IS TAB
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq c-default-style "k&r"
	  c-basic-offset 4)

;; web development packages
(defvar my-web-packages '(web-mode php-mode emmet-mode rainbow-mode))
(unless (cl-every #'package-installed-p my-web-packages)
  (package-refresh-contents)
  (mapc #'package-install my-web-packages))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

(require 'php-mode)

(require 'rainbow-mode)
(add-hook 'web-mode-hook #'rainbow-mode)
(add-hook 'css-mode-hook #'rainbow-mode)

;; eglot for php and web
(add-hook 'php-mode-hook #'eglot-ensure)
(add-hook 'web-mode-hook #'eglot-ensure)
(add-hook 'css-mode-hook #'eglot-ensure)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '(php-mode . ("intelephense" "--stdio")))
  (add-to-list 'eglot-server-programs
	       '(web-mode . ("tailwindcss-language-server" "--stdio"))))

;; pdf support
(pdf-tools-install)
(add-hook 'pdf-view-mode-hook
		  (lambda ()
			(display-line-numbers-mode -1)))

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner "~/TETO.jpg")
(setq dashboard-banner-logo-title "Arbeit zeit, leute!")
(setq dashboard-center-content t)
(setq dashboard-items '((recents   . 5)
						(projects  . 5)
						(bookmarks . 3)))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(setq dashboard-image-banner-max-width 600)
(setq dashboard-image-banner-max-height 450)
