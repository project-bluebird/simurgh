As mentioned previously the dependency flow is quite important and as such one
needs to have Bluesky running before Bluebird can operate. Furthermore Twitcher
and DoDo require Bluebird to be running in order for them to work. Therefore, to
get things up and running, the installation is advised to be done sequentially
as laid out in the sections below

![](img/simurgh-deps.png)

## Bluesky

Original instructions can be found at [TUDelft-CNS-ATM/bluesky wiki](https://github.com/TUDelft-CNS-ATM/bluesky/wiki)

However, it has been found to be much easier to have a single conda `environment.yml` file instead
```bash
# This file may be used to create an environment using:
# $ conda env create --name <env> --file <this file>
# platform: linux-64
name: nats

channels:
  - conda-forge

dependencies:
  - python=3.6
  - pyqt
  - numpy
  - scipy
  - matplotlib
  - pandas
  - r-base

  - pip:
    - flask
    - flask_cors
    - flask_restful
    - markdown
    - msgpack
    - python-dotenv
    - pyzmq
    - pygame
    - pyproj    # birdhouse dep
    - pyqtwebengine
    - pyopengl
    - pyopengl-accelerate
    - psutil==5.5.*
    - pytest==4.1.*
    - pylint==2.2.*
    - pylint-exit==1.0.*
```

In the `simurgh/` directory, one can create the desired conda environment with
the commands below:
```bash
conda env create -q && conda activate nats
```

Now that dependencies are installed for both Bluesky & Bluebird, we can at least
check that these are OK by running `check.py` inside the Bluesky repository.

Running `python bluesky/check.py `will produce the following output:

```bash
(nats) $$ python bluesky/check.py
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

The above command only checks the dependencies for Bluesky, if it was indeed
successful, we can now install Bluesky into the Python path with:

```bash
(nats) $$ pip install bluesky/
```

From here, all the necessary items should be installed, Bluesky can now be
launched with:
```bash
(nats) $$ cd bluesky && python Bluesky.py
```

The above command will start the Bluesky simulator with the default GUI which
looks like:

![](img/redsky-gui.png)

If one would like to run Bluesky _without_ the default GUI, a headless version
is available with the command:

```bash
(nats) $$ cd bluesky && python Bluesky.py --headless
```

If perhaps the user wished to connect the running instance to a remote host this
can be done with:

```bash
(nats) $$ cd bluesky && python BlueSky.py --client --bluesky_host=1.2.3.4
```
This will skip discovery and attempt a connection to the specified host (using
the default ports)

Now that the instance of the simulator is up and running and connected to the
desired ports, one can now spin up Bluebird, which is the interface layer
between the simulator and the AI agents.

## Bluebird

If Bluesky was installed successfully, then it should be as simple as running:
```bash
(nats) $$ cd bluebird && python run.py
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

Now we have the simulator running, and the interface that sits on top up and running, we can
now connect our AI agents.

## DoDo

![](img/dodo-bird.png)

Assuming one has cloned `simurgh` along with all submodules, it should be the
case one can then install `Pydodo` with:

```bash
cd dodo/Pydodo
pip install .
```
Then to check if this worked:
```python
>>> import pydodo
>>>
>>> pydodo.reset_simulation()
True
>>>
```
_Success!_

## Birdhouse

Birdhouse requires Bluesky and Bluebird to both be running in order to get
working.

```bash
>>> import pydodo
>>> pydodo.all_positions()
Empty DataFrame
Columns: [altitude, ground_speed, latitude, longitude, vertical_speed]
Index: []
```

```bash
python run.py default_input_agents_read_scn.ini
```

## Twitcher (Optional)
