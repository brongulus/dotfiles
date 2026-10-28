#!/usr/bin/env bash
set -e

########################################
# FISH PLUGINS (via fisher)
########################################
fish_plugins=(
  patrickf1/fzf.fish
  jethrokuan/z
  jorgebucaran/fishtape
)

install_fish_plugins() {
  echo "Installing fish plugins..."
  if ! command -v fish >/dev/null 2>&1; then
    echo "  fish not found, skipping."
    return
  fi
  if ! fish -c "type -q fisher" 2>/dev/null; then
    echo "  fisher not found, installing..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  fi
  for plugin in "${fish_plugins[@]}"; do
    echo "  fisher install $plugin"
    fish -c "fisher install $plugin"
  done
}

########################################
# TMUX PLUGINS (via TPM)
########################################
tmux_plugins=(
  tmux-plugins/tmux-resurrect
  sainnhe/tmux-fzf
  fcsonline/tmux-thumbs
)

install_tmux_plugins() {
  echo "Installing tmux plugins..."
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [[ ! -d "$tpm_dir" ]]; then
    echo "  Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
  for plugin in "${tmux_plugins[@]}"; do
    local plugin_name
    plugin_name=$(basename "$plugin")
    local plugin_dir="$HOME/.tmux/plugins/$plugin_name"
    if [[ ! -d "$plugin_dir" ]]; then
      echo "  Cloning $plugin..."
      git clone "https://github.com/$plugin" "$plugin_dir"
    else
      echo "  $plugin_name already installed, pulling latest..."
      git -C "$plugin_dir" pull --ff-only
    fi
  done
}

########################################
# RUBY GEMS
########################################
ruby_gems=(
  pry
  colorls
  reline
  prism
)

install_ruby_gems() {
  echo "Installing Ruby gems..."
  if ! command -v gem >/dev/null 2>&1; then
    echo "  gem not found, skipping."
    return
  fi
  for gem in "${ruby_gems[@]}"; do
    if gem list -i "^${gem}$" >/dev/null 2>&1; then
      echo "  $gem already installed"
    else
      echo "  gem install $gem"
      gem install "$gem"
    fi
  done
}

########################################
# OCAML PACKAGES (via opam)
########################################
opam_packages=(
  utop
  ocaml-lsp-server
)

install_ocaml_packages() {
  echo "Installing OCaml packages via opam..."
  if ! command -v opam >/dev/null 2>&1; then
    echo "  opam not found, skipping."
    return
  fi
  if ! opam switch show >/dev/null 2>&1; then
    echo "  Initializing opam..."
    opam init --bare --no-setup -y
    opam switch create default --no-switch -y 2>/dev/null || true
  fi
  eval "$(opam env)"
  opam install -y "${opam_packages[@]}"
}

########################################
# LUA PACKAGES (via luarocks)
########################################
luarocks_packages=(
  luasocket
  luasec
)

install_lua_packages() {
  echo "Installing Lua packages via luarocks..."
  if ! command -v luarocks >/dev/null 2>&1; then
    echo "  luarocks not found, skipping."
    return
  fi
  for rock in "${luarocks_packages[@]}"; do
    if luarocks show "$rock" >/dev/null 2>&1; then
      echo "  $rock already installed"
    else
      echo "  luarocks install $rock"
      luarocks install "$rock"
    fi
  done
}

########################################
# GO TOOLS (via go install)
########################################
go_tools=(
  golang.org/x/tools/...@latest
  golang.org/x/tools/gopls@latest
  github.com/myitcv/gobin@latest
)

install_go_tools() {
  echo "Installing Go tools..."
  if ! command -v go >/dev/null 2>&1; then
    echo "  go not found, skipping."
    return
  fi
  for tool in "${go_tools[@]}"; do
    echo "  go install $tool"
    go install "$tool"
  done
}

########################################
# PYTHON TOOLS (via uv)
########################################
python_tools=(
  basedpyright
  ruff
)

install_python_tools() {
  echo "Installing Python tools via uv..."
  if ! command -v uv >/dev/null 2>&1; then
    echo "  uv not found, skipping."
    return
  fi
  for tool in "${python_tools[@]}"; do
    echo "  uv tool install $tool"
    uv tool install "$tool"
  done
}

########################################
# MAIN
########################################
echo "=== Installing language-specific packages ==="
echo ""

install_fish_plugins
echo ""
install_tmux_plugins
echo ""
install_ruby_gems
echo ""
install_ocaml_packages
echo ""
install_lua_packages
echo ""
install_go_tools
echo ""
install_python_tools

echo ""
echo "Done!"
