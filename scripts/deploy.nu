
let remote = $"($env.SSH_USER)@($env.SSH_HOST)"

print $"ℹ️ Logging in to remote host ($remote) on port ($env.SSH_PORT)"
print $"ℹ️ Uploading to directory ($env.REMOTE_DEPLOY_DIR)"

glob --no-dir dist/*.{css,html,map}
  | each { |path|
    let relativePath = $path | path relative-to (pwd)
    print $"ℹ️ Copying: ($relativePath)"
    scp -P $env.SSH_PORT $path $"($remote):($env.REMOTE_DEPLOY_DIR)"
  }

print "✅ Done!"
