all: userswitch osswitch

osswitch:
	# defaults to the current hostname
	sudo nixos-rebuild switch --flake .

userswitch:
	nix run home-manager -- switch --flake "./users/sidd/"

update_hm:
	nix run home-manager -- switch --flake "./users/sidd/" --recreate-lock-file

update_os:
	sudo nixos-rebuild switch --flake . --recreate-lock-file

make_ft:
	nix run nix-darwin -- switch --flake .
