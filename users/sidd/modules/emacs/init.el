(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(setq user-full-name "Siddhant Kumar"
     user-mail-address "siddhantk232@gmail.com")

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(defun sc/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'sc/display-startup-time)

(setq native-comp-async-report-warnings-errors nil)

(line-number-mode 1)
(column-number-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-hl-line-mode t)

(use-package gruvbox-theme
  :ensure t)

(setq inhibit-startup-message t)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil
    auto-save-default nil)

;; yes or y | no or n
(defalias 'yes-or-no-p 'y-or-n-p)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(use-package which-key
  :ensure t
  :init
  (which-key-mode t))

(display-fill-column-indicator-mode 1)

;; Transparency
; (set-frame-parameter (selected-frame) 'alpha '(97 97))

(require 'ansi-color)
(defun sc/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'sc/ansi-colorize-buffer)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package evil-numbers
  :ensure t
  :after evil
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))


(setq org-src-window-setup 'current-window)
(setq org-file-apps
    (quote (("\\.x?html?\\'" . browse-url))))

(defun sc/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun sc/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :ensure t
  :hook (org-mode . sc/org-mode-setup)
  :config
  (require 'org-tempo)
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-directory "~/vimwiki/"
        org-log-done 'time
        org-confirm-babel-evaluate nil
        org-agenda-files (directory-files-recursively "~/vimwiki/" "\\.org$"))
  (sc/org-font-setup))

(use-package org-contrib
  :ensure t
  :after org)

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
                             (shell . t)
                             (js . t)
                             (ruby . t)
                             (python .t)
                             (clojure . t)))

(use-package org-appear
  :ensure t
  :after org)

(use-package org-superstar
  :ensure t
  :after org
  :init
  :hook (org-mode . org-superstar-mode))

(use-package org-fancy-priorities
  :ensure t
  :after org
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


(global-set-key (kbd "C-c a") 'org-agenda)


(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

(use-package amx
  :ensure t
  :after ivy
  :custom
  (amx-backend 'auto)
  (amx-save-file "~/.emacs.d/amx-items")
  (amx-history-length 50)
  (amx-show-key-bindings nil)
  :config
  (amx-mode 1))

(use-package counsel
  :ensure t
  :after (ivy amx)
  :config
  ;; Remove commands that only work with key bindings
  (put 'counsel-find-symbol 'no-counsel-M-x t)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x d" . counsel-dired)
         ("C-h v" . counsel-describe-variable)
         ("C-h f" . counsel-describe-function)))

(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x b") 'ibuffer)

(use-package treemacs
  :ensure t
  :custom
  (treemacs-position 'right))

(define-key evil-normal-state-map (kbd "SPC e") 'treemacs)

(use-package magit
  :ensure t)
(global-set-key (kbd "C-x g") 'magit-status)
