#!/bin/sh

host=$(hostname)
cmd=""
needs_flags=""

while [ $# -gt 0 ]; do
	case $1 in
		-U|--update)
			cmd="nix flake update"
			;;
		-s|--switch)
			needs_flags=true
			cmd="nixos-rebuild switch"
			;;
		-u|--upgrade)
			needs_flags=true
			cmd="nix flake update && nixos-rebuild switch"
			;;
		-c|--clean)
			cmd="sudo nix-collect-garbage -d && nix-collect-garbage -d"
			;;
		--host)
			host=$2
			shift
			;;
		*)
			break
		;;
	esac
	shift
done

flags="--use-remote-sudo --impure --flake .#${host} --print-build-logs"

if [ -z "$cmd" ]; then
	echo "No command specified" >&2
	exit 1
fi

command="$cmd ${needs_flags:+$flags} $*"

echo "Running: $command"
sh -c "$command"
