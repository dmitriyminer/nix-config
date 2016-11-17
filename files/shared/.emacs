;; Disable backup files.
(setq make-backup-files nil)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Set the fill column (for wrapping) to 72.
(setq-default fill-column 72)

;; Show the current column.
(setq column-number-mode t)

;; Set the load path for emacs.
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Set up fill column indicator.
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "grey80")
(setq-default fci-rule-character-color "green")
(add-hook 'after-change-major-mode-hook 'fci-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Load package-install sources.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(defvar my-packages
  '(;; Go stuff
    go-mode
    go-eldoc
    go-autocomplete

    ;; Markdown
    markdown-mode

    ;; Javascript
    json-mode

    ;; Env
    project-explorer
    smooth-scroll
    buffer-move
    window-number)
  "My packages!")

;; Fetch the list of packages available.
(unless package-archive-contents
  (package-refresh-contents))

;; Install the missing packages.
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Load Go-specific language syntax.
(defun go-mode-setup ()
  (go-eldoc-setup))

(add-hook 'go-mode-hook 'go-mode-setup)

;; Format before saving.
(defun go-mode-setup ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'go-mode-setup)

;; Goimports.
(defun go-mode-setup ()
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'go-mode-setup)

;; Godef, shows function definition when calling godef-jump.
(defun go-mode-setup ()
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;; Custom Compile Command.
(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v && go vet && golint && errcheck")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;; Load auto-complete.
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)

(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

;; Project Explorer.
(require 'project-explorer)
(global-set-key (kbd "M-e") 'project-explorer-toggle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (window-number buffer-move smooth-scroll project-explorer json-mode markdown-mode go-autocomplete go-eldoc go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
