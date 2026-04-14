# NixOS Configuration

> [!CAUTION]
> These dotfiles are heavily tailored to my needs and will likely not work out
> of the box on your machine. Installing them without inspecting them first is
> likely to cause issues.

This is my personal NixOS configuration using a dendritic (directory tree) module structure managed by [flake-parts](https://flake.parts/).

## Structure

```
.
├── flake.nix              # Entry point, defines inputs
├── modules/
│   ├── flake-parts.nix    # flake-parts configuration
│   ├── overlays.nix       # Nixpkgs overlays
│   ├── hosts/             # Host-specific configurations
│   │   ├── nixos.nix      # Host builder logic
│   │   ├── Y540/          # Laptop with NVIDIA GPU
│   │   ├── T490/          # ThinkPad laptop
│   │   └── N100/          # Home server
│   ├── core/              # Core system modules
│   ├── desktop/           # Desktop environment modules
│   ├── gaming/            # Gaming-related modules
│   ├── hardware/          # Hardware-specific modules
│   ├── programs/          # Program installations
│   ├── services/          # System services
│   └── virtualisation/    # Virtualization tools
```

## Module Organization

Each subdirectory contains related modules and a `default.nix` that imports them all:

- **`core/`** - Base system configuration (locale, network, shells, etc.)
- **`desktop/`** - Desktop environment (audio, fonts, wayland, X11)
- **`hardware/`** - Hardware support (GPU, firmware, power management)
- **`programs/`** - Software packages (editors, media tools, VCS)
- **`services/`** - System services (SSH, WireGuard, monitoring)
- **`gaming/`** - Gaming platforms (Steam, Lutris, Minecraft)
- **`virtualisation/`** - Virtualization (Docker, libvirt, VirtualBox)

## Hosts

| Host  | Type   | Description                           |
|-------|--------|---------------------------------------|
| Y540  | Laptop | Lenovo Legion Y540 with NVIDIA GPU    |
| T490  | Laptop | Lenovo ThinkPad T490 (Intel)          |
| N100  | Server | Home server with ZFS and services     |

## Usage

### Build a specific host

```bash
nixos-rebuild switch --flake .#Y540
nixos-rebuild switch --flake .#T490
nixos-rebuild switch --flake .#N100
```

### Format code

```bash
nix fmt
```

## Design Patterns

### Dendritic Module Structure

Modules are organized hierarchically using flake-parts' `import-tree` pattern:

```nix
# flake.nix
outputs = inputs@{ flake-parts, ... }:
  let
    import-tree = path: toList (fileFilter (file: file.hasExt "nix") path);
  in
  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = import-tree ./modules;
  };
```

This automatically discovers all `.nix` files in the tree.

### Module Naming Convention

Modules follow the pattern: `category_module`

Examples:
- `core_base` - Base system configuration
- `hardware_nvidia` - NVIDIA GPU support
- `services_ssh` - SSH server configuration
- `programs_editor` - Text editors

### Host Configuration Pattern

Hosts are defined in subdirectories with:
- `default.nix` - Main host configuration
- `hardware-configuration.nix` - Hardware-specific settings (auto-generated)

### Overlays

Overlays are centralized in `modules/overlays.nix`:
- `stable` - Access to nixpkgs-stable
- `rust-overlay` - Rust toolchain
- `copyparty` - File server
- `nautilus` - Patched Nautilus with gstreamer

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://wiki.nixos.org)
- [flake-parts](https://flake.parts/)
- [Home Manager](https://github.com/nix-community/home-manager)

## Inspired By

- [dotfiles.nix](https://github.com/k1ng440/dotfiles.nix) - Dendritic module pattern
- [nixos-hardware](https://github.com/NixOS/nixos-hardware) - Hardware configurations
