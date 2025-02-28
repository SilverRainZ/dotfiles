update-archpkgs:
	pacman -Q --quiet --explicit | grep -v "$$(pacman -Q --quiet --foreign)" > archpkgs.txt
