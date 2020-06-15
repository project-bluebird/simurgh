---
title: Documentation
subtitle: The project is under development
layout: page
show_sidebar: false
hero_height: is-medium
hero_image: img/img-hero.png
---

# Project structure

The Simurgh project contains several elements that all work together to form an air traffic simulation platform; these are:

- [Bluesky](https://github.com/alan-turing-institute/bluesky) - open source air traffic simulator, a lightly adapted from the [Bluesky simulator](https://github.com/TUDelft-CNS-ATM/bluesky) developed at TU Delft

- [Bluebird](https://github.com/alan-turing-institute/bluebird) - a Flask-based API that handles communication with multiple air traffic simulators (it supports the open source [Bluesky](https://github.com/alan-turing-institute/bluesky) simulator)

- [Aviary](https://github.com/alan-turing-institute/aviary) - package for generating ATC scenarios and performance evaluation metrics (dependency of Bluebird)

- [Dodo](https://github.com/alan-turing-institute/dodo) - scaffold for building ATC agents, which provides commands for communicating with BlueBird in Python (PyDodo) and R (rdodo)

- [Twitcher](https://github.com/alan-turing-institute/twitcher) - front-end for BlueBird for monitoring the simulation

![Dependency diagram for Simurgh](/img/simurgh-deps.png)