all: userswitch osswitch

osswitch:
	# defaults to the current hostname
	sudo nixos-rebuild switch --flake .

userswitch:
	home-manager switch --flake "./users/sidd/"
