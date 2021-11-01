(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil) t
      (evil-collection-init))
(evil-mode 1)

(evil-set-leader 'normal (kbd "SPC"))


(evil-define-key 'normal 'global (kbd "<leader>bb") 'ivy-switch-buffer)
(evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>pf") 'counsel-fzf)
(evil-define-key 'normal 'global (kbd "<leader>s") 'counsel-rg)
(evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg)

(evil-define-key 'normal 'global (kbd "<leader>1") 'winum-select-window-1)
(evil-define-key 'normal 'global (kbd "<leader>2") 'winum-select-window-2)
(evil-define-key 'normal 'global (kbd "<leader>3") 'winum-select-window-3)
(evil-define-key 'normal 'global (kbd "<leader>4") 'winum-select-window-4)
(evil-define-key 'normal 'global (kbd "<leader>5") 'winum-select-window-5)
(evil-define-key 'normal 'global (kbd "<leader>6") 'winum-select-window-6)
(evil-define-key 'normal 'global (kbd "<leader>7") 'winum-select-window-7)
(evil-define-key 'normal 'global (kbd "<leader>8") 'winum-select-window-8)
(evil-define-key 'normal 'global (kbd "<leader>9") 'winum-select-window-9)
(evil-define-key 'normal 'global (kbd "<leader>0") 'winum-select-window-0-or-10)

(with-eval-after-load 'evil
  (with-eval-after-load 'company
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil)
    (evil-define-key nil company-active-map (kbd "C-n") #'company-select-next)
    (evil-define-key nil company-active-map (kbd "C-p") #'company-select-previous)
    (evil-define-key nil company-active-map (kbd "C-j") #'company-select-next)
    (evil-define-key nil company-active-map (kbd "C-k") #'company-select-previous)
    ))

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

(setq org-preview-latex-default-process 'dvisvgm)

(defun my-org-latex-yas()
  (yas-minor-mode)
  (yas-activate-extra-mode 'latex-mode))
(add-hook 'org-mode-hook #'my-org-latex-yas)

(setq company-minimum-prefix-length 2
      company-idle-delay 0.0)
;; ;;(setq gc-cons-threshold 100000000)
;; (setq read-process-output-max (*1024 1024))
;; (setq lsp-idle-delay 0.5)
;; (setq lsp-ui-sideline-delay 0.5)
;; (setq lsp-ui-doc-delay 0.5)



;; (use-package org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "/lib/node_mo;; dules/mathjax-node-cli/bin/tex2svg"))

;; centaur tabs
;; (require 'centaur-tabs)
;; (centaur-tabs-mode t)
;; (global-set-key (kbd "C-<left>")  'centaur-tabs-backward)
;; (global-set-key (kbd "C-<right>") 'centaur-tabs-forward)

;; C-x C-f disable posframe mode
;;(ivy-posframe-mode 0)
(require 'winum)
(winum-mode)
(require 'org-download)


;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)


;;(desktop-save-mode t)

;;(setq lsp-csharp-server-install "/usr/share/omnisharp-roslyn")
(setq lsp-csharp-server-path "/usr/bin/omnisharp")
(require 'dap-netcore)
(add-hook 'pdf-view-mode '(pdf-view-midnight-minor-mode 0))

;; pdf-tools

(if
    (string-match "Microsoft"
                  (with-temp-buffer (shell-command "uname -r" t)
                                    (goto-char (point-max))
                                    (delete-char -1)
                                    (buffer-string)))
    (load "~/.centaurCustom/rime.el")
  (message "Not running under Linux subsystem for Windows")
  )
