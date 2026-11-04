#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
PULL=0

for argument in "$@"; do
	case "$argument" in
		--dry-run) DRY_RUN=1 ;;
		--pull) PULL=1 ;;
		*)
			printf 'Usage: %s [--dry-run] [--pull]\n' "$0" >&2
			exit 2
			;;
	esac
done

if (( PULL )); then
	if (( DRY_RUN )); then
		printf 'Would run git -C %s pull\n' "$DOTFILES_DIR"
	else
		git -C "$DOTFILES_DIR" pull
	fi
fi

backup_target() {
	local target="$1"
	local timestamp backup suffix
	timestamp="$(date +%Y%m%d-%H%M%S)"
	backup="${target}.bak.${timestamp}"
	suffix=1
	while [[ -e "$backup" || -L "$backup" ]]; do
		backup="${target}.bak.${timestamp}.${suffix}"
		suffix=$((suffix + 1))
	done

	if (( DRY_RUN )); then
		printf 'Would back up %s to %s\n' "$target" "$backup"
	else
		mv -- "$target" "$backup"
		printf 'Backed up %s to %s\n' "$target" "$backup"
	fi
}

install_file() {
	local source="$1"
	local target="$2"
	local target_dir
	target_dir="$(dirname -- "$target")"

	if [[ -e "$target" || -L "$target" ]]; then
		if [[ -f "$source" && -f "$target" && ! -L "$target" ]] && cmp -s -- "$source" "$target"; then
			printf 'Unchanged %s\n' "$target"
			return
		fi
		backup_target "$target"
	fi

	if (( DRY_RUN )); then
		printf 'Would copy %s to %s\n' "$source" "$target"
	else
		mkdir -p -- "$target_dir"
		cp -a -- "$source" "$target"
		printf 'Copied %s to %s\n' "$source" "$target"
	fi
}

install_config_tree() {
	local source_dir="$1"
	local source relative_path
	while IFS= read -r -d '' source; do
		relative_path="${source#"$source_dir"/}"
		install_file "$source" "$HOME/.config/$relative_path"
	done < <(find "$source_dir" \( -type f -o -type l \) -print0)
}

for file in .inputrc .startup.sh .valgrindrc .vimrc .zshrc; do
	install_file "$DOTFILES_DIR/$file" "$HOME/$file"
done

install_file "$DOTFILES_DIR/format/.clang-format" "$HOME/.clang-format"
install_file "$DOTFILES_DIR/format/.clang-tidy" "$HOME/.clang-tidy"
install_config_tree "$DOTFILES_DIR/.config"