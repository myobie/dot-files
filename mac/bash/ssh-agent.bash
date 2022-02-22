function use_secretive_ssh_agent() {
  sock_path=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

  if [[ -r ${sock_path} ]]; then
    export SSH_AUTH_SOCK="${sock_path}"
  fi
}

function use_1password_ssh_agent() {
  one_p_path="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

  if [[ -r ${one_p_path} ]]; then
    export SSH_AUTH_SOCK="${one_p_path}"
  fi
}

use_1password_ssh_agent
