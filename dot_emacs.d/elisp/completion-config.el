(use-package evil
  :ensure t
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll 1)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package enhanced-evil-paredit
  :ensure t
  :config
  (add-hook 'paredit-mode-hook #'enhanced-evil-paredit-mode))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode +1))
