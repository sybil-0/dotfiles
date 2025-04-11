;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE MANAGER SETUP ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar elpaca-installer-version 0.10)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GENERAL EMACS CONFIG ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; hide unecessary warnings when compiling packages
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;; general ui config
(setq ring-bell-function #'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
;; shut the annoying alarm sound up
(setq ring-bell-function 'ignore)
(electric-pair-mode +1)
;; Hide unnecessary UI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defvar display-line-numbers-type)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
;; enable history
(recentf-mode 1)
;; automatically load changed files
(defvar global-auto-revert-non-file-buffers)
(defvar auto-revert-verbose)
(global-auto-revert-mode +1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(show-paren-mode +1)

(setq custom-file (make-temp-file "emacs-custom"))
(when (file-exists-p custom-file)
  (load custom-file))

;; set typeface
;; (add-to-list 'default-frame-alist '(font . "Cascadia Code 14"))
(add-to-list 'default-frame-alist '(font . "JetBrains Mono 13"))

;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;

(setq use-package-always-ensure t)

(use-package ef-themes
  :init (load-theme 'ef-bio t))

;; required because the builtin version is too low for
;; up to date versions of magit
(use-package transient)

(use-package magit)

(use-package exec-path-from-shell
  :init (when (memq window-system '(mac ns x))
	  (exec-path-from-shell-initialize)))

(use-package nerd-icons)

(use-package doom-modeline
  :after (nerd-icons)
  :init
  (column-number-mode +1)
  (doom-modeline-mode 1))

(use-package which-key
  :init (which-key-mode 1))

(use-package ace-window
  :init (global-set-key (kbd "M-o") 'ace-window))

(use-package paredit
  :hook ((clojure-mode cider-repl-mode emacs-lisp-mode) . paredit-mode))

(use-package cider
  :bind (("C-x c r" . 'cider-repl-clear-buffer)))

(use-package pet
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(use-package lua-mode)

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))


(use-package zig-mode)

(use-package haskell-mode
  :custom
  (haskell-process-load-or-reload-prompt t))


;;;;;;;;;;;;;;;;;;;;;;;
;; Completion Config ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; LSP Mode and Company Mode configuration using use-package

;; -----------------------------------------------
;; Dependencies
;; -----------------------------------------------

;; Package management setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; -----------------------------------------------
;; Company Mode for completion
;; -----------------------------------------------

(use-package company
  :ensure t
  :diminish company-mode
  :hook (after-init . global-company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.1)
  (company-selection-wrap-around t)
  (company-tooltip-align-annotations t)
  (company-require-match nil)
  (company-frontends
   '(company-pseudo-tooltip-frontend
     company-echo-metadata-frontend))
  :config
  (setq company-backends '((company-capf :with company-yasnippet)))
  
  ;; Use C-n and C-p to navigate company completions
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("<tab>" . company-complete-common-or-cycle)
         :map company-search-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)))

;; Optional: Add company-box for nicer UI
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-show-single-candidate t
        company-box-doc-delay 0.3))

;; -----------------------------------------------
;; LSP Mode Configuration
;; -----------------------------------------------

(use-package lsp-mode
  :ensure t
  :commands lsp
  :diminish lsp-mode
  :hook ((python-mode . lsp)
         (rust-mode . lsp)
         (go-mode . lsp)
         (js-mode . lsp)
         (typescript-mode . lsp)
         (web-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         (java-mode . lsp)
         ;; Add more major modes as needed
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-auto-guess-root t)
  (lsp-keep-workspace-alive nil)
  (lsp-enable-file-watchers nil)
  (lsp-enable-folding nil)
  (lsp-enable-semantic-highlighting nil)
  (lsp-enable-symbol-highlighting t)
  (lsp-enable-text-document-color nil)
  (lsp-enable-on-type-formatting nil)
  (lsp-before-save-edits nil)
  (lsp-signature-auto-activate t)
  (lsp-signature-render-documentation t)
  (lsp-modeline-code-actions-enable nil)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-completion-provider :capf)
  (lsp-idle-delay 0.5)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

;; LSP UI enhancements
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-ignore-duplicate t)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)))

;; -----------------------------------------------
;; Optional Enhancements
;; -----------------------------------------------

;; which-key integration for LSP
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; For better error/warning visualization
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :hook (lsp-mode . flycheck-mode))

;; Adding yasnippet for templated completion
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (lsp-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; -----------------------------------------------
;; Language-specific LSP configuration
;; -----------------------------------------------

;; Python - pyright or python-language-server
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda () 
                         (require 'lsp-pyright)
                         (lsp))))

;; TypeScript/JavaScript
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp))

;; Rust
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp))

;; Optional: Treemacs integration for project view
(use-package lsp-treemacs
  :ensure t
  :after lsp-mode
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
         ("C-c l t e" . lsp-treemacs-errors-list)))

;; -----------------------------------------------
;; Performance optimizations
;; -----------------------------------------------

;; Adjust garbage collection threshold for better performance
(setq gc-cons-threshold 100000000)

;; Increase the amount of data which Emacs reads from processes
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; -----------------------------------------------
;; Key bindings reminder
;; -----------------------------------------------

;; LSP mode:
;; C-c l .  - Go to definition
;; C-c l r  - Find references
;; C-c l R  - Rename symbol
;; C-c l f  - Format buffer/region
;; C-c l h  - Show documentation at point
;; C-c l a  - Execute code action
;; C-c l d  - Find declaration
;; C-c l i  - Find implementation
;; C-c l T  - Toggle lsp-ui sideline

;; Company mode:
;; M-n / M-p - Select next/previous candidate
;; RET / TAB - Complete common or select

;;;;;;;;;;;;;;;;;;;;;;;;
;; evil configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; Install and configure Evil
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)      ; important for evil-collection
  :config
  (evil-mode 1)

  ;; Custom "jk" to escape insert mode
  (define-key evil-insert-state-map (kbd "j") 
	      (lambda () (interactive)
		(let ((next-key (read-event "j")))
		  (if (and (characterp next-key) (char-equal next-key ?k))
		      (evil-normal-state)
		    (insert "j")
		    (setq unread-command-events (list next-key)))))))

;; Evil Collection for better integration with other modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion and Navigation ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Enable vertico
(use-package vertico
  :custom
  (enable-recursive-minibuffers t)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode +1))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init (marginalia-mode))


;; Example configuration for Consult
(use-package consult
  :bind (("C-c M-x" . consult-mode-command)
	 ("C-c h" . consult-history)
         ("C-x C-r" . consult-recent-file)
         ([remap Info-search] . consult-info)
         ("C-x b" . consult-buffer)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
	 ("C-x t c" . consult-theme)
         ("M-y" . consult-yank-pop)
         ("M-g M-g" . consult-goto-line)
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package embark
  :bind
  (("C-," . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;;;;;;;;;;;;;;;;;;;;;;
;; UTILITY FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;;

(defun consult-switch-buffer-kill ()
  "Kill candidate buffer at point within the minibuffer completion."
  (interactive)
  (let ((name  (substring (vertico--candidate) 0 -1)))
    (when (bufferp (get-buffer name))
      (kill-buffer name))))


;;;;;;;;;;;;;
;; KEYMAPS ;;
;;;;;;;;;;;;;

(global-set-key (kbd "<f2>") 'menu-bar-mode)
(global-set-key (kbd "<f5>") 'consult-theme)
(global-set-key (kbd "<f7>") (lambda () (interactive) (consult-theme 'solarized-dark)))
(global-set-key (kbd "<f8>") (lambda () (interactive) (consult-theme 'solarized-light)))
;; improved completion defaults
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key [remap list-buffers] 'ibuffer)
;; window and frame management 
(global-set-key (kbd "M-n") 'scroll-up-command)
(global-set-key (kbd "M-p") 'scroll-down-command)
(global-set-key (kbd "C-x t f") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-x t m") 'toggle-frame-maximized)

(keymap-set minibuffer-local-map "C-k" 'consult-switch-buffer-kill)

(provide 'init)
;;; init.el ends here
