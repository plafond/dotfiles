  
  # Setup Dotfiles, Shell, Terminal, test22iei22, etc..

- install gnu stow
  `sudo apt install stow`


- install zsh and oh-my-zsh
  `sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"`

  # install nerd fonts (linux)
`wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv`


# install nvim, tmux, zsh (linux), tilda
`sudo apt install nvim, tmux, zsh, tilda`

# clone repo

create directory into 
!-- mkdir ${HOME}/dotfiles
`git clone https://github.com/plafond/dotfiles ${HOME}`


# load package that map to directories under ${HOME}/dotfiles
`stow nvim`
`stow tmux`
`stow zsh`
