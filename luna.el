(defun make-and-run-luna ()
  "make and run luna game"
  (interactive)
  (kill-luna)
  (sleep-for 2)
  (start-process-shell-command "luna_game" (get-buffer "*Messages*") "alacritty -e /opt/luna_server/game/makeGame.sh"))

(defun run-luna()
  "run luna without build"
  (interactive)
  (kill-luna)
  (sleep-for 2)
  (start-process "luna_game" (get-buffer "*Messages*") "alacritty" "-e" "/opt/luna_server/game/runluna.sh")
  )

(defun make-luna-server-list ()
  "build luna server vertion"
  (interactive)
  (start-process-shell-command "luna_game" (get-buffer "*Messages*") "alacritty -e /Users/qibinyang/.local/bin/makeGame.sh slt"))

(defun make-luna()
  "make luna game"
  (interactive)
  (start-process "luna_build" (get-buffer "*Messages*") "alacritty" "-e" "/Users/qibinyang/.local/bin/makeGame.sh")
  )


(setq luna_time "@2022-9-15 23:59:30")
(setq luna_run "/Users/qibinyang/Data/luna_time_test/luna_time_tast.ros")
(defun cycle-rank-test()
  "test luna game"
  (interactive)
  (kill-luna)
  (sleep-for 2)
  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game/makeGame.sh")

  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game2/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test2" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game2/makeGame.sh")

  ;; (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game3/game" "-t" luna_time)
  ;; (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game3/makeGame.sh")

  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game_center/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game_center/makeGame.sh")
  )

(defun open-rank3()
  "test luna game"
  (interactive)
  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game3/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game3/makeGame.sh")
  )

(defun cycle-rank-test-time ()
  "test luna game"
  (interactive)
  (start-process-shell-command "cycle_rank_test" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game/makeGame.sh")
  (start-process-shell-command "cycle_rank_test2" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game2/makeGame.sh")
  (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game_center/makeGame.sh")
  )


(defun kill-luna ()
  "kill all luna processes"
  (interactive)
  (start-process-shell-command "kill_luna" (get-buffer "*Messages*") "ps aux | awk '/[g]ame/ {print $2}' | xargs kill -9")
  (start-process-shell-command "kill_proxy" (get-buffer "*Message*") "ps aux | awk '/[p]roxy/ {print $2}' | xargs kill -9")
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
    (start-process-shell-command "luna_pack" (get-buffer "*Messages*") release))
  )

(defun release-luna-reg (release-type needExportCfg)
  "release the luna game for regist server test"
  (interactive
   (list
    (read-string "release-type: ")
    (read-string "need export config?: ")))

  (let ((rt release-type)
        (nec nil)
        (release))
    (when (not (string= needExportCfg ""))
      (setq nec "exportCfg"))
    (setq release (concat "alacritty -e ~/.local/bin/release_reg.sh " rt " " nec))
    ;;(async-start (shell-command release) 'ignore)
    (start-process-shell-command "luna_pack" (get-buffer "*Messages*") release)))

(defun release-luna-proxy (release-type)
  "release luna proxy"
  (interactive
   (list
    (read-string "release-type: ")))
  (let ((rt release-type)
        (release))
    (setq release (concat "alacritty -e ~/.local/bin/release_proxy.sh " rt))
    ;;(async-start (shell-command release) 'ignore)
    (start-process-shell-command "luna_proxy_release" (get-buffer "*Messages*") release)))

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

(setq luna-word-directory "~/Data/luna_word/luna_word_master/99_配置表/excel_config/")

(defun search-luna-word ()
  "Search luna master word directory"
  (interactive)
  (let ((default-directory luna-word-directory))
    (call-interactively #'counsel-find-file-extern))
  )

(defun open-proto-xlsx ()
  "Open proto explain filed for luna project"
  (interactive)
  (call-process "open" nil 0 nil (expand-file-name "~/Data/luna/master/tools/protobuf_cs/协议说明.xlsx")))

(defun open-proto-file ()
  (interactive)
  (find-file (expand-file-name "~/Data/luna/master/tools/protobuf_cs/proto/game.proto")))
