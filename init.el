(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
(setq use-package-always-ensure t)
(use-package powerline
  :config 
  (powerline-evil-center-color-theme)
  )
(use-package yalinum
  :config
;(set-face-attribute 'yalinum-face nil :height 110)
(add-hook 'prog-mode-hook 'yalinum-mode)
  )
(setq auto-mode-alist (cons '(".*\\.pl$" . prolog-mode) auto-mode-alist))
(use-package evil
  :config
    (add-hook 'prog-mode-hook 'evil-local-mode)
    (define-key evil-insert-state-map "\C- " 'evil-local-mode)
    (define-key evil-normal-state-map "\C- " 'evil-local-mode)
  :bind
    (("C-<SPC>" . evil-local-mode))
  )
(use-package evil-surround :config (global-evil-surround-mode 1))
(use-package evil-matchit :config (global-evil-matchit-mode 1))
(use-package evil-easymotion :config (evilem-default-keybindings "SPC"))
(use-package hiwin :config (hiwin-mode 1)
  )
(use-package session
  :config
  (session-initialize))
; don't know if neccesarry
(set-frame-parameter (selected-frame) 'alpha '(95 85)) 
(add-to-list 'default-frame-alist '(alpha 95 85))
(defun switch-to-previous-buffer ()
    (interactive)
    (switch-to-buffer (other-buffer (current-buffer) 1))
)
(global-set-key (kbd "M-o") 'switch-to-previous-buffer)
(use-package helm
  :config
    (helm-mode 1)
    :bind
    (
     ("C-x C-f" . helm-find-files)
     ("M-x" . helm-M-x)
     ("C-x b" . helm-buffers-list)
     ("C-x C-l" . helm-locate)
     )
  )
(use-package color-theme-monokai :config (color-theme-monokai))
 (use-package magit :bind ("C-x g" . magit-status))
(use-package company :config
  (global-company-mode) 
  (add-to-list 'company-backends 'company-latex-commands)
  (add-to-list 'company-backends 'company-ispell))
;(use-package smartparens :config (smartparens-global-mode) (smartparens-strict-mode))
(auto-save-mode)
(setq dired-guess-shell-alist-user '(
				     ("\\.pdf" "mupdf &")
				     ("\\.mp4" "mpv &")
				     ("\\.mkv" "mpv &")))
(use-package yasnippet :config (yas-global-mode 1))
(use-package rainbow-delimiters :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(add-hook 'prog-mode-hook 'evil-surround-mode)
;(require 'projectile)
;(projectile-global-mode)
;(require 'helm-projectile)
;(helm-projectile)
;(require 'flycheck)

 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(yalinum-bar-face ((t (:background "gray20" :foreground "gray85" :height 120))))
 '(yalinum-face ((t (:background "black" :foreground "gray70" :height 120))))
 '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "PfEd" :family "Meslo LG S Regular"))))
 '(company-preview ((t (:background "black" :foreground "gold"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "gold"))))
 '(company-preview-search ((t (:inherit company-preview :background "white"))))
 '(company-tooltip ((t (:background "black" :foreground "gold")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(async-shell-command-buffer (quote rename-buffer))
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files company-dabbrev-code company-gtags company-etags company-keywords company-oddmuse company-dabbrev company-ispell company-latex-commands)))
 '(company-idle-delay 0.2)
 '(display-buffer-alist
   (quote
    ((".*Async Shell Command.*" display-buffer-no-window
      (nil)))))
 '(explicit-shell-file-name "/bin/zsh")
 '(fringe-mode 0 nil (fringe))
 '(helm-adaptive-history-length 1000)
 '(helm-adaptive-mode t nil (helm-adaptive))
 '(initial-buffer-choice (quote eshell))
 '(ispell-complete-word-dict "/home/fabian/.emacs.d/dict")
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(session-use-package t nil (session))
 '(tool-bar-mode nil))
