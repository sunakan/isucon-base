#!/usr/bin/env bash
set -eu
#set -x
# -e: エラーが発生した時点でスクリプトを終了
# -u: 未定義の変数を使用した場合にエラーを発生
# -x: スクリプトの実行内容を表示(debugで利用)

#
# 通知
#
echo '-------[ 🚀Deploy App🚀 ]'

#
# App
# .envにて、LOCAL_APP_PATH, REMOTE_APP_PATH, GO_APP_NAMEを設定していること
# 例: REMOTE_APP_PATH=/home/isucon/private_isu/webapp/golang, LOCAL_APP_PATH=./isu-webapp/golang, GO_APP_NAME=isu-go
#
cat tmp/isu-servers | xargs -I{} rsync -az "${LOCAL_APP_PATH}/" "{}:${REMOTE_APP_PATH}/"
cat tmp/isu-servers | xargs -I{} ssh {} "export PATH=\$PATH:/home/isucon/.local/go/bin && cd ${REMOTE_APP_PATH} && make app && sudo systemctl restart ${GO_APP_NAME}"

#
# 通知
#
echo '----'
echo '👍️Done: Deploy App'
echo '----'
