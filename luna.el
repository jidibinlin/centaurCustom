

(defun ansi-color-after-scroll (window start)
  "Used by ansi-color-mode minor mode"
  (ansi-color-apply-on-region start (window-end window t) t))

(define-minor-mode ansi-color-mode
  "A very primitive minor mode to view log files containing ANSI color codes.

Pros: this minor mode runs `ansi-color-apply-on-region' lazily,
i.e. only the visible part of the buffer. Hence, it does NOT
freeze Emacs even if the log file is huge.

Cons: a) when the minor code is toggled off, it does not undo
what has already been ansi colorized. b) assumes the buffer
content etc. does not change. c) jumping to random places within
the buffer may incur incorrect/incomplete colorization.

How to install: put this code into your init.el, then evaluate it or
restart Emacs for the code to take effect.

How to use: in the log buffer of need run `M-x ansi-color-mode'.
Alternatively, feel free to enable this minor mode via mode hooks
so that you needn't enable it manually.

-- lgfang
"
  :global nil
  :lighter ""
  (when ansi-color-mode
    (progn
      ;; (ansi-color-apply-on-region (window-start) (window-end) t)
      ;; (add-hook 'window-scroll-functions 'ansi-color-after-scroll 80 t)
      (add-to-list 'after-change-functions 'ansi-color-apply-on-region)
      )))

(setq faketime "@2023-5-25 23:59:30")
(setq faketimetool "faketimer")
(setq faketimelibpath "/Users/qibinyang/Downloads/libfaketime/src/libfaketime.1.dylib")
(setq gameserver-path "/opt/jiugong/gameserver")
(setq fightserver-path "/opt/jiugong/fightsrv")

(defun restart-u3dgame-faketime ()
  "test luna game"
  (interactive)
  (kill-u3dgame)
  (start-process "u3dgame" nil "alacritty" "-e" faketimetool "-e" gameserver-path "-t" faketime "-l" faketimelibpath)
  )

(defun  restart-u3dgame ()
  "test luna game base on the time of now"
  (interactive)

  (kill-u3dgame)
  (let ((buffer (get-buffer-create "*u3dgame*"))
        (curtime (format-time-string "@%Y-%m-%d %H:%M:%S" (current-time))))

    (start-process "u3dgame" nil "alacritty" "-e" faketimetool "-e" gameserver-path "-t" curtime "-l" faketimelibpath)
    )
  )

(defun restart-u3dfight-faketime ()
  "test luna game"
  (interactive)

  (kill-u3dfight)
  (start-process "u3dfight" nil "alacritty" "-e" faketimetool "-e" fightserver-path "-t" faketime "-l" faketimelibpath))

(defun  restart-u3dfight ()
  "test luna game base on the time of now"
  (interactive)

  (kill-u3dfight)
  (let ((buffer (get-buffer-create "*u3dfight*"))
        (curtime (format-time-string "@%Y-%m-%d %H:%M:%S" (current-time))))
    (start-process "u3dfight" nil "alacritty" "-e" faketimetool "-e" fightserver-path "-t" curtime "-l" faketimelibpath)))

(defun restart-u3dserver()
  (interactive)
  (kill-u3dserver)
  (let ((buffer (get-buffer-create "*u3dfight*"))
        (curtime (format-time-string "@%Y-%m-%d %H:%M:%S" (current-time))))
    (start-process "u3dfight" nil "alacritty" "-e" faketimetool "-e" fightserver-path "-t" curtime "-l" faketimelibpath)
    (start-process "u3dgame" nil "alacritty" "-e" faketimetool "-e" gameserver-path "-t" curtime "-l" faketimelibpath)))

(defun restart-u3dserver-faketime ()
  "test luna game"
  (interactive)
  (kill-u3dserver)
  (start-process "u3dgame" nil "alacritty" "-e" faketimetool "-e" gameserver-path "-t" faketime "-l" faketimelibpath)
  (start-process "u3dfight" nil "alacritty" "-e" faketimetool "-e" fightserver-path "-t" faketime "-l" faketimelibpath))


(defun kill-u3dserver ()
  "kill all luna processes"
  (interactive)
  (call-process-shell-command "kill_gamesrv")
  (call-process-shell-command "kill_fightsrv"))

(defun kill-u3dgame ()
  (interactive)
  (call-process-shell-command "kill_gamesrv" nil nil))

(defun kill-u3dfight()
  (interactive)
  (call-process-shell-command "kill_fightsrv"))

(setq luna-word-directory "~/Data/luna_word/luna_word_master/99_配置表/excel_config/")

(defun search-luna-word ()
  "Search luna master word directory"
  (interactive)
  (let ((default-directory luna-word-directory))
    (call-interactively #'counsel-find-file-extern))
  )
