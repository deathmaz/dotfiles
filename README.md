# Install needed packages

```sh
./install-apps.sh
```

# Download `ffmpeg` compiled for `yt-dlp`

```sh
./download-ffmpeg-for-yt-dlp.sh
```

---

# Zsh setup [Thu, 23.06.2022 00:27]

- [set zsh as default shell](https://wiki.archlinux.org/index.php/Command-line_shell#Changing_your_default_shell)

---

# Docker setup [Thu, 23.06.2022 00:26]

- configure to run docker commands without sudo
- [change the location for docker images](https://wiki.archlinux.org/title/Docker#Images_location)
- configure [credential store](https://docs.docker.com/engine/reference/commandline/login/#credentials-store) for docker
  - use config below in `$HOME/.docker/config.json`
  ```json
  {
    "credsStore": "pass"
  }
  ```
  - generate gpg key if needed via `gpg --full-generate-key` (see [this](https://docs.fedoraproject.org/en-US/quick-docs/create-gpg-keys/))
  - run `pass init <gpg-key>` to initialize the store, see [this](https://www.passwordstore.org/)
    for details
  - run `docker login` and use `access token` from docker hub as password
---

# Move all configs to their locations

> IMPORTANT: before running `stow -v -R -t ~ */` make sure that you're in `~/dotfiles/deathmaz`
> folder

```sh
## symlink all folders (trailing slash */) in dotfiles dir to home dir
cd path-to-dotfiles/deathmaz
stow -v -t ~ */

## if new folder is added then:
# redo link (-R)
cd path-to-dotfiles/deathmaz
stow -v -R -t ~ */
stow -v -R -t ~ tmux

## if folder was deleted then:
# delete (-D flag then -R to relink)
cd path-to-dotfiles/deathmaz
stow -v -D -t ~ */
stow -v -R -t ~ */
```

# Env variables [Sat, 17.07.2021 16:55]

For `kitty` it's better to set some global env vars in `/etc/environment`:
```sh
#
# This file is parsed by pam_env module
#
# Syntax: simple "KEY=VAL" pairs on separate lines
#

EDITOR='nvim'
VISUAL="nvim"
HOMEBREW_BUNDLE_NO_LOCK='1'
MAZ_CLI_BROWSER='w3m'
FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_CTRL_T_OPTS="--bind ctrl-j:preview-down,ctrl-l:preview-up --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
```
---


# Config example for xmouseless

```c
/* the rate at which the mouse moves in Hz
 * does not change its speed */
static const unsigned int move_rate = 50;

/* the default speed of the mouse pointer
 * in pixels per second */
static const unsigned int default_speed = 500;

/* changes the speed of the mouse pointer */
static SpeedBinding speed_bindings[] = {
    /* key             speed */
    { XK_Super_L,      3000 },
    { XK_Shift_L,        2000 },
    { XK_Alt_L,            100  },
    { XK_Control_L,    10   },
};

/* moves the mouse pointer
 * you can also add any other direction (e.g. diagonals) */
static MoveBinding move_bindings[] = {
    /* key         x      y */
    { XK_j,         0,    1 },
    { XK_l,         1,     0 },
    { XK_h,        -1,     0 },
    { XK_k,         0,     -1 },
    // { XK_y,         -1,     -1 },
    // { XK_n,         -1,     1 },
};

/* 1: left
 * 2: middle
 * 3: right */
static ClickBinding click_bindings[] = {
    /* key         button */
    { XK_u,        1 },
    { XK_f,        1 },
    { XK_i,        2 },
    { XK_o,        3 },
};

/* scrolls up, down, left and right
 * a higher value scrolls faster */
static ScrollBinding scroll_bindings[] = {
    /* key        x      y */
    { XK_n,        0 ,    25 },
    { XK_p,        0 ,   -25 },
    { XK_plus,     0 ,    80 },
    { XK_minus,    0 ,   -80 },
    // { XK_h,        25,    0  },
    { XK_g,       -25,    0  },
};

/* executes shell commands */
static ShellBinding shell_bindings[] = {
    /* key         command */
    { XK_s,        "$HOME/dotfiles/deathmaz/executable/scripts/bin/focus-slack.sh" },
    { XK_m,        "$HOME/dotfiles/deathmaz/executable/scripts/bin/focus-thunderbird.sh" },
    { XK_v,        "$HOME/dotfiles/deathmaz/executable/scripts/bin/focus-mpv.sh" },
    { XK_b,        "$HOME/dotfiles/deathmaz/executable/scripts/bin/focus-brave.sh" },
    { XK_t,        "$HOME/dotfiles/deathmaz/executable/scripts/bin/focus-telegram.sh" },
    { XK_0,        "xdotool mousemove 0 0" },
};

/* exits on key release which allows click and exit with one key */
static KeySym exit_keys[] = {
    XK_Escape, XK_q
};
```

# Clear yay cache [Mon, 27.06.2022 22:33]

```sh
yay -Sc
```

---

# MacOS

```sh
# set global settings for macos
./macos.sh
# restart computer
```
