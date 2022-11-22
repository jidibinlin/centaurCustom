(defun mkluna (&optional dont-focus)
  "build luna"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))
(defun mkluna-full (&optional dont-focus)
  "build luna with export config generate model and proto"
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--client" "~/Data/luna/master/"
                 "--export_proto"

                 "--gen_model"

                 "--word" "~/Data/luna_word/luna_word_master/"
                 "--data" "/opt/cycle_test/game/data/"
                 "--word_tool" "~/Data/luna_export_tool/"

                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))

(defun mkluna-with-export-config (&optional dont-focus)
  "build luna with export config"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--word" "~/Data/luna_word/luna_word_master/"
                 "--data" "/opt/cycle_test/game/data/"
                 "--word_tool" "~/Data/luna_export_tool/"
                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))

(defun mkluna-with-gen-proto (&optional dont-focus)
  "build luna with gen proto"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--client" "~/Data/luna/master/"
                 "--export_proto"
                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))

(defun luna-genproto-cross-guild (&optional dont-focus)
  "generate proto specially for cross-guild branch"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--client" "~/Data/luna/master_guild/"
                 "--export_proto"
                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))

(defun mkluna-with-gen-model (&optional dont-focus)
  "build luna with gen model"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "game"
                 "--gen_model"
                 "--install" "/opt/luna_server/game/game"
                 "--project_root" "~/Data/luna_game/"))

(defun luna-genproto (&optional dont-focus)
  "build luna with gen proto"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "proto"
                 "--client" "~/Data/luna/master/"
                 "--game_root" "~/Data/luna_game/"))

(defun luna-genproto-for-test (&optional dont-focus)
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "protoc" "-I=/Users/qibinyang/go/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.6.7/"
                 "--plugin=protoc-gen-cl-pb=/usr/local/bin/protoc-gen-cl-pb"
                 "--cl-pb_out=output-file=game.lisp:/Users/qibinyang/Documents/luna_test/"
                 "--proto_path=/Users/qibinyang/Data/luna/master/tools/protobuf_cs/proto/"
                 "game.proto"))

(defun luna-genmodel(&optional dont-focus)
  "build luna with gen model"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "model"
                 "--project_root" "~/Data/luna_game/"))

(defun luna-export-config(&optional dont-focus)
  "build luna with export config"
  (interactive)
  (unless dont-focus
    (switch-to-buffer "*Messages*" nil t)
    (end-of-buffer))
  (start-process "luna_releaser" (get-buffer "*Messages*")
                 "luna_releaser" "word"
                 "--data" "/opt/luna_server/game/data/"
                 "--game_root" "~/Data/luna_game/"
                 "--tool" "~/Data/luna_export_tool/"
                 "--word" "~/Data/luna_word/luna_word_master/"))


(setq luna_time "@2022-11-16 23:59:00")
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

  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game_center/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game_center/makeGame.sh")
  )

(defun cycle-rank-test-now ()
  "test luna game base on the time of now"
  (interactive)
  (kill-luna)
  (sleep-for 2)
  (setq luna_time (format "@%s" (shell-command-to-string "echo -n $(date +%Y-%m-%d\\ %H:%M:%S)")))
  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game/makeGame.sh")

  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game2/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test2" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game2/makeGame.sh")

  (start-process "run_game" (get-buffer "*Messages*") luna_run "-e" "/opt/cycle_test/game_center/game" "-t" luna_time)
  (start-process-shell-command "cycle_rank_test_center" (get-buffer "*Messages*") "alacritty -e /opt/cycle_test/game_center/makeGame.sh")
  )


(defun kill-luna ()
  "kill all luna processes"
  (interactive)
  (start-process-shell-command "kill_luna" (get-buffer "*Messages*") "ps aux | awk '/[g]ame/ {print $2}' | xargs kill -9")
  (start-process-shell-command "kill_proxy" (get-buffer "*Message*") "ps aux | awk '/[p]roxy/ {print $2}' | xargs kill -9")
  )

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
