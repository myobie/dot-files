function use_1password_ssh_agent() {
  one_p_path="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

  if [[ -S "${one_p_path" ]]; then
    export SSH_AUTH_SOCK="${one_p_path}"
  fi
}

# Only use 1Password agent if not in an SSH session (allow agent forwarding)
if [ -z "$SSH_CONNECTION" ]; then
  use_1password_ssh_agent
fi

# Don't use biometrics over ssh
if [ -n "$SSH_CONNECTION" ]; then
  export OP_BIOMETRIC_UNLOCK_ENABLED=false
fi
