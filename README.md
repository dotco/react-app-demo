# react-app-demo

A minimal example of a single page app project which uses [react-app][]. You can
use this as a starting poing for your new project, just fork and change a few
credentials in `package.json`.

## Development process

This project has `Makefile` which assists you in common tasks, just type:

    % make help

to see what's available:

    Usage: make <action name>

    Available actions:
      install     	install all dependencies (default action)
      develop     	start development server
      build       	build all js and css bundles
      build-report	report build artifacts size
      clean       	remove build artifacts
      help        	show help


The first step is probably `make install` to install all needed deps followed by
`make develop` to start working on app.

## Application structure

    ├── Makefile          - project actions and build instructions
    ├── LICENSE           - MIT License (change if you want to)
    ├── README.md         - this file
    ├── package.json      - npm package definition
    ├── .gitignore        - git ignore
    └── ui                - your application
        ├── assets        - static assets are served from here
        ├── index.css     - entry point for CSS stylesheets
        └── index.jsx     - entry point for your application

[react-app]: https://github.com/andreypopp/react-app
