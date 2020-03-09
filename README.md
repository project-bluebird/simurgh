[![Build Status](https://travis-ci.com/alan-turing-institute/simurgh.svg?branch=master)](https://travis-ci.com/alan-turing-institute/simurgh)

# Simurgh

*Simurgh* (pronounced _Seymour_) is an open source platform that supports developing
and evaluating algorithms (AI agents) for automated air traffic control. It provides
an easy to use interface for running experiments in an air traffic simulator.

## Overview

Air traffic control (ATC) is a complex task requiring real-time safety-critical decision
making. In practice, air traffic control operators (ATCOs) monitor a given sector and issue commands
to aircraft pilots to ensure safe separation between aircraft. They also have to consider
the number and frequency of instructions issued, fuel efficiency and orderly handover between sectors.
Optimising for the multiple objectives while accounting for uncertainty (e.g., due to aircraft mass, pilot behaviour or weather conditions) makes this a particularly complex task.

The [Simurgh](https://en.wikipedia.org/wiki/Simurgh) project provides a research-focused user-friendly
platform for testing automated approaches to ATC. It consists of several elements that
all work together to achieve this:

- [Bluebird](https://github.com/alan-turing-institute/bluebird) - a Flask-based API that handles communication with multiple air traffic simulators (it supports the open source [Bluesky](https://github.com/alan-turing-institute/bluesky) simulator)

- [aviary](https://github.com/alan-turing-institute/aviary) - package for generating ATC scenarios and performance evaluation metrics (dependency of Bluebird)

- [Dodo](https://github.com/alan-turing-institute/dodo) - scaffold for building ATC agents, which provides commands for communicating with BlueBird in Python (PyDodo) and R (rdodo)

- [Twitcher](https://github.com/alan-turing-institute/twitcher) - front-end for BlueBird for monitoring the simulation

With an ATC simulator (e.g., BlueSky) and BlueBird running, one can observe and interact with the simulation via BlueBird using Python (PyDodo), R (rdodo) or Twicher. The aviary package allows one to synthetically generate ATC scenarios of increasing complexity to train agents on and provides metrics to score performance. The scenarios and metrics were developed so as to be relevant to real world ATC operations as well as suitable for research. Altogether this infrastructure allows one to focus on running experiments in automated air traffic control and is compatible with testing different approaches, from optimisation algorithms to reinforcement learning.

![](./docs/img/simurgh-deps.png)

## Quick Start

The above figure shows the dependency flow. One needs to have BlueSky running before BlueBird can operate.
Twicher and Dodo similarly require BlueBird to be running in order to work.

### 1. Run BlueBird and BlueSky (& Twicher) with Docker

The easiest way to run BlueBird and BlueSky is through [Docker](https://www.docker.com)
(see [below](#running-bluesky-and-bluebird-locally) for instructions on how to run BlueSky and BlueBird locally rather than using Docker).

If you have Docker installed, clone this repo and run:

```
docker-compose up -d
```

This pulls down the pre-built images from DockerHub and
starts each container in the right order. Then all one needs to do is go to
`http://localhost:8080` where Twitcher will be running.

_Note_: If this is the first time running this command, it may take some time to
download and extract all the layers involved.

Then to close this, run:

```
docker-compose down
```

This will shutdown the running instances.

### 2. Install PyDodo

PyDodo is the Python implementation of Dodo.

To install:

```bash
git clone https://github.com/alan-turing-institute/dodo.git
cd dodo/Pydodo
pip install .
```

If BlueSky and BlueBird are running, then one can communicate with the simulator (via
BlueBird) using PyDodo:

```python
>>> import pydodo
>>>
>>> pydodo.reset_simulation()
True
>>>
```

Success!

See the Dodo [specification document](https://github.com/alan-turing-institute/dodo/blob/master/Specification.md) for a detailed overview of the supported commands.

### 3. Example usage

The [example notebook](https://github.com/alan-turing-institute/simurgh/blob/issue/6/example-agent-notebook/examples/Example-pipeline.ipynb) shows how to interact with the simulation using PyDodo and gives a simple example of how to train an AI agent to act as an ATCO.

## Running BlueSky and BlueBird locally

This section describes how to install and run BlueSky and BlueBird locally rather than using pre-built Docker images.

All instructions below assume one has cloned the `simurgh` repository along with all the submodels.
When cloning `simurgh` be sure to run:

```bash
git clone --recurse-submodules -j8 git@github.com:alan-turing-institute/simurgh.git
```

### 1. Install dependencies

All dependencies for BlueSky and BlueBird are specified in the `environment.yml` file.
To create a conda environment called `nats37` with all the required dependencies run:

```bash
conda env create -q && conda activate nats37
```

We can check BlueSky dependencies are OK by running `check.py` inside the Bluesky repository.

Running `python bluesky/check.py` will produce the following output:

```bash
(nats37) $$ python bluesky/check.py
This script checks the availability of the libraries required by BlueSky, and
the capabilities of your system.

Checking for numpy               [OK]
Checking for scipy               [OK]
Checking for matplotlib          [OK]
Checking for pyqt                [QT5]
Checking for pyopengl            [OK]
OpenGL module version is         [3.1.0]
Checking GL capabilities         [OK]
GL Version at least 3.3          [OK]
Supported GL version             [4.1]
Checking for pygame              pygame 1.9.6
Hello from the pygame community. https://www.pygame.org/contribute.html
[OK]

You have all the required libraries to run BlueSky. You can use both the QTGL
and the pygame versions.
Checking bluesky modules
StateBasedCD: using Python version.
Could not import pyclipper, RESO SSD will not function
Using Open Aircraft Performance (OpenAP) model
Successfully loaded all BlueSky modules. Start BlueSky by running BlueSky.py.

```

If the above command is successful, we can now install Bluesky into the Python path with:

```bash
(nats37) $$ pip install bluesky/
```

### 2. Run BlueSky

Bluesky can now be launched with:

```bash
(nats37) $$ cd bluesky && python Bluesky.py
```

The above command will start the Bluesky simulator with the in built GUI which
looks like:

![](./docs/img/redsky-gui.png)

If one would like to run Bluesky _without_ the default GUI, a headless version
is available with the command:

```bash
(nats37) $$ cd bluesky && python Bluesky.py --headless
```

If one wished to connect the running instance to a remote host this
can be done with:

```bash
(nats37) $$ cd bluesky && python BlueSky.py --client --bluesky_host=1.2.3.4
```

This will skip discovery and attempt a connection to the specified host (using
the default ports).

Now that the instance of the simulator is up and running and connected to the
desired ports, one can now spin up Bluebird, which is the interface layer
between the simulator and the AI agents.

### 3. Run BlueBird

If Bluesky was installed successfully, then it should be as simple as running:

```bash
(nats37) $$ cd bluebird && python run.py
```

This should produce the following output:

```bash
2019-08-08 18:08:31 INFO     bluebird.bluebird: Connecting to client...
Client 0b06b30f connected to host 5dd3f7f1 of version 1.2.1
2019-08-08 18:08:41 INFO     bluebird.cache.sim_state: speed=0x, ticks=   0, time=, state=INIT, aircraft=0
2019-08-08 18:08:41 INFO     bluebird.cache.sim_state: Logging started. Initial SIM_LOG_RATE=0.2
Client active node changed.
 * Serving Flask app "bluebird.api" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: on
 * Running on http://0.0.0.0:5001/ (Press CTRL+C to quit)
2019-08-08 18:08:46 INFO     bluebird.cache.sim_state: speed=0.0x, ticks=   0, time=00:00:00, state=INIT, aircraft=0

```

## Documentation

The documentation for this project can be found at https://alan-turing-institute.github.io/simurgh/
Alternatively one can build and view these locally if one has `mkdocs`
installed. To do this, in the top level of this repository, run:

```bash
mkdocs serve
```

The corresponding _readthedocs_ can be found on `localhost:8000`

NOTE. If files are removed from 'docs/' in between builds, they make
still hang around, a better command to run would be:

```bash
mkdocs build --clean
```

When docs have been built, they can then be deployed online to the public facing
project page [here](https://alan-turing-institute.github.io/simurgh/) with the
following command:

```bash
mkdocs gh-deploy
```

This will produce the following output:

```bash
INFO    -  Cleaning site directory
INFO    -  Your documentation should shortly be available at: https://alan-turing-institute.github.io/simurgh/
```

## Contributing

The project is still under development. We welcome contributions to all elements of the project.
