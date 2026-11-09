# command-rotate

複数コマンドの実行結果をキャッシュし、ターミナル全画面で切り替えて表示します。
Bash 4 以降と Linux の `flock`、`setsid`、`timeout`、`tput` などを使用します。

```sh
~/dotfiles/scripts/command-rotate

# 設定ファイルを明示する場合
~/dotfiles/scripts/command-rotate -c ~/dotfiles/.config/command-rotate/config.sh
```

既定の設定は `${XDG_CONFIG_HOME:-$HOME/.config}/command-rotate/config.sh` です。
リポジトリ内の `.config/command-rotate/config.sh` を配置またはリンクして使います。

```bash
ROTATE_INTERVAL=10  # 表示の自動切り替え間隔（秒）
COMMAND_TIMEOUT=30  # 各コマンドの実行時間上限（秒）

# 表示名、更新間隔（秒）、Bash で実行するコマンド
add_command "Codex" 300 '"$HOME/dotfiles/scripts/codex-usage"'
add_command "Repositories" 60 '"$HOME/dotfiles/scripts/ghq-status"'
add_command "Disk" 120 'df -h'
```

- 設定は信頼できる Bash コードとして読み込みます。変更後は再起動してください。
- コマンドは起動時の作業ディレクトリで、非対話の `bash -c` として実行します。
  シェルのエイリアスは使えません。標準入力を必要としないコマンドを登録してください。
- 起動時に未取得・期限切れの結果を取得し、その後は各コマンドの完了から指定秒数後に更新します。
  表示対象でないコマンドも更新します。キャッシュが有効なら起動直後から再利用します。
- キャッシュは `${XDG_CACHE_HOME:-$HOME/.cache}/command-rotate/` に保存します。
  設定パス、作業ディレクトリ、登録内容ごとに分離し、複数画面からの重複実行を防ぎます。
- 失敗・タイムアウト時は前回の成功結果を保持し、終了コードと標準エラーを表示します。
- 出力はプレーンテキストとして扱い、画面に収まらない行・列は省略します。

## 操作

| 操作 | 動作 |
| --- | --- |
| Space / → / 左クリック | 次の結果 |
| ← | 前の結果 |
| `q` / Ctrl+C | 終了 |

手動で切り替えると自動切り替えの待ち時間をリセットします。
クリックには SGR マウス対応端末が必要です。tmux 内では `set -g mouse on` が
必要になる場合があります。終了時は端末設定を復元し、実行中のコマンドを停止します。

## テスト

実際の API やリポジトリにはアクセスせず、疑似端末とテスト用コマンドで検証します。

```sh
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s scripts/tests -v
```
