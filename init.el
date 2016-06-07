(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
(setq use-package-always-ensure t)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)
(setq-default indent-tabs-mode nil)

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
(use-package evil-org)
(use-package hiwin :config (hiwin-mode 1)
  )
(use-package session
  :config
  (session-initialize))
                                        ; don't know if neccesarry
(set-frame-parameter (selected-frame) 'alpha '(95 85)) 
(add-to-list 'default-frame-alist '(alpha 95 85))
(use-package helm
  :config
  (helm-mode 1)
  :bind
  (
   ("C-x C-f" . helm-find-files)
   ("M-x" . helm-M-x)
   ("C-x b" . helm-buffers-list)
   ("C-x C-b" . helm-buffers-list)
   ("C-x C-l" . helm-locate)
   )
  )
(use-package color-theme-monokai :config (color-theme-monokai))
(use-package magit :bind ("C-x g" . magit-status))
;(use-package company :config
;  (global-company-mode) )
;(use-package company-try-hard :config
; (global-set-key (kbd "M-<SPC>") #'company-try-hard)
; (define-key company-active-map (kbd "M-<SPC>") #'company-try-hard))
(use-package auto-complete
  :config
  (global-auto-complete-mode 1)
  (ac-config-default))
(use-package auto-complete-auctex)
(use-package ac-ispell :config
  (ac-ispell-setup)
  (add-hook 'LaTeX-mode-hook 'ac-ispell-ac-setup)
  (add-hook 'org-mode-hook 'ac-ispell-ac-setup)
  )
;(use-packagesmartparens :config (smartparens-global-mode) (smartparens-strict-mode))
(auto-save-mode)
(setq dired-guess-shell-alist-user '(
				     ("\\.pdf" "mupdf &")
				     ("\\.mp4" "mpv &")
				     ("\\.mkv" "mpv &")))
(use-package yasnippet :config (yas-global-mode 1))
(use-package rainbow-delimiters :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(add-hook 'prog-mode-hook 'evil-surround-mode)
(use-package org)
(use-package ox-reveal)
(use-package flyspell)
(use-package projectile
  :config (projectile-global-mode)
  )
(use-package helm-projectile
  :config (helm-projectile-on))

;;; own functions
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1))
  )
(global-set-key (kbd "M-o") 'switch-to-previous-buffer)
(defun start-fish ()
  (interactive)
  (async-shell-command "termite -e /bin/fish")
  )
(global-set-key (kbd "M-<RET>") 'start-fish)

;;====== Switch to Root =================

(defadvice helm-find-files (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defadvice helm-locate (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudired ()
  (interactive)
  (require 'tramp)
  (let ((dir (expand-file-name default-directory)))
    (if (string-match "^/sudo:" dir)
        (user-error "Already in sudo")
      (dired (concat "/sudo::" dir)))))
(define-key dired-mode-map "#" 'sudired)


(use-package slime :config
(setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(slime-setup '(slime-fancy)))
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "PfEd" :family "Meslo LG S Regular"))))
 '(yalinum-bar-face ((t (:background "gray20" :foreground "gray85" :height 120))))
 '(yalinum-face ((t (:background "black" :foreground "gray70" :height 120)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(ac-auto-show-menu 0.5)
 '(ac-auto-start t)
 '(ac-dictionary-files (quote ("~/.dict")))
 '(async-shell-command-buffer (quote rename-buffer))
 '(display-buffer-alist
   (quote
    ((".*Async Shell Command.*" display-buffer-no-window
      (nil)))))
 '(explicit-shell-file-name "/bin/fish")
 '(fringe-mode 0 nil (fringe))
 '(initial-buffer-choice (quote eshell))
 '(ispell-complete-word-dict "/home/fabian/.emacs.d/dict")
 '(menu-bar-mode nil)
 '(org-html-inline-images nil)
 '(scroll-bar-mode nil)
 '(session-use-package t nil (session))
 '(tool-bar-mode nil))
