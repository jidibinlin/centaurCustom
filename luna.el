(defun make-and-run-luna ()
  "make and run luna game"
  (interactive)
  (start-process-shell-command "luna_game" (get-buffer "*Messages*") "alacritty -e /opt/luna_server/game/makeGame.sh"))

(defun run-luna()
  "run luna without build"
  (interactive)
  (start-process-shell-command "luna_game" (get-buffer "*Messages*") "alacritty -e /opt/luna_server/game/runluna.sh")
  )

(defun release-luna (release-type needExportCfg)
  "release the luna game"
  (interactive
   (list
    (read-string "release-type: ")
    (read-string "need export config?: ")))

  (let ((rt release-type)
        (nec nil)
        (release))
    (when (not (string= needExportCfg ""))
      (setq nec "exportCfg"))
    (setq release (concat "alacritty -e ~/.local/bin/release.sh " rt " " nec))
    ;;(async-start (shell-command release) 'ignore)
    (start-process-shell-command "luna_pack" "*Messages*" release))
  )

(defun proto-gen ()
  "update the luna proto file"
  (interactive)
  ;;(async-start (shell-command-to-string "bash ~/.local/bin/genProto.sh") 'ignore)
  (start-process-shell-command "gen_proto" (get-buffer "*Messages*") "bash ~/.local/bin/genProto.sh"))

(defun update-luna-client ()
  "update the luna client"
  (interactive)
  (start-process-shell-command "update-client" (get-buffer "*Messages*") "cd ~/Data/luna/master/LunaProject && svn update"))

(defun update-luna-config ()
  "svn update the luna config"
  (interactive)
  (start-process-shell-command "update-config" (get-buffer "*Messages*") "cd ~/Data/luna_word/luna_word_master/99_配置表/ && svn update"))
