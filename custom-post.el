(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :demand t
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'ivy-switch-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'counsel-fzf)
  (evil-define-key 'normal 'global (kbd "<leader>s") 'counsel-rg)
  ;;(evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg)
  (evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg-ignore-log)

  (with-eval-after-load 'evil
    (with-eval-after-load 'company
      (define-key evil-insert-state-map (kbd "C-n") nil)
      (define-key evil-insert-state-map (kbd "C-p") nil)
      (evil-define-key nil company-active-map (kbd "C-n") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-p") #'company-select-previous)
      (evil-define-key nil company-active-map (kbd "C-j") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-k") #'company-select-previous)
      ))
  )


(use-package evil-collection
  :ensure t
  :demand t
  :after evil
  :config
  (evil-collection-init)
  )

(defun counsel-projectile-rg-ignore-log ()
  "for company x4 project ignore the log directory when use rg searching"
  (interactive)
  (counsel-projectile-rg "-g !log/ -g !logic_log/ -g !res/proto/ -g !/res/mapData/ -g !/res/all_config/ -g !*.conf")
  )

;; (use-package evil-org
;;   :demand t
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook 'evil-org-mode)
;;   (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
;;   )
;; (require 'evil-org-agenda)
;; (evil-org-agenda-set-keys)

(use-package evil-org
  :ensure t
  :after (:any org org-agenda)
  :init
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  :hook ((org-mode . 'evil-org-mode)
         (org-mdoe . 'org-superstar-mode)
         )
  )

(setq org-preview-latex-default-process 'dvisvgm)

;; (defun my-org-latex-yas()
;;   (yas-minor-mode)
;;   (yas-activate-extra-mode 'latex-mode)) (add-hook 'org-mode-hook #'my-org-latex-yas)

(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0.0)

;; (use-package org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "/lib/node_mo;; dules/mathjax-node-cli/bin/tex2svg"))
:win
;; centaur tabs
;; (require 'centaur-tabs)
;; (centaur-tabs-mode t)
;; (global-set-key (kbd "C-<left>")  'centaur-tabs-backward)
;; (global-set-key (kbd "C-<right>") 'centaur-tabs-forward)

;; C-x C-f disable posframe mode
;;(ivy-posframe-mode 0)

(use-package winum
  :demand t
  :ensure t
  :config
  (winum-mode t)
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
  )

(use-package org-download
  :ensure t
  :config
  :hook ((org-mode dired-mode) . org-download-enable)
  )

;;(desktop-save-mode t)

;; evil-surround
(use-package evil-surround
  :ensure t
  :demand t
  :config
  (global-evil-surround-mode 1))

(use-package laas
  :ensure t
  :hook (LaTeX-mode . laas-mode)
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
                    "supp" "\\supp"
                    "On" "O(n)"
                    "O1" "O(1)"
                    "Olog" "O(\\log n)"
                    "Olon" "O(n \\log n)"
                    ;; bind to functions!
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

;;(setq lsp-csharp-server-install "/usr/share/omnisharp-roslyn")
(setq lsp-csharp-server-path "/usr/bin/omnisharp")

(if
    (string-match "Microsoft"
                  (with-temp-buffer (shell-command "uname -r" t)
                                    (goto-char (point-max))
                                    (delete-char -1)
                                    (buffer-string)))
    (load "~/.centaurCustom/rime.el")
  (message "Not running under Linux subsystem for Windows")
  )

;; set the posframe position to the screen center
(defun ivy-posframe-display-at-frame-center(str)
  (ivy-posframe--display str #'posframe-poshandler-frame-center)
  )
(setf (alist-get t ivy-posframe-display-functions-alist)
      #'ivy-posframe-display-at-frame-center)
