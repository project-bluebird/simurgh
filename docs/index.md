# Welcome to Simurgh

*Simugh* pronounced _Seymour_ is a project that aims to develop a research-focused
open source simulation platform, along with a user-friendly interface for
evaluating different machine learning algorithms for real-time decision-making,
from optimisation approaches to reinforcement learning, in a complex and
uncertain environment.

Air traffic control is a complex task requiring real-time planning under
uncertainty, predicting potential conflicts and issuing commands to aircraft
pilots to ensure safety. This project investigates machine learning methods that
can be applied to this domain and could in future help air traffic controllers
in effective decision-making. Using simulations similar to training scenarios
for actual air traffic controllers, the project builds an open experimentation
platform to evaluate possible machine learning approaches to this task, and
explores algorithms to 'play' the simulation in the role of air traffic
controllers.

The [Simurgh](https://en.wikipedia.org/wiki/Simurgh) project contains several
elements that all work together to achieve the aims laid out above; these are:

- [Bluesky](https://github.com/alan-turing-institute/bluesky) - open source air traffic simulator

- [Bluebird](https://github.com/alan-turing-institute/bluebird) - server that handles communication between Bluesky and air traffic control agents

- [Twitcher](https://github.com/alan-turing-institute/twitcher) - front-end for monitoring the simulation

- [Dodo](https://github.com/alan-turing-institute/dodo) - scaffolds for ATC agents in Python, R, and potentially other languages

- [NATS birdhouse](https://github.com/alan-turing-institute/nats-birdhouse) - some ATC agents (currently in Python)

In order to get things up and running, it is important to emphasise the
dependencies tree of the packages outlined above.

![](img/simurgh-deps.png)

A full step-by-step installation guide can be found at: `www.placeholder-website-name.com>`.

However, if one would like to get up and running immediately this set of
commands will install all dependencies and start the application using Docker by
running:

```bash
source install.sh
```

This will create a conda environment call `nats` and install all necessary
dependencies required. Please see User Guide for how to get going.

