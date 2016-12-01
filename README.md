# Intro

A minimal `.emacs.d/` configuration that lives in `.emacs.d/me`.
It loads some things that give me a lot of power for small amount
of dependencies.

## Synopsis

Put this in `~/.emacs.d/me/` .
Follow the instructions in `~/.emacs.d/me/init.el`

## What you get...

See `packages.el` - this loads some things I use.

The main powertools are:

* `helm`
  * helm makes running commands using `M-x` almost as easy as keyboard
    shortcuts, just think the name of the command you want
  * helm also makes emacs options (customize options / groups) and commands all **highly discoverable**
* `helm-ag`
  * you'll need to install silver search ag
  * no more tags or parsing libraries, just use ag + helm + projectile
* `projectile`
* `magit`

## What you don't get...

Your `~/.emacs.d/init.el` will store customizations you make in the way emacs normally does this.
You might want to backup a copy of this.

Once you load-unsafe (see below), use helm to navigate your options and use helm's amazing fuzzy search
to poke around:

* `M-x custom-group`
* `M-x custom-option`

# First time you install or reset your emacs
* `M-x me/package-install-my-packages`

# When starting up (every time)...
* `M-x me/load-unsafe`
* helm should load and everything becomes magic

If in trouble, disable, bisect debug the things we load in `me/load-unsafe`.

