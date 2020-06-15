# Simurgh documentation

How to edit the Simurgh documentation website.

The main content is in markdown files that correspond to the top-level menu items:

- `index.md` - the landing page
- `getting_started.md` - instructions on how to get everything running
- `contributing.md` - contributing guidelines
- `docs.md` - general overview of the structure of the project
- `user-docs/` - folder containing user documentation of the individual parts of the project
    - `user-docs/bluesky.md` - running the simulator
    - `user-docs/bluebird.md` - communicating with the simulator via Bluebird API
    - `user-docs/dodo.md` - using PyDodo and RDodo
    - `user-docs/aviary.md` - generating scenarios
    - `user-docs/agent.md` - workflow for creating an agent, OpenAI Gym interface

## Changing the website navigation

If you want to add a new page to the website, please add a markdown file with the content and edit `_data/navigation.yml` file to add it to the navigation menu.

## Editing team members

Use the `_data/team.yml` file to add/edit team members.

# Working on the website locally

The website folder contains `.devcontainers` folder that can be used in [VS Code Insiders](https://code.visualstudio.com/insiders/) for building the website locally in a Docker container, without installing Jekyll on your system. 

To build and view locally, open the `docs` folder in VS Code Insiders and run the `Remote containers: Open in container` command. This builds/runs a Docker container with a working Jekyll installation. Open the integrated VS Code terminal and run the standard commands to build the website:

```
bundle install
bundle exec jekyll serve --baseurl ""
```
