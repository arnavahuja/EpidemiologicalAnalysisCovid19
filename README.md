# SIR Model for Epidemiological Analysis of COVID-19 in India

Mathematical modelling of COVID-19 spread in India using deterministic and stochastic SIR epidemic models.

<img src="https://www.lewuathe.com/assets/img/posts/2020-03-11-covid-19-dynamics-with-sir-model/sir.png" width="500" alt="SIR Model Diagram">

## Project Overview

This project was undertaken as part of the **Applied Stochastic Processes** course. It analyses COVID-19 data from India (Jan–Aug 2020) using the SIR (Susceptible-Infected-Removed) compartmental model under three formulations:

1. **Deterministic ODE** — classical SIR solved with MATLAB's `ode45`
2. **Euler-Maruyama (DTMC)** — stochastic SDE discretisation with Wiener process noise
3. **Gillespie Algorithm (CTMC)** — exact stochastic simulation of the continuous-time Markov chain

Parameters (transmission rate &beta; and removal rate &gamma;) are estimated from real data using `fminsearch`, and the analysis is split into three phases: pre-lockdown, lockdown, and post-lockdown.

For full mathematical details, see the [project report](docs/Stochastic%20Disease%20Modelling%20Report.pdf).

## Repository Structure

```
EpidemiologicalAnalysisCovid19/
├── src/                        # MATLAB source code
│   ├── main_Script.m           # Main driver script
│   ├── det_ode.m               # Deterministic ODE solver & plotting
│   ├── EM_method.m             # Euler-Maruyama stochastic simulation
│   ├── gillespie.m             # Gillespie algorithm simulation
│   ├── odefunc.m               # SIR ODE system definition
│   ├── parest.m                # Parameter estimation (fminsearch)
│   ├── optim_fun.m             # Objective function for optimisation
│   ├── iniGuess.m              # Random initial parameter guesses
│   ├── isEpidemic.m            # Deterministic epidemic threshold check
│   ├── P_majOutBr.m            # Major outbreak probability
│   ├── get_data.m              # Load COVID-19 CSV data
│   └── view_data.m             # Plot observed data
├── data/                       # Data files
│   ├── date-India-confirmed-recovered-dead.csv
│   └── time-series-countries.txt
├── scripts/                    # Utility scripts
│   └── data_extraction.py      # Extract India data from raw dataset
├── docs/                       # Documentation
│   └── Stochastic Disease Modelling Report.pdf
├── results/                    # Generated plots (after running main_Script)
├── .gitignore
├── requirements.txt            # Python dependencies (stdlib only)
└── README.md
```

## Methodology

### Deterministic SIR Model
The classical SIR model governed by:
- dS/dt = -&beta;SI/N
- dI/dt = &beta;SI/N - &gamma;I
- dR/dt = &gamma;I

Solved numerically using MATLAB's `ode45`. The basic reproduction number R0 = &beta;/&gamma; determines whether an epidemic occurs.

### Euler-Maruyama Method (DTMC)
Discretises the SIR stochastic differential equations using the Euler-Maruyama scheme with Wiener process noise terms, capturing randomness in disease transmission and removal.

### Gillespie Algorithm (CTMC)
An exact stochastic simulation where inter-event times are exponentially distributed. Each event is either a new infection or a removal, selected proportionally to their rates.

### Parameter Estimation
&beta; and &gamma; are estimated by minimizing the mean squared error between the ODE solution and observed data using MATLAB's `fminsearch`.

## Requirements

- **MATLAB** R2019b or later
- **Optimization Toolbox** (for `fminsearch`, `optimset`)
- **Python** 3.6+ (only for the data extraction utility script; uses standard library only)

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/EpidemiologicalAnalysisCovid19.git
   cd EpidemiologicalAnalysisCovid19
   ```

2. Open MATLAB and navigate to the `src/` directory:
   ```matlab
   cd src
   ```

3. Run the main script:
   ```matlab
   main_Script
   ```

4. All plots will be saved as PNG files in the `results/` directory.

### Data Extraction (optional)

If you need to regenerate the India CSV from the raw dataset:
```bash
cd scripts
python data_extraction.py
```

## Results

Running `main_Script.m` produces the following analyses and corresponding plots:

| Phase | Period | Output Files |
|-------|--------|-------------|
| Theoretical | Synthetic (N=1000) | `ODE_theory.png`, `EM_theory.png`, `Gillespie_theory.png` |
| Phase 1 — Pre-Lockdown | Days 43–64 | `Estimation_1.png`, `ODE_1.png`, `EM_1.png` |
| Phase 2 — Lockdown | Days 64–131 | `Estimation_2.png`, `ODE_2.png`, `EM_2.png` |
| Phase 3 — Post-Lockdown | Days 131–end | `Estimation_3.png`, `ODE_3.png`, `EM_3.png` |
| Overall | Days 43–end | `Estimation_overall.png`, `ODE_overall.png`, `EM_overall.png` |

Each phase displays:
- Estimated &beta; (transmission rate) and &gamma; (removal rate)
- Basic reproduction number R0
- Probability of a major outbreak
- Deterministic epidemic status
- Comparison plots of actual data vs. ODE, Euler-Maruyama, and Gillespie simulations

## References

- Allen, L.J.S. (2017). *A primer on stochastic epidemic models*. Infectious Disease Modelling.
- Gillespie, D.T. (1977). *Exact stochastic simulation of coupled chemical reactions*. Journal of Physical Chemistry.
- COVID-19 data sourced from Johns Hopkins CSSE.
