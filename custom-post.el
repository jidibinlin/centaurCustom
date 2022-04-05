(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :demand t
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg)

  (use-package evil-collection
    :demand t
    :after evil
    :config
    (evil-collection-init)
    )

  (use-package evil-surround
    :demand t
    :config
    (global-evil-surround-mode 1))
  )

(use-package counsel
  :after evil
  :config
  (evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'counsel-fzf)
  (evil-define-key 'normal 'global (kbd "<leader>s") 'counsel-rg)
  (evil-define-key 'normal 'global (kbd "<leader>im") 'counsel-imenu)
  )

(use-package ivy
  :config
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'ivy-switch-buffer)
  )

(use-package olivetti
  :diminish
  :hook (org-mode . olivetti-mode)
  :bind ("<f7>" . olivetti-mode)
  :init (setq olivetti-body-width 0.65)
  )

(use-package go-mode
  :hook ((go-mode) . (lambda ()(evil-define-key 'normal 'go-mode-map (kbd "gd") #'lsp-find-definition)
                       (evil-define-key 'normal 'go-mode-map (kbd "gr") #'lsp-find-references)))
  )

(use-package company
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.5)

  :config
  (with-eval-after-load 'evil
    (with-eval-after-load 'company
      (define-key evil-insert-state-map (kbd "C-n") nil)
      (define-key evil-insert-state-map (kbd "C-p") nil)
      (define-key company-active-map (kbd "<tab>") nil)
      (evil-define-key nil company-active-map (kbd "C-n") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-p") #'company-select-previous)
      (evil-define-key nil company-active-map (kbd "C-j") #'company-select-next)
      (evil-define-key nil company-active-map (kbd "C-k") #'company-select-previous)
      (evil-define-key nil company-active-map (kbd "<tab>") #'company-complete-selection)
      ))
  )

(use-package org
  :ensure
  :custom
  (org-preview-latex-default-process 'dvipng)
  (org-superstar-headline-bullets-list '( "◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-format-latex-options
   '(:foreground default
     :background default
     :scale 1.5
     :html-foreground "Black"
     :html-background "Transparent"
     :html-scale 1.0
     :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

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
  :hook (org-mode . my-org-latex-yas)

  :config
  (use-package evil-org
    :ensure t
    :after (:any org org-agenda)
    :init
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys)
    :hook (
           (org-mode . org-superstar-mode)
           (org-mode . evil-org-mode)
           )
    )
  (use-package valign
    :after (org)
    :hook (org-mode . valign-mode)
    )
  ;; make yasnippet for latex
  (defun my-org-latex-yas()
    (yas-minor-mode)
    (yas-activate-extra-mode 'latex-mode))
  )

(use-package winum
  :demand t
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
  :hook((c++-mode . (lambda () (require 'dap-cpptools)))
        (go-mode . (lambda () (require 'dap-go))))

  :config
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  )

(use-package slime
  :after (lisp-mode)
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf))
  )

(use-package lsp-mode
  :custom
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-position 'at-point)
  (lsp-eldoc-enable-hover nil)
  (warning-suppress-log-types '((lsp-mode)))
  (warning-suppress-types '((comp)))
  (lsp-csharp-server-path "/usr/bin/omnisharp")

  :config
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]cfg\\'")

  :hook(lsp-mode . lsp-headerline-breadcrumb-mode)
  )

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (inferior-lisp-program "sbcl")
  (doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-window-width-limit fill-column)
  (doom-modeline-height 12)
  (doom-modeline-unicode-fallback t)
  (doom-modeline-hud t)
  )

(use-package lispy
  :after (:any lisp-mode emacs-lisp-mode lisp-interaction-mode)
  :hook(
        (lisp-mode emacs-lisp-mode lisp-interaction-mode) . lispy-mode))


(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox
  )

(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 1)
  (blamer-min-offset 70)

  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t)))

  :config
  (global-blamer-mode 1)
  )

(use-package ivy-posframe
  :config
  ;; set the posframe position to the screen center
  (defun ivy-posframe-display-at-frame-top-center(str)
    (ivy-posframe--display str #'posframe-poshandler-frame-top-center)
    )

  (setf (alist-get t ivy-posframe-display-functions-alist)
        #'ivy-posframe-display-at-frame-top-center)
  )


(use-package rime
  :custom
  (default-input-method "rime")
  (rime-show-candidate 'posframe)
  (rime-disable-predicates
   '(rime-predicate-evil-mode-p
     rime-predicate-after-alphabet-char-p
     rime-predicate-prog-in-code-p
     rime-predicate-current-input-punctuation-p)
   )

  :config
  (define-key rime-mode-map (kbd "M-j") 'rime-force-enable)
  )
