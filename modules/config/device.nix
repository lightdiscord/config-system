{ lib, ... }:

with lib;

{
	options.alphabet.letter = mkOption {
		type = types.str;
		description = ''
			The current device letter in the alphabet.
		'';
	};
}
