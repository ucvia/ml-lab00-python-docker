# Instalando PyEnv

Luego de la instalación en sistemas UNIX (preferiblemente Ubuntu o Debian) deben agregar el siguiente chunk de texto sea a `~/.bashrc`, `~/.profile` o `~/.bash_profile`

```bash
# Load pyenv automatically by appending
# the following to 
~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
and ~/.bashrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"
```
