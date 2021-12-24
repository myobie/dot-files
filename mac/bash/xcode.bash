xcode-path() {
  if [[ -n $(which xcode-select) ]]; then
    echo $(xcode-select -p)
  else
    echo "/Applications/Xcode.app/Contents/Developer"
  fi
}

alias ddd="rm -rf ~/Library/Developer/Xcode/DerivedData/*"

if [[ -n $(which xcrun) ]]; then
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
fi

export PATH="${PATH}:$(xcode-path)/usr/bin"