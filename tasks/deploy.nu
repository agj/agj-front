
let remote = $"($env.SSH_USER)@($env.SSH_HOST)"
let target = $"($remote):($env.REMOTE_DEPLOY_DIR)"

print $"ℹ️ Logging in to remote host `($remote)` on port ($env.SSH_PORT)."
print $"ℹ️ Uploading to directory `($env.REMOTE_DEPLOY_DIR)`…"

scp -P $env.SSH_PORT ./dist/index.html $target
scp -P $env.SSH_PORT -r ./dist/assets/ $target

print "✅ Done!"
