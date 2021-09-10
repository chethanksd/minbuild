# minbuild

minbuild scripts speeds up your build system setup for C/C++/Assembly projects and it is completly makefile based which avoid installation of additional tools.

## features

 1) can support multiple projects with different configurations
 2) can quickly create new projects by using user defined templates
 3) supports incremental build even when dependencies of source file are changed
 4) supports execution of user defined pre-compilation & post-compilation scripts

## usage

You can have single project or multiple projects in your workspace in any directory tree format. The makefile (or called as entry makefile) in this repository should be configured according to your target needs. When you issue make command, this entry makefile should be the one that gets executed first. 

When you open the makefile you see list of below configurations:

### ROOT

Optional configuration to specify root path of your workspace or project. Not used anywhere in the minbuild scripts

### BUILD_PATH

Specify build output directory

### PRJ_PATH

Specify solution directory where you can have multiple projects

### SCRIPT_PATH

Specify path of minbuild scripts

### DEFAULT_PROJECT

Specify name of default project

### ARGS

Opitonal configuration to specify default argument to pass when you run the final executables


## How to create new project

Type following command to create new project in PRJ_BUILD path

make PROJ=<new_project> new

## How to trigger build

make PROJ=<project>

Note: PROJ Argument is optional here, when not specified DEFAULT_PROJECT will taken

## How to clean build

make PROJ=<project> clean

Note: PROJ Argument is optional here, when not specified entire BUILD_OUTPUT directory will be cleaned

## How to run final executable

make PROJ=<project> ARGS<arugments> run

Note: 
1) PROJ Argument is optional here, when not specified DEFAULT_PROJECT will taken
2) ARGS is also optional
