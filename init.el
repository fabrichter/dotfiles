(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
(setq use-package-always-ensure t)
;(setq
; backup-by-copying t      ; don't clobber symlinks
; backup-directory-alist
;j '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
; delete-old-versions t
; kept-new-versions 6
; kept-old-versions 2
; version-control t)
;(setq-default indent-tabs-mode nil)

(use-package fontawesome)
(use-package powerline
  :config 
  (powerline-evil-center-color-theme)
  )
(use-package linum
  :config
  ;(set-face-attribute 'linum nil :height 10)
  (add-hook 'prog-mode-hook 'linum-mode)
  )
(setq auto-mode-alist (cons '(".*\\.pl$" . prolog-mode) auto-mode-alist))
(use-package evil
  :config
  (add-hook 'text-mode-hook 'evil-local-mode)
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
(use-package hiwin)
(use-package session
  :config
  (session-initialize))
                                        ; don't know if neccesarry
(set-frame-parameter (selected-frame) 'alpha '(95 85)) 
(add-to-list 'default-frame-alist '(alpha 95 85))
(defun zoom-font (size)
  "Increase font size without breaking things like text-scale-zoom"
  (interactive "nNew Font size: ")
  (set-face-attribute 'default nil :height size))
(defvar zoom-font-step 10)
(defcustom zoom-font-step 10 "Step for increasing/decreasing default font height")
(defun zoom-font-increase ()
  (interactive)
  (let ((size (face-attribute 'default :height)))
   (set-face-attribute 'default nil :height (+ size zoom-font-step))))
(defun zoom-font-decrease ()
  (interactive)
  (let ((size (face-attribute 'default :height)))
   (set-face-attribute 'default nil :height (- size zoom-font-step))))
(global-set-key (kbd "C-c f z") #'zoom-font)
(global-set-key (kbd "C-c f +") #'zoom-font-increase)
(global-set-key (kbd "C-c f -") #'zoom-font-decrease)

(defvar external-file-types (list "pdf" "mkv" "mp4" "avi"))
(defcustom external-file-types (list "pdf" "mkv" "mp4" "avi") "Files to open externally")
(defun emacs-or-external-viewer (file)
  (let ( (extensions (mapcar #'(lambda (ext) (concat "^.*\\." ext "$")) external-file-types)) )
    (find file extensions :test #'(lambda (f regex) (string-match-p regex file) ))
    )
  )

(defun sane-open-file (file)
  (if (emacs-or-external-viewer file)
      (helm-open-file-externally file)
    (helm-find-file-or-marked file)))
      
;(add-hook 'after-init-hook #'(lambda ()
;    (add-hook 'helm-after-initialize-hook #'(lambda () 
;        (helm-add-action-to-source "Execute command on file" #'sane-open-file helm-source-find-files 0)
;        (helm-add-action-to-source "Execute command on file" #'sane-open-file helm-source-locate 0)))))
    

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
   ("M-n" . bs-cycle-next)
   ("M-p" . bs-cycle-previous)
   )
  )
;; themes
(use-package gruvbox-theme :config (load-theme 'gruvbox t) )
(use-package magit :bind ("C-x g" . magit-status)) 
(use-package javadoc-lookup :config (javadoc-add-roots "/usr/share/doc/java8-openjdk/api") :bind (("C-h j" . javadoc-lookup)))
;(use-package company :config
;  (global-company-mode) )
;(use-package company-try-hard :config
; (global-set-key (kbd "M-<SPC>") #'company-try-hard)
; (define-key company-active-map (kbd "M-<SPC>") #'company-try-hard))
(defun my-ac-ispell-complete ()
  (interactive)
  (auto-complete (list ac-source-ispell)))
(global-set-key (kbd "C-M-i") #'my-ac-ispell-complete)
(defun enable-my-complete ()
  (interactive)
  (local-set-key (kbd "C-M-i") #'my-ac-ispell-complete))
(add-hook 'text-mode-hook #'enable-my-complete)
(add-hook 'prog-mode-hook #'enable-my-complete)
(add-hook 'TeX-mode-hook #'enable-my-complete)
(add-hook 'LaTeX-mode-hook #'enable-my-complete)
(add-hook 'org-mode-hook #'enable-my-complete)
(use-package auto-complete

  :config
  (global-auto-complete-mode 1) 
  (add-hook 'prolog-mode-hook #'auto-complete-mode)
  (add-hook 'org-mode-hook #'auto-complete-mode)
  (ac-config-default) 
  )
(use-package auto-complete-auctex)
(use-package ac-ispell :config
  (ac-ispell-setup))
;(use-packagesmartparens :config (smartparens-global-mode) (smartparens-strict-mode))
(auto-save-mode)
(setq dired-guess-shell-alist-user '(
				     ("\\.pdf" "mupdf &")
				     ("\\.mp4" "mpv &")
				     ("\\.avi" "mpv &")
				     ("\\.mkv" "mpv &")))
(use-package yasnippet :config (yas-global-mode 1))
(use-package rainbow-delimiters :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(add-hook 'prog-mode-hook 'evil-surround-mode)
(use-package org)
(use-package ox-reveal)
(use-package flyspell)
(use-package projectile :config (projectile-global-mode))
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
(global-set-key (kbd "C-x +") 'start-fish)

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
 '(default ((t (:inherit nil :stipple nil :background "#282828" :foreground "#fdf4c1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "PfEd" :family "Fantasque Sans Mono"))))
 '(hiwin-face ((t (:background "gray20")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(ac-auto-show-menu 0.5)
 '(ac-auto-start t)
 '(ac-ispell-requires 7)
 '(async-shell-command-buffer (quote rename-buffer))
 '(backup-by-copying t)
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/saves"))))
 '(delete-old-versions t)
 '(display-buffer-alist
   (quote
    ((".*Async Shell Command.*" display-buffer-no-window
      (nil)))))
 '(explicit-shell-file-name "/bin/fish")
 '(fringe-mode 0 nil (fringe))
 '(helm-default-external-file-browser "termite -d ")
 '(helm-external-programs-associations
   (quote
    (("avi" . "mpv")
     ("mp4" . "mpv")
     ("pdf" . "mupdf")
     ("mkv" . "mpv"))))
 '(helm-find-files-actions
   (quote
    (("Execute-command" . sane-open-file)
     ("Find File" . helm-find-file-or-marked)
     ("Find file in Dired" . helm-point-file-in-dired)
     ("View file" . view-file)
     ("Checksum File" . helm-ff-checksum)
     ("Query replace fnames on marked" . helm-ff-query-replace-on-marked)
     ("Query replace contents on marked" . helm-ff-query-replace)
     ("Query replace regexp contents on marked" . helm-ff-query-replace-regexp)
     ("Serial rename files" . helm-ff-serial-rename)
     ("Serial rename by symlinking files" . helm-ff-serial-rename-by-symlink)
     ("Serial rename by copying files" . helm-ff-serial-rename-by-copying)
     ("Open file with default tool" . helm-open-file-with-default-tool)
     ("Find file in hex dump" . hexl-find-file)
     ("Browse project" . helm-ff-browse-project)
     ("Complete at point `C-c i'" . helm-insert-file-name-completion-at-point)
     ("Insert as org link `C-c @'" . helm-files-insert-as-org-link)
     ("Find shell command `C-c /'" . helm-ff-find-sh-command)
     ("Add marked files to file-cache" . helm-ff-cache-add-file)
     ("Open file externally `C-c C-x, C-u to choose'" . helm-open-file-externally)
     ("Grep File(s) `C-s, C-u Recurse'" . helm-find-files-grep)
     ("Grep current directory with AG" . helm-find-files-ag)
     ("Git grep" . helm-ff-git-grep)
     ("Zgrep File(s) `M-g z, C-u Recurse'" . helm-ff-zgrep)
     ("Gid" . helm-ff-gid)
     ("Switch to Eshell `M-e'" . helm-ff-switch-to-eshell)
     ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
     ("Eshell command on file(s) `M-!, C-u take all marked as arguments.'" . helm-find-files-eshell-command-on-file)
     ("Find file as root `C-c r'" . helm-find-file-as-root)
     ("Find alternate file" . find-alternate-file)
     ("Ediff File `C-c ='" . helm-find-files-ediff-files)
     ("Ediff Merge File `M-='" . helm-find-files-ediff-merge-files)
     ("Delete File(s) `M-D'" . helm-delete-marked-files)
     ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
     ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
     ("Backup files" . helm-find-files-backup)
     ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
     ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
     ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
     ("Find file other window `C-c o'" . helm-find-files-other-window)
     ("Switch to history `M-p'" . helm-find-files-switch-to-hist)
     ("Find file other frame `C-c C-o'" . find-file-other-frame)
     ("Print File `C-c p, C-u to refresh'" . helm-ff-print)
     ("Locate `C-x C-f, C-u to specify locate db'" . helm-ff-locate))))
 '(helm-raise-command nil)
 '(helm-type-file-actions
   (quote
    (("Execute command on file" . sane-open-file)
     ("Find file" . helm-find-many-files)
     ("Find file as root" . helm-find-file-as-root)
     ("Find file other window" . helm-find-files-other-window)
     ("Find file other frame" . find-file-other-frame)
     ("Open dired in file's directory" . helm-open-dired)
     ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
     ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
     ("Pdfgrep File(s)" . helm-ff-pdfgrep)
     ("Insert as org link" . helm-files-insert-as-org-link)
     ("Checksum File" . helm-ff-checksum)
     ("Ediff File" . helm-find-files-ediff-files)
     ("Ediff Merge File" . helm-find-files-ediff-merge-files)
     ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
     ("View file" . view-file)
     ("Insert file" . insert-file)
     ("Add marked files to file-cache" . helm-ff-cache-add-file)
     ("Delete file(s)" . helm-delete-marked-files)
     ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
     ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
     ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
     ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
     ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
     ("Open file externally (C-u to choose)" . helm-open-file-externally)
     ("Open file with default tool" . helm-open-file-with-default-tool)
     ("Find file in hex dump" . hexl-find-file))))
 '(hiwin-mode t)
 '(indent-tabs-mode nil)
 '(initial-buffer-choice (quote eshell))
 '(ispell-complete-word-dict "/home/fabian/.emacs.d/dict")
 '(javadoc-lookup-completing-read-function completing-read-function)
 '(kept-new-versions 6)
 '(menu-bar-mode nil)
 '(org-cycle-global-at-bob t)
 '(org-html-inline-images nil)
 '(org-reveal-root ".")
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(session-use-package t nil (session))
 '(tool-bar-mode nil)
 '(version-control t)
 '(zoom-font-step 20))
