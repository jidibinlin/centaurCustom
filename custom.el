;;; custom.el --- user customization file    -*- lexical-binding: t no-byte-compile: t -*-
;;; Commentary:
;;;       Add or change the configurations in custom.el, then restart Emacs.
;;;       Put your own configurations in custom-post.el to override default configurations.
;;; Code:


;; (setq centaur-logo nil)                        ; Logo file or nil (official logo)
(setq centaur-full-name "jidibinlin")           ; User full name
(setq centaur-mail-address "2694273649@qq.com")   ; Email address
;;(setq centaur-proxy "127.0.0.1:1087")          ; HTTP/HTTPS proxy
(setq centaur-socks-proxy "127.0.0.1:7890")    ; SOCKS proxy
(setq centaur-server t)                      ; Enable `server-mode' or not: t or nil
;;(setq centaur-icon nil)                        ; Display icons or not: t or nil
(setq centaur-package-archives 'melpa)         ; Package repo: melpa, emacs-china, netease, ustc, tencent or tuna
(setq centaur-theme 'default)                     ; Color theme: auto, random, system, default, pro, dark, light, warm, cold, day or night
(setq centaur-completion-style 'childframe)    ; Completion display style: minibuffer or childframe
;; (setq centaur-dashboard nil)                   ; Use dashboard at startup or not: t or nil
(setq centaur-restore-frame-geometry t)      ; Restore the frame's geometry at startup: t or nil
(setq centaur-lsp 'lsp-mode)                      ; Set LSP client: lsp-mode, eglot or nil
;; (setq centaur-lsp-format-on-save-ignore-modes '(c-mode c++-mode)) ; Ignore format on save for some languages
(setq centaur-chinese-calendar nil)              ; Use Chinese calendar or not: t or nil
;;(setq centaur-prettify-symbols-alist t)      ; Alist of symbol prettifications. Nil to use font supports ligatures.
(setq centaur-prettify-org-symbols-alist '(("[ ]" . ?☐)
                                           ("[X]" . ?☑)
                                           ("[-]" . ?⛝)

                                           ("#+ARCHIVE:" . ?📦)
                                           ("#+AUTHOR:" . ?👤)
                                           ("#+CREATOR:" . ?💁)
                                           ("#+DATE:" . ?📆)
                                           ("#+DESCRIPTION:" . ?⸙)
                                           ("#+EMAIL:" . ?📧)
                                           ("#+OPTIONS:" . ?⛭)
                                           ("#+SETUPFILE:" . ?⛮)
                                           ("#+TAGS:" . ?🏷)
                                           ("#+TITLE:" . ?📓)

                                           ("#+begin_src" . ?✎)
                                           ("#+end_src" . ?□)
                                           ("#+begin_quote" . ?»)
                                           ("#+end_quote" . ?«)
                                           ("#+headers" . ?☰)
                                           ("#+results:" . ?💻)))  ; Alist of symbol prettifications for `org-mode'
(setenv "INFOPATH" "/opt/homebrew/share/info")
(setenv "LSP_USE_PLISTS" "true")

;; For Emacs devel
;; (setq package-user-dir (locate-user-emacs-file (format "elpa-%s" emacs-major-version)))
;; (setq desktop-base-file-name (format ".emacs-%s.desktop" emacs-major-version))
;; (setq desktop-base-lock-name (format ".emacs-%s.desktop.lock" emacs-major-version))
;; Fonts
(setq org-roam-v2-ack t)
(when (display-graphic-p)
  ;; Set default font
  (cl-loop for font in '("DejaVu Sans Mono" "SFMono Nerd Font Mono" "SFMono Nerd Font"  "Hack" "Source Code Pro" "Fira Code" "Menlo" "Monaco" "Consolas")
           when (font-installed-p font)
           return (set-face-attribute 'default nil
                                      :font font
                                      :height (cond (sys/mac-x-p 150)
                                                    (sys/win32p 105)
                                                    (t 110))))

  ;; Specify font for all unicode characters
  (cl-loop for font in '("Symbol" "Symbola" "SFMono Nerd Font" "Apple Color Emoji" "Segoe UI Symbol")
           when (font-installed-p font)
           return(set-fontset-font t 'unicode font nil 'prepend))

  ;; Specify font for Chinese characters
  (cl-loop for font in '("WenQuanYi Micro Hei" "Microsoft Yahei")
           when (font-installed-p font)
           return (set-fontset-font t '(#x4e00 . #x9fff) font)))

;; Mail
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587
;;                                    user-mail-address nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; Calendar
;; Set location , then press `S' can show the time of sunrise and sunset
;; (setq calendar-location-name "Chengdu"
;;       calendar-latitude 30.67
;;       calendar-longitude 104.07)

;; Misc.
;; (setq confirm-kill-emacs 'y-or-n-p)

;; Enable proxy
;; (proxy-http-enable)
;; (proxy-socks-enable)

;; Display on the specified monitor
;; (when (and (> (length (display-monitor-attributes-list)) 1)
;;            (> (display-pixel-width) 1920))
;;   (set-frame-parameter nil 'left 1920))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-theme-directory "~/.emacs.d/themes")
 '(ignored-local-variable-values
   '((Package . USOCKET)
     (Syntax . ANSI-Common-lisp)
     (Base . 10)))
 '(pixel-scroll-mode t)
 '(vc-follow-symlinks t))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit font-lock-keyword-face :bold t :height 2.0))))
 '(aw-minibuffer-leading-char-face ((t (:inherit font-lock-keyword-face :bold t :height 1.0))))
 '(aw-mode-line-face ((t (:inherit mode-line-emphasis :bold t))))
 '(blamer-face ((t :foreground "#7a88cf" :background nil :height 140 :italic t)))
 '(cfrs-border-color ((t (:background "#5B6268"))))
 '(dashboard-heading ((t (:inherit (font-lock-string-face bold)))))
 '(diff-hl-change ((t (:foreground "#51afef" :background nil))))
 '(diff-hl-delete ((t (:inherit diff-removed :background nil))))
 '(diff-hl-insert ((t (:inherit diff-added :background nil))))
 '(doom-modeline-buffer-file ((t (:inherit (mode-line bold)))))
 '(flycheck-posframe-background-face ((t (:inherit tooltip))))
 '(flycheck-posframe-border-face ((t (:inherit posframe-border))))
 '(flycheck-posframe-face ((t (:foreground "#98be65"))))
 '(flycheck-posframe-info-face ((t (:foreground "#98be65"))))
 '(git-timemachine-minibuffer-author-face ((t (:inherit success))))
 '(git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
 '(hl-todo ((t (:inherit default :height 0.9 :width condensed :weight bold :underline nil :inverse-video t))))
 '(ivy-minibuffer-match-face-1 ((t (:foreground "#83898d"))))
 '(ivy-posframe ((t (:inherit tooltip))))
 '(ivy-posframe-border ((t (:inherit posframe-border))))
 '(lsp-headerline-breadcrumb-path-error-face ((t :underline (:style wave :color "#ff6c6b") :inherit lsp-headerline-breadcrumb-path-face)))
 '(lsp-headerline-breadcrumb-path-hint-face ((t :underline (:style wave :color "#98be65") :inherit lsp-headerline-breadcrumb-path-face)))
 '(lsp-headerline-breadcrumb-path-info-face ((t :underline (:style wave :color "#98be65") :inherit lsp-headerline-breadcrumb-path-face)))
 '(lsp-headerline-breadcrumb-path-warning-face ((t :underline (:style wave :color "#ECBE7B") :inherit lsp-headerline-breadcrumb-path-face)))
 '(lsp-headerline-breadcrumb-symbols-error-face ((t :inherit lsp-headerline-breadcrumb-symbols-face :underline (:style wave :color "#ff6c6b"))))
 '(lsp-headerline-breadcrumb-symbols-hint-face ((t :inherit lsp-headerline-breadcrumb-symbols-face :underline (:style wave :color "#98be65"))))
 '(lsp-headerline-breadcrumb-symbols-info-face ((t :inherit lsp-headerline-breadcrumb-symbols-face :underline (:style wave :color "#98be65"))))
 '(lsp-headerline-breadcrumb-symbols-warning-face ((t :inherit lsp-headerline-breadcrumb-symbols-face :underline (:style wave :color "#ECBE7B"))))
 '(lsp-ui-sideline-code-action ((t (:inherit warning))))
 '(macrostep-expansion-highlight-face ((t (:inherit tooltip :extend t))))
 '(org-ellipsis ((t (:foreground nil))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.2 :foreground "#FD971F"))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2 :foreground "#A6E22E"))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2 :foreground "#66D9EF"))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2 :foreground "#E6DB74"))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.2 :foreground "#A1EFE4"))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.2 :foreground "#A6E22E"))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.2 :foreground "#F92672"))))
 '(org-level-8 ((t (:inherit outline-8 :height 1.2 :foreground "#66D9EF"))))
 '(org-pomodoro-mode-line ((t (:inherit warning))))
 '(org-pomodoro-mode-line-break ((t (:inherit success))))
 '(org-pomodoro-mode-line-overtime ((t (:inherit error))))
 '(paradox-archive-face ((t (:inherit font-lock-doc-face))))
 '(paradox-description-face ((t (:inherit completions-annotations))))
 '(pulse-highlight-face ((t (:inherit region))))
 '(pulse-highlight-start-face ((t (:inherit region))))
 '(symbol-overlay-default-face ((t (:inherit (region bold)))))
 '(transient-posframe ((t (:inherit tooltip))))
 '(transient-posframe-border ((t (:inherit posframe-border))))
 '(which-key-posframe ((t (:inherit tooltip))))
 '(which-key-posframe-border ((t (:inherit posframe-border))))
 '(ztreep-arrow-face ((t (:inherit font-lock-comment-face))))
 '(ztreep-diff-header-face ((t (:inherit (diff-header bold)))))
 '(ztreep-diff-header-small-face ((t (:inherit diff-file-header))))
 '(ztreep-diff-model-add-face ((t (:inherit diff-nonexistent))))
 '(ztreep-diff-model-diff-face ((t (:inherit diff-removed))))
 '(ztreep-diff-model-ignored-face ((t (:inherit font-lock-doc-face :strike-through t))))
 '(ztreep-diff-model-normal-face ((t (:inherit font-lock-doc-face))))
 '(ztreep-expand-sign-face ((t (:inherit font-lock-function-name-face))))
 '(ztreep-header-face ((t (:inherit diff-header))))
 '(ztreep-leaf-face ((t (:inherit diff-index))))
 '(ztreep-node-face ((t (:inherit font-lock-variable-name-face)))))

;;; custom.el ends here
