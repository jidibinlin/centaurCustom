(use-package evil
  ;;:ensure t
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
  (define-key c-mode-base-map (kbd "C-c C-c") 'comment-or-uncomment-region)

  (evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg)
  ;;(evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg-ignore-log)

  (with-eval-after-load 'evil
    (with-eval-after-load 'company
      (define-key evil-insert-state-map (kbd "C-n") nil)
      (define-key evil-insert-state-map (kbd "C-p") nil)
      (evil-define-key nil company-active-map (kbd "C-n") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-p") #'company-select-previous)
      (evil-define-key nil company-active-map (kbd "C-j") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-k") #'company-select-previous)
      ))


  :hook ((go-mode) . (lambda ()
                       (evil-define-key 'normal 'go-mode-map (kbd "gd") #'lsp-find-definition)
                       )
         )
  )

(use-package evil-collection
  ;;  :ensure t
  :demand t
  :after evil
  :config
  (evil-collection-init)
  )

(use-package olivetti
  :diminish
  :hook (org-mode . olivetti-mode)
  :bind ("<f7>" . olivetti-mode)
  :init (setq olivetti-body-width 0.85))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :init (setq org-superstar-headline-bullets-list '( "◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  )

(defun counsel-projectile-rg-ignore-log ()
  "for company x4 project ignore the log directory when use rg searching"
  (interactive)
  (counsel-projectile-rg "-g !log/ -g !.ccls-cache/")
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

;; (use-package evil-org
;;   :ensure t
;;   :after (:any org org-agenda)
;;   :init
;;   (require 'evil-org-agenda)
;;   (evil-org-agenda-set-keys)
;;   :hook (
;;          ;;(org-mode . 'evil-org-mode)
;;          (org-mode . 'org-superstar-mode)
;;          (org-mode . (lambda () evil-org-mode))
;;          )
;;   )


;; (defun my-org-latex-yas()
;;   (yas-minor-mode)
;;   (yas-activate-extra-mode 'latex-mode)) (add-hook 'org-mode-hook #'my-org-latex-yas)

(setq company-minimum-prefix-length 3)
(setq company-idle-delay 0.5)


;; (use-package org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :hook (org-mode . my-org-latex-yas)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "/lib/node_modules/mathjax-node-cli/bin/tex2svg"))

(use-package org
  :ensure
  :pretty-hydra
  ((:title (pretty-hydra-title "Org Template" 'fileicon "org" :face 'all-the-icons-green :height 1.1 :v-adjust 0.0)
    :color blue :quit-key "q")
   ("Basic"
    (("a" (hot-expand "<a") "ascii")
     ("c" (hot-expand "<c") "center")
     ("C" (hot-expand "<C") "comment")
     ("e" (hot-expand "<e") "example")
     ("E" (hot-expand "<E") "export")
     ("h" (hot-expand "<h") "html")
     ("l" (hot-expand "<l") "latex")
     ("n" (hot-expand "<n") "note")
     ("o" (hot-expand "<q") "quote")
     ("v" (hot-expand "<v") "verse"))
    "Head"
    (("i" (hot-expand "<i") "index")
     ("A" (hot-expand "<A") "ASCII")
     ("I" (hot-expand "<I") "INCLUDE")
     ("H" (hot-expand "<H") "HTML")
     ("L" (hot-expand "<L") "LaTeX"))
    "Source"
    (("s" (hot-expand "<s") "src")
     ("m" (hot-expand "<s" "emacs-lisp") "emacs-lisp")
     ("y" (hot-expand "<s" "python :results output") "python")
     ("p" (hot-expand "<s" "perl") "perl")
     ("r" (hot-expand "<s" "ruby") "ruby")
     ("S" (hot-expand "<s" "sh") "sh")
     ("g" (hot-expand "<s" "go :imports '\(\"fmt\"\)") "golang"))
    "Misc"
    (("u" (hot-expand "<s" "plantuml :file CHANGE.png") "plantuml")
     ("Y" (hot-expand "<s" "ipython :session :exports both :results raw drawer\n$0") "ipython")
     ("T" (yas-expand-snippet (yas-lookup-snippet "hugo_admonition")) "hugo_admonition")
     ("P" (progn
            (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
            (hot-expand "<s" "perl")) "Perl tangled")
     ("<" self-insert-command "ins"))))
  )


(use-package winum
  :demand t
  ;;  :ensure t
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
  ;;:ensure t
  :config
  :hook ((org-mode dired-mode) . org-download-enable)
  )

(use-package dap-mode
  :hook((c++-mode) . (lambda () (
                            require 'dap-cpptools
                            require 'dap-go
                            )))
  )

(use-package slime
  ;;  :ensure t
  :after (lisp-mode)
  ;; :init
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf))
  (setq inferior-lisp-program "sbcl")
  )

(use-package doom-modeline
  :config
  (setq doom-modeline-icon nil)
  )


(use-package lispy
  ;;  :ensure t
  :hook((lisp-mode) . (lambda () (lispy-mode 1)))
  )


;; evil-surround
(use-package evil-surround
  ;; :ensure t
  :demand t
  :config
  (global-evil-surround-mode 1))

(use-package laas
  ;;  :ensure t
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
(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox
  )

(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t)))
  :config
  (global-blamer-mode 1)
  )

;;(setq lsp-csharp-server-install "/usr/share/omnisharp-roslyn")
(setq lsp-csharp-server-path "/usr/bin/omnisharp")

;; set the posframe position to the screen center
(defun ivy-posframe-display-at-frame-center(str)
  (ivy-posframe--display str #'posframe-poshandler-frame-center)
  )
(defun ivy-posframe-display-at-frame-top-center(str)
  (ivy-posframe--display str #'posframe-poshandler-frame-top-center)
  )

(setf (alist-get t ivy-posframe-display-functions-alist)
      #'ivy-posframe-display-at-frame-top-center)


;;rime only for windows
(if
    (string-match "Microsoft"
                  (with-temp-buffer (shell-command "uname -r" t)
                                    (goto-char (point-max))
                                    (delete-char -1)
                                    (buffer-string)))
    (load "~/.centaurCustom/rime.el")
  (message "Not running under Linux subsystem for Windows"))

;;(load "~/.centaurCustom/rime.el")
