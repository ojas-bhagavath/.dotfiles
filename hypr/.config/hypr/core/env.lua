-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- XDG Base Directories
local home = os.getenv("HOME")
hl.env("XDG_CONFIG_HOME", home .. "/.config")
hl.env("XDG_CACHE_HOME", home .. "/.cache")
hl.env("XDG_DATA_HOME", home .. "/.local/share")
hl.env("XDG_STATE_HOME", home .. "/.local/state")
hl.env("DOTFILES", home .. "/.dotfiles")

-- Default Applications
hl.env("TERMINAL", "kitty")
hl.env("EDITOR", "neovide")
hl.env("VISUAL", "neovide")
hl.env("BROWSER", "firefox")
hl.env("FILEMANAGER", "yazi")

-- Tool/Runtime Directories
hl.env("GNUPGHOME", home .. "/.gnupg")
hl.env("CARGO_HOME", home .. "/.local/share/cargo")
hl.env("GOPATH", home .. "/.local/share/go")
hl.env("RUSTUP_HOME", home .. "/.local/share/rustup")
hl.env("PNPM_HOME", home .. "/.local/share/pnpm")

-- PATH Construction (User paths PREPENDED ahead of system PATH)
hl.env(
	"PATH",
	home
		.. "/.local/bin"
		.. ":"
		.. home
		.. "/.scripts"
		.. ":"
		.. home
		.. "/.local/share/cargo/bin"
		.. ":"
		.. home
		.. "/.local/share/pnpm"
		.. ":"
		.. home
		.. "/.elan/bin"
		.. ":"
		.. os.getenv("PATH")
)
