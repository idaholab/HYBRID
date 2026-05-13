#!/usr/bin/env python3
"""
Generates PIController.fmu — an FMI 2.0 Co-Simulation FMU for a PI controller.

Requires:
    pip install pythonfmu

FMU variables
-------------
Inputs:
    error   — error signal  (reference - measured)
    Kp      — proportional gain
    Ki      — integral gain
Output:
    u       — control signal  (u = Kp*error + Ki*integral(error,dt))
"""

import subprocess
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# PI controller slave definition (written to disk, then built into an FMU)
# ---------------------------------------------------------------------------
SLAVE_CODE = '''\
from pythonfmu import Fmi2Slave, Real, Fmi2Causality


class PIController(Fmi2Slave):
    """Discrete-time PI controller: u = Kp*e + Ki*integral(e)."""

    author = "Auto-generated"
    description = "PI controller FMU with tunable gains as inputs"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        # Variable initial values
        self.error = 0.0   # error signal input
        self.Kp    = 1.0   # proportional gain input
        self.Ki    = 0.1   # integral gain input
        self.u     = 0.0   # control signal output

        # Internal state (not exposed to FMI master)
        self._integral = 0.0

        self.register_variable(
            Real("error", causality=Fmi2Causality.input,
                 description="Error signal (reference - measured)")
        )
        self.register_variable(
            Real("Kp", causality=Fmi2Causality.input,
                 description="Proportional gain")
        )
        self.register_variable(
            Real("Ki", causality=Fmi2Causality.input,
                 description="Integral gain")
        )
        self.register_variable(
            Real("u", causality=Fmi2Causality.output,
                 description="Control signal: u = Kp*error + Ki*integral(error)")
        )

    def do_step(self, current_time: float, step_size: float) -> bool:
        # Forward-Euler integration of the error
        self._integral += self.error * step_size
        self.u = self.Kp * self.error + self.Ki * self._integral
        return True
'''


def main() -> None:
    slave_file = Path("PIController.py")

    print("Writing PIController.py ...")
    slave_file.write_text(SLAVE_CODE)

    print("Building FMU with pythonfmu ...")
    result = subprocess.run(
        [sys.executable, "-m", "pythonfmu", "build", "-f", str(slave_file)],
        text=True,
    )

    # Remove the intermediate slave file regardless of outcome
    slave_file.unlink(missing_ok=True)

    if result.returncode != 0:
        print(
            "\nBuild failed.\n"
            "Make sure pythonfmu is installed:  pip install pythonfmu\n"
            "pythonfmu also requires a C compiler (MSVC on Windows, gcc/clang on Linux/macOS)."
        )
        sys.exit(1)

    fmus = sorted(Path(".").glob("PIController*.fmu"))
    if fmus:
        print(f"\nSuccess!  FMU created: {fmus[-1].resolve()}")
    else:
        print("\nBuild finished but no .fmu file found in the current directory.")


if __name__ == "__main__":
    main()
