export-gpg-key() {
  gpg --output ~/Desktop/$1.sec.gpg --armor --export-secret-key $1
  gpg --output ~/Desktop/$1.pub.gpg --armor --export $1
}
