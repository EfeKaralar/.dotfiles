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

## Vim Configuration Highlights

### Writing-Focused Setup
My vimrc is optimized for distraction-free writing, especially markdown:

- **Spell checking** automatically enabled for markdown files
- **Soft line wrapping** for natural text flow
- **2-space indentation** for clean markdown formatting
- **Text width 80** for proper paragraph formatting with `gq`

### Distraction-Free Writing
- **Goyo plugin** for full-screen, minimal interface
- **Limelight plugin** for paragraph-focused editing
- **Pencil plugin** for improved text editing experience
- **Vim-markdown** for syntax highlighting and features

### Development Features
- **ALE (Async Lint Engine)** for syntax checking and code fixing
- **Auto-fix on save** for consistent code formatting
- **Universal clipboard** integration
- **Smart completion** with Tab menu
- **Relative line numbers** for efficient navigation

### Quality of Life Improvements
- **Leader key mapped to spacebar** for easy shortcuts
- **jj mapped to Escape** for faster mode switching
- **Smart split behavior** (open bottom/right)
- **Cursor line/column highlighting** for better visibility
- **Sensible tab settings** (4 spaces, expand tabs)

### Plugin Management
Using vim-plug for clean, fast plugin management:
- **LLM integration** (vim-ai with Google provider)
- **File management** (NerdTree, FZF)
- **Writing tools** (Goyo, Limelight, Pencil, Wordy)
- **Code quality** (ALE for linting and fixing)

## Why These Customizations?

### Cross-Platform Compatibility
- **XDG directory detection** ensures configs work on both Arch and Debian
- **Universal clipboard** works across different desktop environments
- **Portable git sync** handles different document folder names automatically

### Productivity Focus
- **Automatic syncing** eliminates manual git operations
- **Symlink helpers** reduce setup time on new machines
- **Writing-optimized** because I use vim primarily for notes and documentation
- **Minimal but functional** plugin setup avoids bloat while providing essential features

### Developer Workflow
- **Auto-formatting** ensures consistent code style
- **Integrated linting** catches errors as I type
- **Efficient navigation** with relative numbers and smart shortcuts
- **Version control integration** for both code and notes

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   ```

2. **Link your existing configs**:
   ```vim
   :DotfilesLink vimrc
   :DotfilesLink bashrc
   :DotfilesLink scripts
   ```

3. **Set up Notes directory** (if using Notes sync):
   - Initialize git repo in your Notes directory
   - Set up remote repository for sync

4. **Install vim plugins**:
   ```vim
   :PlugInstall
   ```

## Requirements

- **Git** for version control
- **Vim 8.0+** for plugin compatibility
- **Node.js** (optional, for some plugins)
- **xdg-utils** for cross-platform directory detection

## Notes

- Auto-sync requires git repositories to be properly configured with remotes
- Some plugins may require additional setup (see plugin documentation)
- The configuration is optimized for my specific workflow but can be easily adapted

---

*This configuration reflects my personal preferences for a clean, efficient development environment focused on writing and documentation work.*
