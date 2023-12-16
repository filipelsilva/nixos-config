.PHONY = switch boot test build-vm update upgrade clean

HOSTNAME = $(shell hostname)
FLAGS = --use-remote-sudo --impure --flake .\#${HOSTNAME} -L

ifndef HOSTNAME
	$(error Hostname unknown)
endif

switch:
	nixos-rebuild switch ${FLAGS}

boot:
	nixos-rebuild boot ${FLAGS}

test:
	nixos-rebuild test ${FLAGS}

build-vm:
	nixos-rebuild build-vm ${FLAGS}

update:
	nix flake update

upgrade:
	make update && make switch

clean:
	sudo nix-collect-garbage -d
