# Vim Configuration Highlights

## Writing-Focused Setup
My vimrc is optimized for distraction-free writing, especially markdown:

- **Spell checking** automatically enabled for markdown files
- **Soft line wrapping** for natural text flow
- **2-space indentation** for clean markdown formatting
- **Text width 80** for proper paragraph formatting with `gq`

## Distraction-Free Writing
- **Goyo plugin** for full-screen, minimal interface
- **Limelight plugin** for paragraph-focused editing
- **Pencil plugin** for improved text editing experience
- **Vim-markdown** for syntax highlighting and features

## Development Features
- **ALE (Async Lint Engine)** for syntax checking and code fixing
- **Auto-fix on save** for consistent code formatting
- **Universal clipboard** integration
- **Smart completion** with Tab menu
- **Relative line numbers** for efficient navigation

## Quality of Life Improvements
- **Leader key mapped to spacebar** for easy shortcuts
- **jj mapped to Escape** for faster mode switching
- **Smart split behavior** (open bottom/right)
- **Cursor line/column highlighting** for better visibility
- **Sensible tab settings** (4 spaces, expand tabs)

## Plugin Management
Using vim-plug for clean, fast plugin management:
- **LLM integration** (vim-ai with Google provider)
- **File management** (NerdTree, FZF)
- **Writing tools** (Goyo, Limelight, Pencil, Wordy)
- **Code quality** (ALE for linting and fixing)

# Why These Customizations?

## Cross-Platform Compatibility
- **XDG directory detection** ensures configs work on both Arch and Debian
- **Universal clipboard** works across different desktop environments
- **Portable git sync** handles different document folder names automatically

## Productivity Focus
- **Automatic syncing** eliminates manual git operations
- **Symlink helpers** reduce setup time on new machines
- **Writing-optimized** because I use vim primarily for notes and documentation
- **Minimal but functional** plugin setup avoids bloat while providing essential features

## Developer Workflow
- **Auto-formatting** ensures consistent code style
- **Integrated linting** catches errors as I type
- **Efficient navigation** with relative numbers and smart shortcuts
- **Version control integration** for both code and notes

# Setup Instructions

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

# Requirements

- **Git** for version control
- **Vim 8.0+** for plugin compatibility
- **Node.js** (optional, for some plugins)
- **xdg-utils** for cross-platform directory detection

# Notes

- Auto-sync requires git repositories to be properly configured with remotes
- Some plugins may require additional setup (see plugin documentation)
- The configuration is optimized for my specific workflow but can be easily adapted
