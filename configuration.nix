{ ... }:

let

	machines = import ./machines;
	systems = import ./systems;

in {
	imports = [
		# Change to the machine you want.
		machines.riza-hawkeye

		# Change to the system you want.
		systems.lambda
	];
}
