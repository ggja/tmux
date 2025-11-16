#!/bin/bash

# Install TPM (Tmux Plugin Manager)
echo "Installing Tmux Plugin Manager (TPM)..."

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM installed successfully!"
else
    echo "TPM already installed."
fi

echo ""
echo "Setup complete!"
echo ""
echo "To use this configuration:"
echo "1. Start tmux: tmux"
echo "2. Install plugins: Press Prefix (Ctrl-a) + I"
echo "3. Reload config: Press Prefix (Ctrl-a) + r"
echo ""
echo "Key bindings:"
echo "  Prefix: Ctrl-a (instead of Ctrl-b)"
echo "  Split horizontal: Prefix + |"
echo "  Split vertical: Prefix + -"
echo "  Switch panes: Alt + Arrow keys"
echo "  Vim-style panes: Prefix + h/j/k/l"
echo "  Resize panes: Prefix + H/J/K/L"
echo "  Copy mode: Prefix + ["
echo "  Reload config: Prefix + r"
