(defun make-and-run-luna ()
  "make and run luna game"
  (interactive)
  (async-start (shell-command "cd /opt/luna_server/game && open -a Terminal.app /opt/luna_server/game/makeGame.sh"))
  )

(defun release-luna()
  "release the luna game"
  (interactive)
  (async-start (shell-command "open -a Terminal.app ~/.local/bin/release.sh")))
