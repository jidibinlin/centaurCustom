(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package storybook-theme
  :demand
  :straight (storybook-theme :type git :host github :repo "DogLooksGood/storybook-theme")
  )

(use-package printed-theme
  :demand
  :straight (printed-theme :type git :host github :repo "jidibinlin/printed-theme")
  )

(use-package evil
  :init
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  :demand t
  :config
  (evil-mode 1)

  (use-package evil-collection
    :after evil
    :demand t
    :ensure t
    :config
    (evil-collection-init)
    )

  (use-package evil-surround
    :demand t
    :config
    (global-evil-surround-mode 1))

  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>ps") 'counsel-projectile-rg)
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


(use-package go-mode
  :config
  (evil-collection-define-key 'normal 'go-mode-map (kbd "gd") #'lsp-ui-peek-find-definitions)
  (evil-collection-define-key 'normal 'go-mode-map (kbd "gr") #'lsp-ui-peek-find-references)
  )

(use-package company
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0)
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
      (evil-define-key nil company-active-map (kbd "<return>") #'company-complete-selection)
      ))
  )

(use-package org
  :ensure
  :custom
  (org-preview-latex-default-process 'dvipng)
  ;;(org-superstar-headline-bullets-list '( "???" "???" "???" "???" "???" "???" "???" "???" "???" "???" "???" "???" "???"))
  (org-format-latex-options
   '(:foreground default
     :background default
     :scale 1.5
     :html-foreground "Black"
     :html-background "Transparent"
     :html-scale 1.0
     :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (org-num-skip-footnotes t)

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
  :hook (
         (org-mode . my-org-latex-yas)
         (org-mode . org-num-mode)
         )

  :config
  (use-package evil-org
    :ensure t
    :after (:any org org-agenda)
    :init
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys)
    :hook (
           ;;(org-mode . org-superstar-mode)
           (org-mode . evil-org-mode)
           )
    )
  (use-package valign
    :after (org)
    :custom
    (valign-fancy-bar t)
    :hook (org-mode . valign-mode)
    )
  ;; make yasnippet for latex
  (defun my-org-latex-yas()
    (yas-minor-mode)
    (yas-activate-extra-mode 'latex-mode))
  (push	'(lisp . t) load-language-list)
  (org-babel-do-load-languages 'org-babel-load-languages load-language-list)
  (setq org-babel-lisp-eval-fn #'sly-eval)
  )

(use-package common-lisp-snippets
  )


(use-package ace-window
  :config
  (evil-define-key 'normal 'global (kbd "<leader>w") 'ace-window))

(use-package org-download
  ;;:ensure t
  :config
  :hook ((org-mode dired-mode) . org-download-enable)
  )

(use-package dap-mode
  :hook((c++-mode . (lambda () (require 'dap-cpptools)))
        (go-mode . (lambda () (require 'dap-go))))
  :custom
  (dap-auto-configure-features '(sessions locals controls breakpoints))
  ;; :config
  ;; (setq dap-auto-configure-features '(sessions locals controls tooltip))
  )

(use-package sly
  :config
  (setq inferior-lisp-program "/opt/homebrew/bin/sbcl")
  (setq sly-contribs '(sly-fancy))
  (evil-collection-define-key 'normal 'sly-mode-map (kbd "gd") #'sly-edit-definition)
  (evil-collection-define-key 'normal 'sly-mode-map (kbd "gr") #'sly-who-references)
  (evil-collection-define-key 'normal 'sly-mode-map (kbd "K") #'sly-describe-symbol)
  (evil-collection-define-key 'normal 'sly-mode-map (kbd "gz") #'sly-mrepl)
  (evil-collection-define-key 'normal 'sly-mode-map (kbd "c-t") #'sly-pop-find-definition-stack)
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
  (doom-modeline-buffer-file-name-style 'relative-from-project)
  (doom-modeline-window-width-limit fill-column)
  (doom-modeline-height 12)
  (doom-modeline-unicode-fallback t)
  (doom-modeline-hud t)
  )

(use-package lispy
  :after (:any lisp-mode emacs-lisp-mode lisp-interaction-mode)
  :hook((lisp-mode emacs-lisp-mode lisp-interaction-mode) . lispy-mode)
  )


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
  ;; (setf (alist-get t ivy-posframe-display-functions-alist)
  ;;       #'ivy-posframe-display-at-frame-top-center)
  (setf (alist-get t ivy-posframe-display-functions-alist)
        #'ivy-posframe-display-at-frame-center)
  )

(use-package magit
  :config
  (defun ediff-copy-both-to-C ()
    (interactive)
    (ediff-copy-diff ediff-current-difference nil 'C nil
                     (concat
                      (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                      (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
  (defun add-upper-b-to-ediff-mode-map () (define-key ediff-mode-map "B" 'ediff-copy-both-to-C))
  (add-hook 'ediff-keymap-setup-hook 'add-upper-b-to-ediff-mode-map)
  )

;; (use-package rime
;;   :custom
;;   (default-input-method "rime")
;;   (rime-show-candidate 'posframe)
;;   (rime-disable-predicates
;;    '(rime-predicate-evil-mode-p
;;      rime-predicate-after-alphabet-char-p
;;      rime-predicate-prog-in-code-p
;;      rime-predicate-current-input-punctuation-p)
;;    )

;;   :config
;;   (define-key rime-mode-map (kbd "M-j") 'rime-force-enable)
;;   )


(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :hook (prog-mode . copilot-mode)
  :config
  (define-key company-active-map (kbd "C-w") nil)
  (evil-define-key 'insert 'company-active-map (kbd "C-w") 'copilot-accept-completion-by-word)
  (evil-define-key 'insert 'company-active-map (kbd "C-c") 'copilot-accept-completion)
  (evil-define-key 'insert 'company-active-map (kbd "C-l") 'copilot-accept-completion-by-line)
  )

(load-file "~/.centaurCustom/luna.el")
