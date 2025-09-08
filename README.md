# dotfiles-termux

This repository contains dotfiles and bootstrap scripts for a Termux installation.

## Installation

To set up your Termux environment using these dotfiles, please follow these steps:

1.  **Clone this repository:**
    First, you need to clone this repository to your Termux home directory.
    ```bash
    git clone <URL_OF_THIS_REPOSITORY>
    cd dotfiles-termux
    ```
    *(Replace `<URL_OF_THIS_REPOSITORY>` with the actual URL of this git repository.)*

2.  **Run the bootstrap script:**
    This script will install all the necessary packages, including `zsh`, `vim`, `git`, and `python`. It will also install Oh My Zsh and request access to your device's storage.
    ```bash
    bash bootstrap.sh
    ```

3.  **Restart Termux:**
    After the bootstrap script finishes, you need to restart your Termux application for the changes to take effect.

4.  **Run the installation script:**
    This script will create symbolic links from the dotfiles in this repository to your home directory. It will also change your default shell to `zsh`.
    ```bash
    bash install.sh
    ```

5.  **Restart Termux again:**
    Restart Termux one more time to start using your new `zsh` shell with the custom configuration.

## Important Notes

### Powerline Fonts for the `agnoster` theme

The `.zshrc` is configured to use the `agnoster` theme, which provides a visually appealing and informative prompt. For this theme to render correctly, you need to use a "Powerline" font.

You can typically change the font used by Termux by long-pressing on the screen, selecting "Style", and then choosing a font. If you don't have a Powerline font available, you may need to find and install one. A popular choice is "Nerd Fonts".

### Customization

Feel free to modify the `.zshrc` and `.vimrc` files in this repository to your liking. If you make any changes, the symbolic links created by the `install.sh` script will ensure that your configurations are automatically updated.
