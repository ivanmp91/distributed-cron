distributed-cron
================
Distributed Cron is a set of perl scripts that uses gearman job servers and the API to send tasks in a queue to the job servers and then the different workers runs the script that identifies a task. Basically the workers runs the script cron_worker.pl that will gets all the tasks name from the job server and will runs the script defined in the json file.
The clients just will send the name of the task to the job server that will gets the worker servers. To run the client script we've to run the script cron_client.pl with the --tasks parameter that accepts the name of one or more tasks separated by spaces. Usage example:

./cron_client.pl --tasks task1 task2

PROJECT DIRECTORY STRUCTURE
================
- bin: we've the scripts for the workers & clients.
- client: perl modules for the gearman clients.
- worker: perl modules for gearman workers.

For more information about Gearman see: http://gearman.org/documentation/

DEPENDENCIES
================
- Perl modules dependencies:
	JSON
	utf8::all
- Install Gearman modules for the workers:
	Gearman::Worker

- Install Gearman modules for the clients:
	Gearman::Client

- For the job servers you can install the packages from the repositories:
	gearman-job-server

CONFIGURATION
================

- Create the directory /etc/perl/cron/dist/

- Copy the worker && client directory inside /etc/perl/cron/dist/ on the different servers.

- Edit the configuration file /etc/perl/cron/dist/worker/conf.json on the workers servers. Parameters:
	- job_servers: contains multiple server and port values.
	- server: ip address or host name for the gearman job server.
	- port: tcp port for the daemon.
	- jobs: List for all the tasks that the workers support. Each task has an identifier that it's the first parameter and the value,
	is the path to the script to run.
	- debug: If is true the worker will send the name of the task run and the time executed to syslog. By default it sends with the facility user and info priority.

- Edit the configuration file /etc/perl/cron/dist/client/conf.json on the client server. Parameters:
	- job_servers: contains multiple server and port values.
	- server: ip address or host name for the gearman job server.
	- port: tcp port for the daemon.


 
