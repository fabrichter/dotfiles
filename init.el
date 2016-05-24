(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
(require 'linum)
(set-face-attribute 'linum nil :height 110)
(require 'evil)
(global-set-key (kbd "C-<SPC>") 'evil-local-mode)
(global-set-key (kbd "M-<SPC>") 'execute-extended-command)
(require 'evil-surround)
(global-evil-surround-mode 1)
(require 'evil-matchit)
(global-evil-matchit-mode 1)
(require 'evil-easymotion)
(evilem-default-keybindings "SPC")
(require 'hiwin)
(hiwin-mode 1)
; don't know if neccesarry
(set-frame-parameter (selected-frame) 'alpha '(95 85)) 
(add-to-list 'default-frame-alist '(alpha 95 85))
(defun switch-to-previous-buffer ()
    (interactive)
    (switch-to-buffer (other-buffer (current-buffer) 1))
)
(global-set-key (kbd "M-o") 'switch-to-previous-buffer)
(define-key evil-insert-state-map "\C- " 'evil-local-mode)
(define-key evil-normal-state-map "\C- " 'evil-local-mode)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-l") 'helm-locate)
(require 'color-theme)
(require 'color-theme-monokai)
(color-theme-monokai)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-latex-commands)
(add-to-list 'company-backends 'company-ispell)
(require 'smartparens)
(add-hook 'after-init-hook 'smartparens-global-mode)
(add-hook 'after-init-hook 'smartparens-strict-mode)
(require 'helm)
(helm-mode 1)
(require 'helm-adaptive)
(helm-adaptive-mode 1)
(require 'powerline)
(powerline-evil-center-color-theme)
(auto-save-mode)
(setq dired-guess-shell-alist-user '(
				     ("\\.pdf" "mupdf &")
				     ("\\.mp4" "mpv &")
				     ("\\.mkv" "mpv &")))
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode 1)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'evil-local-mode)
(add-hook 'prog-mode-hook 'evil-surround-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
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
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files company-dabbrev-code company-gtags company-etags company-keywords company-oddmuse company-dabbrev company-latex-commands company-ispell)))
 '(company-idle-delay 0)
 '(display-buffer-alist
   (quote
    ((".*Async Shell Command.*" display-buffer-no-window
      (nil)))))
 '(explicit-shell-file-name "/bin/zsh")
 '(fringe-mode 0 nil (fringe))
 '(helm-adaptive-history-length 1000)
 '(helm-adaptive-mode t nil (helm-adaptive))
 '(initial-buffer-choice (quote eshell))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
