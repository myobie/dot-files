sock_path=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

if [[ -f ${sock_path} ]]; then
  export SSH_AUTH_SOCK="${sock_path}"
fi