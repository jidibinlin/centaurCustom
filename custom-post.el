(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil) t
      (evil-collection-init))
(evil-mode 1)

(evil-set-leader 'normal (kbd "SPC"))

(evil-define-key 'normal 'global (kbd "<leader>bb") 'ivy-switch-buffer)

(evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)
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

(setq company-minimum-prefix-length 3
      company-idle-delay 0.5)
;;(setq gc-cons-threshold 100000000)
(setq read-process-output-max (*1024 1024))
(setq lsp-idle-delay 0.5)
(setq lsp-ui-sideline-delay 0.5)
(setq lsp-ui-doc-delay 0.5)



;; (use-package org-latex-impatient
;;   :defer t
;;   :hook (org-mode . org-latex-impatient-mode)
;;   :init
;;   (setq org-latex-impatient-tex2svg-bin
;;         ;; location of tex2svg executable
;;         "/lib/node_modules/mathjax-node-cli/bin/tex2svg"))


(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<left>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<right>") 'centaur-tabs-forward)
;;(desktop-save-mode t)





;; 任何配置都应该放在这个前面
(use-package rime
  :custom
  (default-input-method "rime"))
(setq rime-show-candidate 'posframe)
(define-key rime-mode-map (kbd "M-j") 'rime-force-enable)

(setq rime-disable-predicates
      '(rime-predicate-evil-mode-p
        rime-predicate-after-alphabet-char-p
        rime-predicate-prog-in-code-p
        rime-predicate-current-input-punctuation-p
        ))
(add-hook 'text-mode-hook
          (lambda ()
            (variable-pitch-mode 1)))
