# SaltnFat Dots in NixOS | A fully reproducible OS environment
<div align = center>




&ensp;[<kbd> <br> Install <br> </kbd>](#-setup)&ensp;
&ensp;[<kbd> <br> Features <br> </kbd>](#-features)&ensp;
&ensp;[<kbd> <br> Keybindings <br> </kbd>](#very-useful-keybindigs-to-know)&ensp;
<br><br><br></div>

https://user-images.githubusercontent.com/67278339/211363959-9182ecb7-e56e-4598-afed-f352c5d2979e.mp4

<br>

## 🚀 Features
<img src="https://i.imgur.com/Xf8X4sd.png" alt="Linux Fetch" align="right" width="450">

**The Magic of a Fully Reproducible OS**

<sup>Are you tired of brittle bash scripts for setting up your OS just the way you want, or even worse doing it manually?  With NixOS the whole OS can be declaratively configured and is fully reproducible from your config.  Reinstalling or setting up your OS on other machines is a matter of running one install script.</sup>



## Neovim Setup

Neovim is automatically set up with the installer.  The plugin selection and configuration is loosely based on lazy vim.  Adding other plugins is simple provided they are in nix packages.  See neovim.nix for all the configuration details.

## Very useful keybindings to know...

| Keys | Action |
|:-|:-|
|<kbd>super</kbd> + <kbd>Enter</kbd><br><kbd>super</kbd> + <kbd>alt</kbd> + <kbd>Enter</kbd>| Open a terminal<br>Open a floating terminal.
|<kbd>alt</kbd> + <kbd>@space</kbd>| Display menu to select a theme.
|<kbd>super</kbd> + <kbd>D</kbd>| Apps Menu.
|<kbd>super</kbd> + <kbd>alt</kbd> + <kbd>w</kbd>| Opens a menu to select a wallpaper.


## 📦 Setup

### 💾 Installation:
The installer only works for **NixOS** Linux

<b>Open a terminal in HOME</b>
- **Clone this repo**
```sh
git clone https://github.com/jwyuen/jwy-gh0stzk-dotfiles.git
```
- **cd into repo**
```sh
cd jwy-gh0stzk-dotfiles
```
- **Give install script execute permissions**
```sh
chmod +x install.sh
```
- **Run the installer**
```sh
./install.sh
```
