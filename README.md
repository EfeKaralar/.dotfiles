# My Dotfiles

These are my personal dotfiles for my Linux development environment. I primarily use Arch Linux with DWM and DMenu, but these configs are designed to work across different systems including my Debian home-lab setup.

## What's Included

- **vimrc** - Vim configuration optimized for markdown writing and coding
- **bashrc** - Bash shell configuration
- **scripts/** - Custom shell scripts and utilities
- Other configuration files as needed

## Features

### Automatic Git Synchronization

My vimrc includes custom functions that automatically sync both dotfiles and notes across multiple machines:

#### Notes Auto-Sync
- **Location**: Cross-platform Notes directory (uses XDG directories)
  - Arch: `~/Docs/Notes/`
  - Debian: `~/Documents/Notes/`
- **Auto-triggers**: When opening or saving files in Notes directory
- **Manual command**: `:NotesSync`

#### Dotfiles Auto-Sync
- **Location**: `~/.dotfiles/` directory
- **Auto-triggers**: When saving `.vimrc`, `.bashrc`, or files in `~/.scripts/`
- **Manual command**: `:DotfilesSync`

### Dotfiles Management Helper

#### Link Files to Dotfiles
```vim
:DotfilesLink vimrc
:DotfilesLink bashrc
:DotfilesLink scripts
```

This command:
1. Moves the file from `~/` to `~/.dotfiles/`
2. Creates a symlink back to the original location
3. Automatically syncs to git

## Typical Vim Workflow

### Setting Up on a New Machine
1. Clone this repository to `~/.dotfiles`
2. Use `:DotfilesLink` commands to symlink important files
3. Files automatically sync when you save them

### Daily Usage
1. **Edit configs normally** - files are symlinked, so changes happen in dotfiles repo
2. **Save files** - automatic git sync happens in the background
3. **Notes sync** - when working in Notes directory, changes auto-sync across machines
4. **Manual sync** - use `:DotfilesSync` or `:NotesSync` if needed

### Example Session
```bash
# Open vim to edit config
vim ~/.vimrc

# Make changes and save (:w)
# → Automatic git sync happens

# Work on notes
vim ~/Documents/Notes/project.md

# Save notes (:w)
# → Notes automatically sync to git

# Check status manually if needed
:DotfilesSync
:NotesSync
```

---

*This configuration reflects my personal preferences for a clean, efficient development environment focused on writing and documentation work.*
